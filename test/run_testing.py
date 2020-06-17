import asyncio
import logging
import sys

from lsst.ts import salobj

stream_handler = logging.StreamHandler(sys.stdout)

logger = logging.getLogger()
logger.addHandler(stream_handler)
logger.level = logging.DEBUG


def run_tasks(tasks):
    return asyncio.get_event_loop().run_until_complete(asyncio.gather(*tasks, return_exceptions=True))    

def show_acks(acks, cscs):
    for key, acks in zip(cscs.keys(), acks):
        try:
            ack_value = ack.ackcmd.ack
            ack_error = ack.ackcmd.error
            ack_result = ack.ackcmd.result
        except AttributeError:
            ack_value = ack.ack
            ack_error = ack.error
            ack_result = ack.result
        print(f"{key}: ack={ack_value}, ack.error={ack_error}, ack.result={ack_result}")
#    except salobj.AckError as ae:
#        print(f"Failed with ack={ae.ackcmd.ack}, ack.error={ae.ackcmd.error}, ackcmd.result={ae.ackcmd.result}"
#    return output

def make_maintel_remotes():
    d = salobj.Domain()
    MTMount = salobj.Remote(d, "NewMTMount")
    MTPtg = salobj.Remote(d, "MTPtg")
    MTAOS = salobj.Remote(d, "MTAOS")
    M2 = salobj.Remote(d, "MTM2")
    M1M3 = salobj.Remote(d, "MTM1M3")
    M2Hex = salobj.Remote(d, "Hexapod", index=2)
    CamHex = salobj.Remote(d, "Hexapod", index=1)
    Rotator = salobj.Remote(d, "Rotator")

    return {"MTMount": MTMount, "MTPtg": MTPtg, "MTAOS": MTAOS, "M2": M2, "M1M3": M1M3, "M2Hex": M2Hex, "CamHex": CamHex, "Rotator": Rotator}

def make_maintel_config():
    return {"MTMount": None, "MTPtg": None, "MTAOS": None, "M2": None, "M1M3": "Default", "M2Hex": None, "CamHex": None, "Rotator": None}

def make_comcam_remotes():
    d = salobj.Domain()
    CCArchiver = salobj.Remote(d, 'CCArchiver')
    CCCamera = salobj.Remote(d, 'CCCamera') 
    CCHeaderService = salobj.Remote(d, 'CCHeaderService')
    
    return {"CCArchiver": CCArchiver, "CCCamera": CCCamera, "CCHeaderService": CCHeaderService}

def make_comcam_config():
    return {"CCArchiver": None, "CCCamera": "Normal", "CCHeaderService": None}

def start_cscs(cscs):
    tasks = [getattr(x, "start_task") for x in cscs.values()]
    return tasks

def command_cscs(cscs, configs, command, timeout=15):
    tasks = []
    for key, value in cscs.items():
         cmd = getattr(value, f"cmd_{command}")
         if command == "start":
             cmd.set(settingsToApply=configs[key])
         tasks.append(cmd.start(timeout=timeout))
    return tasks
 
