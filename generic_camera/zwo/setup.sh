
source ~/miniconda3/bin/activate
source $OSPL_HOME/release.com

while :
    do
        run_genericcamera.py -i $INDEX
        echo "# CSC exited, restarting..."
done
