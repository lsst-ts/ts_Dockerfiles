#!/usr/bin/bash

# setup colors
b=$(tput bold)
r=$(tput rev)
R=$(tput setaf 1)
Y=$(tput setaf 3)
N=$(tput sgr0)

if [ "$1" == "bare" ]; then
  shift
  echo "${Y}Executing bare bash with arguments${N}: $@"
  exec "bash" "$@"
fi

cd /home/saluser
source .setup_salobj.sh
export LSST_DDS_PARTITION_PREFIX=test

if [ "$#" -eq 0 ]; then
  echo """
${R}No parameter specified, dropping you to a shell.${N} Supported docker run parameters:
  ${b}bare${N} - run bare container, don't source SAL/DDS setup files, don't setup environment
  ${b}SS${N} - run M1M3 Support System simulator
  ${b}TS${N} - run M1M3 Thermal System simulator
  ${b}VMS${N} - run VMS simulator. Allowed options are M2, M1M3, Rotator (or CameraRotator). Empty will run all VMS subsystems.
"""
  exec "bash"
fi

function run_command {
  par=$(echo $1 | tr [:lower:] [:upper:])
  case $par in
    SS)
      subsystem=MTM1M3
      ;;
    TS)
      subsystem=MTM1M3TS
      ;;
    VMS)
      subsystem=MTVMS
      ;;
    *)
      echo "${R}Unknown command subsystem - $par. ${Y}Allowed are SS, TS or VMS.${N}"
      exit 2
      ;;
  esac
  shift
  cmd=$1
  shift
  cd repos/ts_sal/test/${subsystem}/cpp/src
  ./sacpp_${subsystem}_${cmd}_commander $*
}

par=$(echo $1 | tr [:lower:] [:upper:])
shift

case $par in
  SS)
    cd repos/ts_m1m3support
    ./ts-M1M3supportd -f -c /home/saluser/repos/ts_m1m3support/SettingFiles $*
    ;;
  TS)
    cd repos/ts_m1m3thermal
    ./ts-M1M3thermald -f $*
    ;;
  VMS)
    cd repos/ts_vms
    case $1 in 
      M1M3 | M2 | CameraRotator | Rotator)
        subsystem=$1
        case $subsystem in
          Rotator)
            subsystem=CameraRotator
            ;;
        esac

        shift
        ./ts-VMSd -f -c /home/saluser/repos/ts_vms/SettingFiles/${subsystem} $*
        ;;
      "")
        echo "${Y}Executing all VMS.${N} ${r}In need of only one specific VMS? Just append it after VMS on docker run line.${N}"
        shift

        pids=()
        for subsystem in M1M3 M2 CameraRotator; do
          ./ts-VMSd -f -c /home/saluser/repos/ts_vms/SettingFiles/${subsystem} $* &
          pids+=($!)
        done
        
        # wait for VMS pids
        for pid in ${pids[*]}; do
          wait $pid
          echo "${Y}Process ${b}$pid${N}${Y} ends."
        done
        ;;
      *)
        echo "${R}Unknown option for VMS - $1. ${Y}Allowed are M1M3, M2 or CameraRotator.${N}"
        exit 1
        ;;
    esac
    ;;
  COMMAND | CMD)
    run_command $*
    ;;
  *)
    echo "${Y}Unknown argument $par, executing shell${N}"
    exec "bash"
    ;;
esac

exec "$@"
