# Electrometer

Building the image requires the electrometer_version argument which is a git tag/branch.
Running the image by default expects that an electrometer be plugged into /dev/ttyUSB0, otherwise change the line in the docker-compose.yaml.


## Adding a udev rule
Please follow this guide at https://rts2.org/wiki/doku.php?id=howto:set_symlinks_for_usb_serial_ports
Add the following rule to a file called 10-local.rules in the rules.d folder.
This assumes that you are using a Prolific Serial to USB adapter.
That's the Vendor and Product ID in the rule.
Another adapter would have a different id.

    SUBSYSTEM=="tty" ATTRS{idProduct}=="2303", ATTRS{idVendor}=="067b", SYMLINK+="electrometer", GROUP="dialout"