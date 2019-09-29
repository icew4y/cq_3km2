WELCOME TO RAIZE COMPONENTS VERSION 4

CONTENTS
========
  Completing the Raize Components 4 Installation
  C++Builder Developers and Uxtheme.h
  Moving Raize Components 4 Palettes to Front
  Uninstalling Raize Components 4
  What's New in Raize Components 4
  Minimum system requirements
  Contacting Raize Software, Inc.


COMPLETING THE RAIZE COMPONENTS 4 INSTALLATION
==============================================
  Once the installation program is complete you may begin using the
  Raize Components in Delphi and C++Builder versions 5 and higher.  
  Restart Delphi or C++Builder and you will see the following pages 
  on the component palette:

    Raize Panels
    Raize Edits
    Raize Lists
    Raize Buttons
    Raize Display
    Raize Shell
    Raize Widgets

    
C++BUILDER DEVELOPERS AND UXTHEME.H
===================================
  Although C++Builder 2007 is essentially VCL compatible with BDS 2006,
  in creating the new version, CodeGear did fix some issues regarding
  the theme headers. The result is a conflict in a header file that is
  included with Raize Components: Uxtheme.h.
                                           
  The install program renames the RC4\Lib\BDS2006\Uxtheme.h file to
  Uxtheme.hxx if CodeGear RAD Studio 2007 is one of the selected IDEs.
  This will eliminate the conflict when compiling in C++Builder 2007.
  
  However, if you also need to use the C++Builder personality in 
  Borland Developer Studio 2006, then the Uxtheme.hxx file must be
  renamed back to Uxtheme.h.

  If you will be switching between C++Builder 2007 and C++Builder 2006
  frequently, then an alternative approach would be to copy the
  RC4\Lib\BDS2006 directory to RC4\Lib\BDS2007 and in the BDS2007
  directory, simply delete the Uxtheme.h file.  Please note that you
  will also need to update the LIB and INCLUDE file paths in
  C++Builder 2007 to reflect the new directory.  

    
MOVING RAIZE COMPONENTS 4 PALETTE PAGES TO FRONT
================================================
  During the installation, the appropriate Raize Components design
  packages are loaded into the selected Delphi, C++Builder, and 
  Borland Developer Studio IDEs.  Unfortunately, when you restart
  the IDE, the component palette pages for Raize Components will 
  appear at the end of the component palette.

  If you would like to move the Raize pages to the front of the
  palette, there is an a easier way to do this than by manually
  dragging them.  Located in the Bin directory is a program called
  MoveRCPagesToFront.exe, which will move all of the RC pages
  for you automatically to the front of the palette.

  Simply run the MoveRCPageToFront.exe program and follow the 
  instructions.
  

UNINSTALLING RAIZE COMPONENTS
=============================

  To remove Raize Components from your computer, follow the directions below.

  Removing the components from the component palette
  ================================================== 

  Delphi and C++Builder (versions 5 and higher)
  ---------------------------------------------
  Close all files and projects, and select Component|Install Packages... to
  display the Packages page in the Project Options dialog.

  Select the "Raize Components 4.x" package from the Design Packages list 
  and click the Remove button. A message box will be displayed to confirm your 
  request--press OK.  Next, you will be asked if a runtime package should be 
  removed from the Runtime Packages list.  Click OK to remove the package.  

  Next, select the "Raize Components 4.x (Data-Aware)" package from the 
  Design Packages list and click the Remove button. Again, a message box will 
  be displayed to confirm your request--press OK.  Next, you will be asked if 
  a runtime package should be removed from the Runtime Packages list.  Click 
  OK to remove the package.  

  Close the Project Options dialog box by clicking the OK button.


  Removing the component files from your hard disk
  ================================================

  At this point, Delphi and/or C++ Builder are no longer using Raize 
  Components.  To remove the Raize Components files from your hard disk 
  open the Add/Remove Programs icon from the Control Panel. Next, select the
  "Raize Components 4.0" entry from the list of installed programs, and then
  click the Remove button.


WHAT'S NEW IN RAIZE COMPONENTS 4
================================
  For a complete description of enhancements and architecture changes please
  read the "What's New" section in the Raize Components help file. The help
  file is located in the Help subdirectory of the Raize Components installation
  directory (e.g. C:\Program Files\Raize\RC4\Help). You can also gain access to
  the help file by selecting Help|Contents from within Delphi or C++Builder and 
  then select the Raize Components 4.x entry on the contents page.


MINIMUM SYSTEM REQUIREMENTS
===========================
  Raize Components 4 requires:
  
  At least one of the following compilers:

    CodeGear RAD Studio 2007 / Delphi 2007 / C++Builder 2007                    
    Borland Developer Studio 2006
    Delphi 2005 - Update 3 
    Delphi 7 _ Update 1
    Delphi 6 - General Update 2
    Delphi 5 - Update 1
    C++Builder 6  
    C++Builder 5 - Update 1
  
  Hard Disk Space Requirements:  
  
    20 MB + 10 MB for each compiler to be supported
  


CONTACTING RAIZE SOFTWARE, INC.
===============================
                    
  Technical Support

    Newsgroups: (news.raize.com news server)
      raize.public.rzcomps.install
      raize.public.rzcomps.support
    
    Email:
      support@raize.com
      

  General Information  
    
    Website: 
      http://www.raize.com
  
    Email:
      sales@raize.com
  
================================================================================
 Unless otherwise noted, all materials provided in this release
 are Copyright © 1995-2007 by Raize Software, Inc.  All rights reserved.
=====================================END========================================
