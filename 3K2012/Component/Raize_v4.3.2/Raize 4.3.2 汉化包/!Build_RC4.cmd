@echo off
echo ***************************************************
echo Building Raize Components 4
echo ***************************************************

rem ****************************************************************************
rem **** IMPORTANT NOTES *******************************************************
rem ****************************************************************************

rem     DO NOT MOVE THIS FILE!
rem     THIS COMMAND FILE MUST BE LOCATED IN THE SOURCE DIRECTORY FOR YOUR
rem     INSTALLATION OF RAIZE COMPONENTS 4.
rem
rem     e.g. C:\Program Files\Raize\RC4\Source
                         

rem     ALL APPLICATIONS THAT USE THE RAIZE COMPONENTS 4 RUNTIME PACKAGES
rem     (INCLUDING DELPHI, C++BUILDER, AND BORLAND DEVELOPER STUDIO) MUST BE 
rem     SHUT DOWN BEFORE REBUILDING THE COMPONENTS.


rem ****************************************************************************
rem **** SET CONFIGURATION VARIABLES *******************************************
rem ****************************************************************************

rem     Uncomment the following goto statement after you have initialized the
rem     Configuraion Variables.

goto InitComplete

echo.
echo Build Configuration Variables have not been initialized.  
echo.
echo Before you can execute this command file to rebuild Raize Components, you 
echo must initialize a few configuration variables.  Simply edit the 
echo !Build_RC4.cmd file with a text editor and follow the instructions in the
echo SET CONFIGURATION VARIABLES section. Also, please read the IMPORTANT NOTES
echo section.
echo.
echo Once the configuration variables have been initialized and the
echo !Build_RC4.cmd saved, you can simply run !Build_RC4.cmd file to rebuild
echo Raize Components 4.
echo.
pause
exit

:InitComplete



rem     Change the SysPath variable to the path of your Windows System folder
rem 1、这里修改成你的系统目录:
set SysPath="C:\Windows\System32"


rem     Set Compiler to "Delphi" if building for Delphi 5, 6, 7, or Delphi 2005.
rem     Set Compiler to "BCB" if building for C++Builder 5 or 6.
rem     Set Compiler to "BDS" if building for Borland Developer Studio 2006, BDS 2007 (i.e. Delphi 2007).
rem 2、对照上面的说明，按您的情况进行修改:
set Compiler="BDS"


rem     Change VCLVersion to 5, 6, 7, 9, or 10 depending on version of 
rem     Delphi/C++Builder/BDS you are using
rem
rem     BDS 2007 (Delphi 2007)    VCLVersion="10"   BDS 2007 & 2006 use same VCL
rem     BDS 2006                  VCLVersion="10"
rem     Delphi 2005               VCLVersion="9"
rem     Delphi 7                  VCLVersion="7"
rem     Delphi 6                  VCLVersion="6"
rem     Delphi 5                  VCLVersion="5"
rem     C++Builder 6              VCLVersion="6"
rem     C++Builder 5              VCLVersion="5"
rem 3、对照上面的说明，按您的情况进行修改:
set VCLVersion="10"


rem     Change the DCC32EXE variable to specify the full path of the DCC32.exe 
rem     command line compiler located in your Delphi/C++Builder/BDS Bin 
rem     directory
rem 4、对照上面的说明，按您的情况进行修改:
set DCC32EXE="F:\Program Files\Delphi_2007\bin\DCC32.exe"
                                            

rem     If you are building for C++Builder (Compiler=BCB), change the TLIB 
rem     variable to specify the full path of the TLIB.exe command line tool 
rem     located in your C++Builder Bin folder.
rem     NOTE: This is not necessary if using C++ in Borland Developer Studio.
rem 5、对照上面的说明，按您的情况进行修改:
set TLIB="F:\Program Files\Delphi_2007\bin\TLIB.exe"

rem 要改的就这么多，下面的不需要修改。

rem ****************************************************************************
rem **** DO NOT CHANGE ANYTHING BELOW THIS POINT *******************************
rem ****************************************************************************

if %VCLVersion% == "5" goto Version5
if %VCLVersion% == "6" goto Version6
if %VCLVersion% == "7" goto Version7
if %VCLVersion% == "9" goto Version9
if %VCLVersion% == "10" goto Version10
echo Invalid VCL Version %VCLVersion%
goto Error


rem ============================================================================
:Version5

if %Compiler% == "Delphi" goto D5DCC32
set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=BCB5
goto End_D5DCC32
:D5DCC32
set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=Delphi5
:End_D5DCC32
set Options=-LUDclStd50
set DBOptions=-LUDclDB50

set ND_RTP=RaizeComponentsVcl50
set ND_RTP_BPL=RaizeComponentsVcl50.bpl
set DB_RTP=RaizeComponentsVclDb50
set DB_RTP_BPL=RaizeComponentsVclDb50.bpl
set ND_DP=RaizeComponentsVcl_Design50
set ND_DP_BPL=RaizeComponentsVcl_Design50.bpl
set DB_DP=RaizeComponentsVclDb_Design50
set DB_DP_BPL=RaizeComponentsVclDb_Design50.bpl

goto Init

rem ============================================================================
:Version6

if %Compiler% == "Delphi" goto D6DCC32
set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=BCB6
goto End_D6DCC32
:D6DCC32
set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=Delphi6
:End_D6DCC32
set Options=-LUDclStd 
set DBOptions=-LUDclDB    

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl60.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb60.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design60.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design60.bpl

goto Init
         
rem ============================================================================
:Version7

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=Delphi7
set Options=-LUDclStd
set DBOptions=-LUDclDB

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl70.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb70.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design70.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design70.bpl

goto Init

rem ============================================================================
:Version9

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=Delphi2005
set Options=-LUDclStd
set DBOptions=-LUDclDB

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl90.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb90.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design90.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design90.bpl

goto Init

rem ============================================================================
:Version10              

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=BDS2006
set Options=-LUDclStd
set DBOptions=-LUDclDB

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl100.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb100.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design100.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design100.bpl

goto Init

:Init

set ND_RegFile=RaizeComponentsVcl_Reg.pas
set DB_RegFile=RaizeComponentsVclDb_Reg.pas

:PathSetup

set LibPath=..\Lib\%LibDir%
set BinPath=..\Bin
set SysPath1=..\Bin\System32
set SysPath2=%SysPath%
goto Build


rem ============================================================================
rem ==== Build Processing Section ==============================================
rem ============================================================================

:Build

if %Compiler% == "BDS" goto Build_BDS
if %Compiler% == "Delphi" goto Build_Delphi
if %Compiler% == "BCB" goto Build_BCB   
echo Invalid Compiler 
goto Error


rem ============================================================================
rem ==== Delphi BDS Section ====================================================
rem ============================================================================
:Build_BDS

echo.
echo Compiling %ND_RegFile% File...
echo.
%DCC32% -B %Options% %ND_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %DB_RegFile% File...
echo.
%DCC32% -B %DBOptions% %DB_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %ND_RTP%.dpk Package...
echo.
%DCC32% -B -jl -LN. %ND_RTP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Compiling %DB_RTP%.dpk Package...
echo.
%DCC32% -B -jl -LN. %DB_RTP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Compiling %ND_DP%.dpk Package...
echo.
%DCC32% -jl -LN. %ND_DP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Compiling %DB_DP%.dpk Package...
echo.
%DCC32% -jl -LN. %DB_DP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Deleting Package DCU files...
del %ND_RTP%.dcu > nul
del %DB_RTP%.dcu > nul
del %ND_DP%.dcu > nul
del %ND_DP%.hpp > nul
del %ND_DP%.lib > nul
del %DB_DP%.dcu > nul
del %DB_DP%.hpp > nul
del %DB_DP%.lib > nul


echo.
echo Copying Build Files to %LibPath%...
copy "*.dcu" %LibPath% > nul
copy "*.dfm" %LibPath% > nul
copy "*.res" %LibPath% > nul
copy "*.hpp" %LibPath% > nul
copy "*.lib" %LibPath% > nul
      
copy %ND_RTP%.dcp %LibPath% > nul
copy %ND_RTP%.bpi %LibPath% > nul
copy %ND_RTP%.hpp %LibPath% > nul
copy %ND_RTP_BPL% %SysPath1% > nul
copy %ND_RTP_BPL% %SysPath2% > nul

copy %DB_RTP%.dcp %LibPath% > nul
copy %DB_RTP%.bpi %LibPath% > nul
copy %DB_RTP%.hpp %LibPath% > nul
copy %DB_RTP_BPL% %SysPath1% > nul
copy %DB_RTP_BPL% %SysPath2% > nul

copy %ND_DP_BPL% %BinPath% > nul
copy %DB_DP_BPL% %BinPath% > nul

goto Success


rem ============================================================================
rem ==== Delphi Build Section ==================================================
rem ============================================================================
:Build_Delphi

echo.
echo Compiling %ND_RegFile% File...
echo.
%DCC32% -B %Options% %ND_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %DB_RegFile% File...
echo.
%DCC32% -B %DBOptions% %DB_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %ND_RTP%.dpk Package...
echo.
%DCC32% -LN. %ND_RTP%.dpk
if errorlevel 1 goto error
echo.
copy %ND_RTP%.dcp %LibPath% > nul
copy %ND_RTP_BPL% %SysPath1% > nul
copy %ND_RTP_BPL% %SysPath2% > nul

echo.
echo Compiling %DB_RTP%.dpk Package...
echo.
%DCC32% -LN. %DB_RTP%.dpk
if errorlevel 1 goto error
echo.
copy %DB_RTP%.dcp %LibPath% > nul
copy %DB_RTP_BPL% %SysPath1% > nul
copy %DB_RTP_BPL% %SysPath2% > nul

echo.
echo Compiling %ND_DP%.dpk Package...
echo.
%DCC32% -LN. %ND_DP%.dpk
if errorlevel 1 goto error
echo.
copy %ND_DP_BPL% %BinPath% > nul

echo.
echo Compiling %DB_DP%.dpk Package...
echo.
%DCC32% -LN. %DB_DP%.dpk
if errorlevel 1 goto error
echo.
copy %DB_DP_BPL% %BinPath% > nul

echo.
echo Deleting Package DCU files...
del %ND_RTP%.dcu > nul
del %DB_RTP%.dcu > nul
del %ND_DP%.dcu > nul
del %DB_DP%.dcu > nul

echo.
echo Copying Build Files to %LibPath%...
copy "*.dcu" %LibPath% > nul
copy "*.dfm" %LibPath% > nul
copy "*.res" %LibPath% > nul


goto Success

rem ============================================================================
rem ==== C++Builder Build Section ============================================== 
rem ============================================================================
:Build_BCB

echo.
echo Compiling %ND_RegFile%...
%DCC32% -B -DBCB %Options% -jphnv %ND_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %DB_RegFile%...
%DCC32% -B -DBCB %DBOptions% -jphnv %DB_RegFile%
if errorlevel 1 goto error

echo.
echo Creating %ND_RTP%.lib...
%TLIB% %ND_RTP%.lib /P64 +RzAnimtr+RzBckgnd+RzBHints+RzBorder+RzBmpBtn+RzBtnEdt+RzButton+RzChkLst+RzCmboBx+RzCommon+RzCommonBitmaps+RzCommonCursors+RzDlgBtn+RzDTP+RzEdit+RzFilSys+RzForms+RzGrafx+RzGrids+RzGroupBar+RzIntLst+RzLabel+RzLaunch+RzLFName+RzLine+RzListVw+RzLookup+RzLookupForm+RzLstBox+RzPanel+RzPathBar+RzPopups+RzPrgres+RzRadChk+RzRadGrp+RzSelDir+RzSelDirForm+RzShellIntf+RzShellConsts+RzShellCtrls+RzShellDialogs+RzShellFolderForm+RzShellOpenForm+RzShellUtils+RzSndMsg+RzSplit+RzSpnEdt+RzStatus+RzSysRes+RzTabs+RzThemeSrv+RzTmSchema+RzToolbarForm+RzTray+RzTreeVw+RzTrkBar+RzUxTheme
if errorlevel 1 goto error

echo.
echo Creating %DB_RTP%.lib
%TLIB% %DB_RTP%.lib /P64 +RzDBBnEd+RzDBChk+RzDBCmbo+RzDBDTP+RzDBEdit+RzDBGrid+RzDBLbl+RzDBList+RzDBLook+RzDBLookupForm+RzDBNav+RzDBProg+RzDBRGrp+RzDBSpin+RzDBStat+RzDBTrak
if errorlevel 1 goto error

del *.obj > nul

echo.
echo Copying Build Files to %LibPath%...
copy "*.dfm" %LibPath% > nul
copy "*.hpp" %LibPath% > nul
copy "*.lib" %LibPath% > nul
copy "*.res" %LibPath% > nul

echo.
echo Compiling %ND_RTP%.dpk Package...
%DCC32% -DBCB -LN. %ND_RTP%.dpk
if errorlevel 1 goto error
%DCC32% -DBCB -jphnv -LN. %ND_RTP%.dpk
if errorlevel 1 goto error

copy %ND_RTP%.bpi %LibPath% > nul
copy %ND_RTP%.hpp %LibPath% > nul
copy %ND_RTP_BPL% %SysPath1% > nul
copy %ND_RTP_BPL% %SysPath2% > nul

echo.
echo Compiling %DB_RTP%.dpk Package...
%DCC32% -DBCB -LN. %DB_RTP%.dpk
if errorlevel 1 goto error
%DCC32% -DBCB -jphnv -LN. %DB_RTP%.dpk
if errorlevel 1 goto error

copy %DB_RTP%.bpi %LibPath% > nul
copy %DB_RTP%.hpp %LibPath% > nul
copy %DB_RTP_BPL% %SysPath1% > nul
copy %DB_RTP_BPL% %SysPath2% > nul

echo.
echo Compiling %ND_DP%.dpk Package...
%DCC32% -DBCB -LN. %ND_DP%.dpk
if errorlevel 1 goto error
%DCC32% -DBCB -jphnv -LN. %ND_DP%.dpk
if errorlevel 1 goto error

copy %ND_DP_BPL% %BinPath% > nul

echo.
echo Compiling %DB_DP%.dpk Package...
%DCC32% -DBCB -LN. %DB_DP%.dpk
if errorlevel 1 goto error
%DCC32% -DBCB -jphnv -LN. %DB_DP%.dpk
if errorlevel 1 goto error

copy %DB_DP_BPL% %BinPath% > nul

goto Success

rem ============================================================================
:Success
echo.
echo Build was Successful.
goto end


rem ============================================================================
:error
echo.
echo **ERROR**

rem ============================================================================
:end
pause
