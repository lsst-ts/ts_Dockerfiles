# MTM1M3 GUI container

When using GUI for simulated run (without HW), it's advisable to run mtm1m3_sim
container as well (on the same host computer). That will allow GUI to command
simulated M1M3 SS.

# Running under MacOS

To run X11 application under MacOS, you need to setup Quartz:

1. Install XQuartz: https://www.xquartz.org/
2. Launch XQuartz. Under the XQuartz menu, select Preferences
3. Go to the security tab and ensure "Allow connections from network clients" is checked.

After that, do this for every run of the GUI (assuming image name is m1m3_gui):

```bash
xhost +localhost
docker run -ti -e DISPLAY=host.docker.internal:0 m1m3_gui
```
