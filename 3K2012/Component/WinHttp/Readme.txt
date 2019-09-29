########################################################
         ----------------------------------
                      WinHTTP
                    SOURCE CODE

             for Delphi and C++ Builder
                   Version 3.2.6
         ----------------------------------

          Legal: (c) 1999-2006 Utilmind Solutions
          Email: info@appcontrols.com
            Web: http://www.appcontrols.com
                 http://www.utilmind.com
########################################################

TABLE OF CONTENTS

    1. Welcome / Introduction
        1.1 Compatiblity
    2. Installation
        2.1 Note for C++ Builder developers
    3. Problems

1. Welcome
----------------------------------------------------
The WinHTTP is easy to use WinInet-based HTTP client component
which allows to post and get any data from the Web via HTTP
protocol. With WinHTTP you can grab Web pages, download files
and documents (or only their headers without the content), get
results of the CGI programs (for example, results of web-based
search engines / databases), or even upload files
to the CGI programs.

In case if you want download documents from local intranet -
just specify FILE:// prefix in the URL instead of HTTP:// (or HTTPS://).

The WinHTTP can grab web contents both in binary and text
formats, supports cache of Internet Explorer, can resume broken
downloads, read data from password protected directories and
supports and automatically supports several proxy authentication
schemes (basic, digest, NTLM etc).

Also it can be used in ActiveX forms, for example to build Web-based
installation programs.


1.1 Compatibility
=================
WinHTTP compatible with Delphi 2/3/4/5/6/7/2005, BDS 2006, and BCB 3/4/5/6 and
has been tested on Win95, Win95OSR2, Win98, WinME, NT4, Win2K and WinXP.


2. Installation
----------------------------------------------------
 1. Unzip files from "Sources" directory to your "..\Lib" directory.
 2. Start Delphi / C++ Builder IDE.
 3. Select "Component \ Install..." menu item.
 4. Press "Add" button and select "_AUReg.pas" file.
 5. Rebuild library.

NOTE: Delphi 2 requires "WinInet.pas" unit which can be found in
"Sources\Delphi2" directory. Please copy it to "..\Lib" directory too
if you're using Delphi 2.

2.1. Note for C++ Builder developers
===============================
When you are using the Internet components (i.e: WinHTTP), please
don't forget to add INET.LIB to your project (it can be found at
"CBuilder\Lib" directory). This file contains the references to routines
from WinInet.dll. So if you got linker error such like following:
  [Linker Error] Unresolved external 'InternetCrackUrlA' referenced from
  C:\PROGRAM FILES\BORLAND\CBUILDER5\PROJECTS\LIB\WINHTTPCB5.LIB
please don't worry and be aware that InternetCrackUrlA are used to parse
the URL (split URL to domain name, port, document name etc). To solve
this problem, just add INET.LIB to your project (use "Project | Add to
project" menu item in C++ Builder IDE).


3. Problems
----------------------------------------------------
If you have any problems during the setup or using this
component, please visit the support area of our website
at http://www.appcontrols.com or contact us: info@appcontrols.com

    
Good Luck!

UtilMind Solutions
info@utilmind.com
http://www.utilmind.com
http://www.appcontrols.com
