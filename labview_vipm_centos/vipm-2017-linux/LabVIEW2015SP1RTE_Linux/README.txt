LabVIEW 2015 Service Pack 1 Readme for GNU/Linux
------------------------------------------------------------------
December 2015

--------------------------------------------------------------------------------
This file contains important information about LabVIEW 2015 Service Pack 1 (SP1)
for Linux, including system requirements, installation instructions, known 
issues, and a partial list of bugs fixed for LabVIEW.

Refer to the NI website at ni.com for the latest information about LabVIEW 2015 
SP1.

Refer to the labview/readme directory for readme files about LabVIEW add-ons,
such as modules and toolkits.
--------------------------------------------------------------------------------


System Requirements
Installation Instructions
Product Security and Critical Updates
Known Issues
LabVIEW 2015 SP1 (64-bit)
Accessing the Help
Additions to the LabVIEW Help
Bug Fixes
Support for 32-bit Linux Distributions
Legal Information


-----------------------------
System Requirements
-----------------------------

LabVIEW 2015 SP1 for Linux has the following requirements:
Development Environment
- Processor: Pentium 4M (or equivalent) or later (32-bit), Pentium 4 G1 (or
equivalent) or later (64-bit)
- RAM: 1 GB
- Screen Resolution: 1024 x 768 pixels
- Operating System: Red Hat Enterprise Linux Desktop + Workstation 6.5 or later,
openSUSE 13.1 or 13.2, or Scientific Linux 6.5 or later
- Disk Space: 1.1 GB for the complete installation of each bitness, 2.2 GB
for the complete installation of both 32-bit and 64-bit LabVIEW
- Color Palette: LabVIEW and the LabVIEW Help contain 16-bit color
graphics. LabVIEW requires a minimum color palette setting of 16-bit color.
- Temporary Files Directory: LabVIEW uses a directory for storing temporary
files. NI recommends that you have several megabytes of disk
space available for this temporary directory.
- Adobe Reader: You must have Adobe Reader installed to search PDF versions of
all LabVIEW manuals.

Run-Time Engine
- Processor: Pentium III/Celeron 866 MHz (or equivalent) or later (32-bit),
Pentium 4 G1 (or equivalent) or later (64-bit)
- RAM: 256 MB
- Screen Resolution: 1024 x 768 pixels
- Operating System: Linux kernel 2.6x or 3.x, and GNU C Library (glibc)
Version 2.11 or later for the Intel x86 architecture (32-bit), Linux kernel
2.6x or 3.x, and GNU C Library (glibc) Version 2.11 or later for the Intel
x86_64 architecture (64-bit)
- Disk Space: 108 MB (32-bit), 98 MB (64-bit)
- Color Palette: N/A
- Temporary Files Directory: N/A
- Adobe Reader: N/A

Note: NI recommends that you use Firefox 10.0 or later to
view the LabVIEW Help.


-----------------------------
Installation Instructions
-----------------------------

Depending on whether you are installing LabVIEW for the first time or upgrading
from a previous version, refer to one of the following documents for information
about installing LabVIEW:
- LabVIEW Installation Guide - Includes information about installing LabVIEW,
modules and toolkits, drivers, and hardware.
- LabVIEW Upgrade Notes - Includes information about protecting existing VIs and
projects before you install a new version of LabVIEW, as well as upgrade and
compatibility issues and a complete list of new features in LabVIEW 2015.

Note: 
- If you purchased this product with an NI Software Suite or NI Product 
Bundle, use the installation media that shipped with your purchase to install 
this product.
- You cannot install LabVIEW 2015 SP1 and LabVIEW 2015 on the same computer. 
Installing LabVIEW 2015 SP1 uninstalls LabVIEW 2015 32-bit and 64-bit, if 
installed.


-----------------------------
Product Security and Critical Updates
-----------------------------

Visit ni.com/security for security information about NI products. Visit 
ni.com/critical-updates for information about critical updates from NI.


-----------------------------
Known Issues
-----------------------------

You can access the software and documentation known issues list online. Refer to
the NI website at ni.com/info and enter the Info Code LV2015KI for an up-to-date 
list of known issues in LabVIEW 2015 and LabVIEW 2015 SP1.


-----------------------------
LabVIEW 2015 SP1 (64-bit)
-----------------------------

At the time of release, LabVIEW 2015 SP1 (64-bit) for Linux supports a limited
number of NI drivers, modules, and toolkits. Refer to the NI website at 
ni.com/info and enter the Info Code linux64_compatibility to access the NI 
Product Compatibility for LabVIEW (64-bit) for Linux support document.


-----------------------------
Accessing the Help
-----------------------------

Refer to the LabVIEW Help, accessible by selecting Help»Patents Help from 
LabVIEW, for information about LabVIEW 2015 SP1.


-----------------------------
Additions to the LabVIEW Help
-----------------------------

The following list contains additional changes to LabVIEW that are not included
in the LabVIEW Help, the LabVIEW Upgrade Notes, or both:
- NI does not support remote front panels for Google Chrome starting from 
version 42. Visit ni.com/info and enter the Info Code BlockedPlugin for more 
information.


-----------------------------
Bug Fixes
-----------------------------

Refer to the NI website at ni.com/info and enter the Info Code LV2015BF to 
access the LabVIEW 2015 SP1 bug fix list.


----------------------------------------------------------------
LabVIEW Drops Support for 32-bit Linux Distributions in 2016
----------------------------------------------------------------
LabVIEW will drop support for Intel 32-bit versions of Linux distributions as of 
July 1, 2016. Versions of LabVIEW that ship after July 1, 2016 may install and 
execute on Intel 32-bit distributions, but official support is not provided.


----------------------
Legal Information
----------------------

----
COPYRIGHT:
----

(c) 2004-2015 year National Instruments. All rights reserved.

Under the copyright laws, this publication may not be reproduced or transmitted
in any form, electronic or mechanical, including photocopying, recording,
storing in an information retrieval system, or translating, in whole or in
part, without the prior written consent of National Instruments Corporation.

NI respects the intellectual property of others, and we ask our users to do the 
same. NI software is protected by copyright and otherintellectual property laws. 
Where NI software may be used to reproduce software or other materials belonging 
to others, you may use NI software only to reproduce materials that you may 
reproduce in accordance with the terms of any applicable license or other legal 
restriction.

----
END-USER LICENSE AGREEMENTS AND THIRD-PARTY LEGAL NOTICES:
----

For end-user license agreements (EULAs) and copyright notices, conditions, and
disclaimers, including information regarding certain third-party components used 
in LabVIEW, refer to the Copyright topic of the LabVIEW Help.

----
U.S. GOVERNMENT RESTRICTED RIGHTS:
----

If you are an agency, department, or other entity of the United States
Government ("Government"), the use, duplication, reproduction, release,
modification, disclosure or transfer of the technical data included in this
manual is governed by the Restricted Rights provisions under Federal
Acquisition Regulation 52.227-14 for civilian agencies and Defense Federal
Acquisition Regulation Supplement Section 252.227-7014 and 252.227-7015 for
military agencies.

----
IVI FOUNDATION COPYRIGHT NOTICE:
----

Content from the IVI specifications reproduced with permission from the IVI
Foundation.

The IVI Foundation and its member companies make no warranty of any kind with
regard to this material, including, but not limited to, the implied warranties
of merchantability and fitness for a particular purpose. The IVI Foundation and
its member companies shall not be liable for errors contained herein or for
incidental or consequential damages in connection with the furnishing,
performance, or use of this material.

----
TRADEMARKS:
----

Refer to the NI Trademarks and Logo Guidelines at ni.com/trademarks for 
information on NI trademarks. Other product and company names mentioned herein 
are trademarks or trade names of their respective companies.


----
PATENTS:
----
For patents covering the NI products/technology, refer to the appropriate 
location: Help»Patents in your software, the patents.txt file on your media, or 
the NI Patent Notice at ni.com/patents.