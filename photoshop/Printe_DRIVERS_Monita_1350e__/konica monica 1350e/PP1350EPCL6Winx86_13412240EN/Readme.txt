
                 KONICA MINOLTA PagePro 1350E
               Utilities and Documentation DVD-ROM
                         Readme V1.40



============================================================
I.   INTRODUCTION

     This Readme file contains special information relating
     to the following items:

     - DVD-ROM and Installation Notes
     - Application Notes
     - Connectivity
     - Error Messages
     - PCL6 Printer Driver
     - PCL5e Printer Driver
     - Status Display
     - Documentation 


============================================================
II.  DVD-ROM and Installation Notes

    1. PCL6 Driver and utilities:
       The setup program provided on this DVD-ROM will install 
       the standard printing software components for you, 
       including the following:

          - KONICA MINOLTA PagePro 1350E PCL6 Driver
	    This Driver has some advance features such as 
            N-up Printing, Scaling or Collate at Printer.
            For more details, see Driver Help.	

          - KONICA MINOLTA PagePro 1350E Status Display
	    After installation, you can find Status Display in 
            KONICA MINOLTA PagePro 1350E Folder.
            Use this tool to check Printer Status or set Printer 
            Default settings from your PC.
            
          - KONICA MINOLTA PagePro 1350E Help
	    After installation, you can find the Help in 
            KONICA MINOLTA PagePro 1350E Folder.
            This help include various explanation or hints on how 
            to use your KONICA MINOLTA Printer and Software.

          - KONICA MINOLTA PagePro 1350E Uninstaller
	    After installation, you can find the uninstaller in 
            KONICA MINOLTA PagePro 1350E Folder.
            Run this Uninstaller if you want to remove your KONICA 
            MINOLTA PagePro 1350E Driver and Software,

          - Alternate Drivers for sharing
            If you need to share your printer with clients that use 
            a different Operating System as your computer, please
            refer to section 5. and 6. below.

    2. Add Printer Wizard:
       If necessary, you can also manually start the "Add 
       Printer Wizard" from the Printer Folder with "Add 
       Printer", then point to the correct folder, as follows:
          - Windows 2000, XP, 2003Server, Vista or 7 (32bits)
             PCL6:      \Windows\driver\PCL6\English\Win32
             PCL5e:     \Windows\driver\PCL5e\English\Win32
          - Windows XP, 2003Server, Vista or 7 (64bits)
             PCL6:      \Windows\driver\PCL6\English\Win64
             PCL5e:     \Windows\driver\PCL5e\English\Win64
          - Windows 98/ME
             PCL6:      \Windows\driver\PCL6\English\Win9x
             PCL5e:     \Windows\driver\PCL5e\English\Win9x
          - Windows NT 4.0
             PCL6:      \Windows\driver\PCL6\English\WinNT4
             PCL5e:     \Windows\driver\PCL5e\English\WinNT4

    3. DOS Configuration
       If you need to configure your printer for specific character
       sets or languages under DOS, please use the configuration 
       files provided for DOS at the following location:
           \DOS\English
       A ReadMe file is also provided at this location.

    4. Windows NT4.0 - Install Alternate Driver for Windows 98/ME:
       To install Alternate Driver for Windows 98/ME clients, 
       make sure to enable the "Alternate Driver for Sharing" 
       during driver installation.

    5. Windows 2000/XP/2003Server - Install Alternate Driver 
       for Windows NT 4.0 or for Windows 98/ME clients:
       To install Alternate Driver for Windows NT 4.0 or for 
       Windows 98/ME clients, make sure to enable the "Alternate 
       Driver for Sharing" during driver installation.

    6. Font Manager
       Font Manager is provided on this DVD-ROM to help you 
       manage your fonts in Windows. 
       In some cases, you might encounter an error during 
       installation because some files are in use by the
       DVD-ROM Installer "KONICA MINOLTA PagePro 1350E".
       If you encounter this problem, you may use the 
       following procedure:
           i. Cancel Font Manager installation
          ii. Exit the DVD-ROM Installer
         iii. Browse to the \Utilities\Font Manager directory of your DVD-ROM
              and run SETUP.EXE to proceed with the Font Manager
              installation.
          iv. Once completed, browse to the root directory of 
              your DVD-ROM and run SETUP.EXE to resume the 
              DVD-ROM Installer.


============================================================
III.  APPLICATION NOTES

    1. Extra Character is printed when PC is started
       If you encounter this problem, try following procedure:

          i. Find Drvwppqt.vxd under Windows\System\Iosubsys\
         ii. Move this file to anther directory


============================================================
IV.  CONNECTIVITY

     1. Parallel -- XL Error (Data Missing) is printed
        If you encounter this problem, you may use one 
        of the following methods:
          - If Status Display or Control Panel is running, 
            quit these program, and try to print.
          - If your PC is ECP mode, change to Compatible mode.
            (only for Windows 98/ME)

     2. Parallel -- Extra Character is printed
        If you encounter this problem, you may use one 
        of the following methods:
          - If Status Display or Control Panel is running, 
            quit these program, and try to print again.
          - If your PC is ECP mode, change to Compatible mode.
            (only for Windows 98/ME)

     3. Parallel -- LPT1 Write Error
        If you encounter this problem, you may use one 
        of the following methods:
          - Make sure your printer is ON
          - If Status Display or Control Panel is running, 
            quit these program, and try to print again.
          - If your PC is ECP mode, change to Compatible mode.
            (only for Windows 98/ME)


============================================================
V. ERROR MESSAGES

     1. Invalid Printer Name -- An error message may be
        displayed when installing the printer driver. 
        Remove any spaces from the beginning or end of the 
        printer name text string to resolve this problem.


============================================================
VI. PCL6 PRINTER DRIVER

     1. Can not print some fonts correctly
        If you encounter this problem, you may use one 
        of the following methods:
          - Uncheck "Use Printer True Type Font" on the Quality
            tab of Printer Driver,and try to print again

     2. Can not print some graphics correctly
        If you encounter this problem, you may use the 
        following method:
          - Set All Raster ON on the Quality tab of Printer 
            Driver, and try to print again

     3. Can not print some character when N-up, Scaling 
        or Fit to Paper options are used
        If you encounter this problem, you may use the 
        following method:
          - Change font type to True Type Font such as 
            Arial or Times New Roman on the Application.

     4. Can not Install through Network on Windows 98/ME
        If you encounter this problem, you may use the 
        following procedure:
            i. Install as Local from Setup.exe
           ii. After Install is finished, Open Property of 
               PagePro 1350E Driver from Printer Folder.
          iii. Click Port Tab.
           iv. Click Add Port.
            v. Type Network Path and Printer name or Browse 
               Printer on the Network.
           vi. Click OK.

     5. "Add New Hardware Wizard" appears on Windows 98/ME, even 
         after Printer Driver was installed 
         If you encounter this problem, you may use the 
         following procedure:
            i. Uninstall current Driver.
           ii. Restart PC after Uninstall is completed.
          iii. Install Printer Driver from Setup.exe 
               (Do not install from Plug and Play)

     6. Images are not printing clearly or with rough gradation
        If you encounter this problem, you may use the 
        following method:
          - Disable Fine-Art (select "Fine-Art" Off) on the Quality
            tab of Printer Driver,and try to print again

     7. When using Acrobat 5 under Windows 98/ME, the paper size 
        displayed on the print figure is always Letter.
        If you encounter this problem, you may use one 
        of the following methods:
          - Ignore the incorrect print figure and print as usual
            (Print out will be using the correct paper size)
          - Update Acrobat to version 6 or above

     8. 1200x600dpi printed images may look rougher than 600x600dpi
        1200x600dpi resolution is designed for better text print
        quality. For best photo print quality, it is recommended
        to use 1200x1200dpi.

     9. Collate option generates several print jobs
        If you encounter this problem, you may use one 
        of the following methods:
        - Install additional memory in your printer
        - Disable the "Collate" option from your application 
          and use only the "Collated" option in the Paper 
          tab of the Printer Driver. 

    10. Proof Print option does not work
        If you encounter this problem, you may use one 
        of the following methods:
        - Install additional memory in your printer
        - Disable the "Collate" option from your application 
          and use only the "Collated" option in the Paper 
          tab of the Printer Driver. 


============================================================
VII. PCL5e PRINTER DRIVER

     1. When over 999 copies is set on the PCL5e driver, actual
        printed number of copies is limited to 999 in some cases
        but is not limited in other cases.
        If you encounter this problem, you may use the 
        following method:
          - Make sure to setup maximum 999 copies in the PCL5 driver


============================================================
VIII. STATUS DISPLAY

     1. Incorrect Status information or garbage printing
        This problem may happen if both PCL6 and PCL5e
        drivers are installed on your system and the printer
        is used in LPT mode.
        If you encounter this problem, you may use the 
        following procedure:
            i. Make sure the PCL6 driver is set as default printer
           ii. Use Status Display to monitor the PCL6 driver only
        
============================================================
IX.   DOCUMENTATION 

    Most documentation is accessible from the DVD-ROM menus, 
    but if necessary, it can also be accessed directly from 
    the \Manuals\English folder, as follows:
      - install.pdf                Installation Guide
      - user.pdf                   User Guide
      - reference.pdf              Reference Guide
      - safety.pdf                 Safety Information Guide
      - service.pdf                Service Information Guide
      - setup.pdf                  Setup Guide
      - printmon.pdf               Crown Print Monitor+ Manual
      - devman.pdf                 PageScope Net Care Device Manager Manual
      - devman_checklist.pdf       Check List for PageScope Net Care
                                   Device Manager Installation
      - ndps.pdf                   PageScope NDPS Gateway Manual
      - netsetup.pdf               PageScope Network Setup Manual
      - p2p.pdf                    PageScope Peer to Peer Manual
      - Readme_dvdrom.txt          DVD-ROM Readme (this file)
      - Readme.txt                 PCL6 Drivers Readme
      - Readme_PCL5e.txt           PCL5e Drivers Readme
      - ReadDOS.txt                DOS Readme
      - Readme_linux.txt           Linux Readme
      - Readme_OS_X.txt            Mac OS X Readme
      - Readme_SAP.txt             SAP Readme
      - Readme_devman.txt          PageScope Net Care Device Manager Readme
      - Readme_devman_plugin.txt   PageScope Net Care Device Manager
                                   Plug-In Readme
      - Readme_ndps.txt            PageScope NDPS Gateway Readme
      - Readme_netsetup.txt        PageScope Network Setup Readme
      - Readme_p2p.txt             PageScope Peer to Peer Readme
    Please note that some of the files mentionned above might be 
    unavailable for your device.

============================================================
TRADEMARKS
KONICA MINOLTA is a trademark or a registered trademark of 
KONICA MINOLTA HOLDINGS, INC.
PagePro is a trademark or a registered trademark of 
KONICA MINOLTA BUSINESS TECHNOLOGIES, INC.
All other trademarks are the property of their respective owners.
 
Copyright (c) 2010 KONICA MINOLTA BUSINESS TECHNOLOGIES, INC. 
Portions copyright (c) 1992-2010 Destiny Technology Corporation.
All rights reserved.
