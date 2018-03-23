@if (@CodeSection == @Batch) @then
@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=D:\Users\Ryan\Desktop\Easy Hakchi2ce Set Up.exe
REM BFCPEICON=C:\Program Files (x86)\Advanced BAT to EXE Converter v4.11\ab2econv411\icons\icon6.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Easy Hakchi2ce Web Installer/Updater
REM BFCPEVERDESC=Hakchi2ce Updater / Installer
REM BFCPEVERCOMPANY='The Other Guys'
REM BFCPEVERCOPYRIGHT='The Other Guys' 2018
REM BFCPEOPTIONEND
mode con: cols=92 lines=35
setlocal enabledelayedexpansion
color 0A
set InstallerBuild=1.0


rem Initialize Module...
goto initialize
:finish_initialize
CLS
rem ============================================================================================
rem SCREEN 1 - Welcome screen...
rem ============================================================================================
echo.
echo.
echo    Knock, Knock
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                      
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  (_)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo                              Presented by www.hakchiresources.com
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
pause
rem ============================================================================================

CLS
rem ============================================================================================
rem SCREEN 2a - Info screen...
rem ============================================================================================
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  (_)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo  This simple application will update your old existing Hakchi2 to Hakchi2 CE or install a 
echo  fresh copy to either your computer, USB or SD card.
echo.
echo  This installer/updater will work for both NAND and USB-HOST set ups. It also requires an
echo  internet connection to download the latest versions of the Hakchi2 CE build and tools...
echo.
echo  You will be ask a series of questions so just follow them step by step and this app will 
echo  do most of the work for you in getting you up and running.
echo.
echo  If you have any issues with the install process you can ask for help at the SNES mini
echo  reddit page at: www.reddit.com/r/miniSNESmods or find us at:
echo  www.hakchiresources.com   
echo.
echo  Good luck and have fun^!
echo  Swingflip x
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
pause
rem ============================================================================================

CLS
rem ============================================================================================
rem SCREEN 2b - Disclaimer...
rem ============================================================================================
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  (_)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo                                 ** DISCLAIMER / LEGAL STUFF **
echo.
echo.
echo  We do not accept any responsibility for any damage made to your console whilst using  
echo  this app, Hakchi2ce or any of the optional mods bundled with this app.
echo.
echo  It should also be noted that you CAN NOT brick your console using this app as there
echo  has yet to be a case of a bricked console using this software.
echo.
echo  It is strongly recommended you keep your stock kernel image safe if you have it. If 
echo  you are installing from fresh. You will have an opportunity to dump this later. 
echo  KEEP THIS SAFE! 
echo.
echo  If in the future you lose your stock kernel. You can find the stock kernel online using
echo  Google. We will NOT link to any Nintendo copyrighted materials.
echo.
echo  If you encounter any issues at any point, you can flash the standard kernel and go back
echo  to factory defaults.
echo.
echo  Lastly this software and the rest of the software bundled with this app is NOT for 
echo  commercial use. IT IS AND WILL ALWAYS BE FREE TO USE.
echo.
echo  You have been warned and you proceed at your own risk.
echo.                                              
echo.
pause
rem ============================================================================================

rem lets do this shit...

:screen3
CLS
rem ============================================================================================
rem SCREEN 3 - USB-HOST or NAND screen...
rem ============================================================================================
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  (_)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|                Question 01                 ^|
echo                         ----------------------------------------------
echo                         ^| Do you wish to use Hakchi CE in NAND mode  ^|
echo                         ^| or USB-HOST mode?                          ^|
echo                         ^| (USB-HOST mode uses external storage)      ^|
echo                         ^| Type N for NAND or U for USB-HOST          ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
:Ask
set INPUT=
set /P INPUT=Type (N) for NAND or (U) for USB-HOST: !=!
if /I "!INPUT!"=="n" SET HAKCHI_MODE=NAND& goto screen4
if /I "!INPUT!"=="u" SET HAKCHI_MODE=USB & goto screen4
echo Incorrect input & goto screen3     
rem ============================================================================================                                                           

:screen4
CLS
rem ============================================================================================
rem SCREEN 4 - Install or update...
rem ============================================================================================
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  (_)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|                Question 02                 ^|
echo                         ----------------------------------------------
echo                         ^| Are you updating or installing a fresh     ^|
echo                         ^| copy of Hakchi2 CE?                        ^|
echo                         ^|                                            ^|
echo                         ^| Type U for UPDATE or I for INSTALL         ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
:Ask
set INPUT=
set /P INPUT=Type (U) for UPDATE or (I) for INSTALL: !=!
if /I "!INPUT!"=="u" SET INSTALL_MODE=UPDATE & goto screen5
if /I "!INPUT!"=="i" SET INSTALL_MODE=INSTALL& goto screen5
echo Incorrect input & goto screen4     
rem ============================================================================================  

:screen5
CLS
rem ============================================================================================
rem SCREEN 5 - Set working directory...
rem ============================================================================================
if "!INSTALL_MODE!" == "UPDATE " (
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|                Question 03                 ^|
echo                         ----------------------------------------------
echo                         ^| Please select the directory your current   ^|
echo                         ^| hakchi2 directory.                         ^|
echo                         ^| For example:                               ^|
echo                         ^| D:\data\hakchi2                            ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                             
echo.
:Ask
echo Select your current hakchi2 directory...
For /F "Tokens=1 Delims=" %%I In ('cscript //nologo "!tmp!"\Hakchi_BrowseFolder.vbs') Do set _FolderName=%%I
if [!_FolderName!] == [] set "_FolderName=" && call :msg "You didn't select a valid directory! Please try again" && goto screen5
set inputdirname=!_FolderName!
set "!_FolderName!="
if "!HAKCHI_MODE!" == "NAND" (
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|                Question 04                 ^|
echo                         ----------------------------------------------
echo                         ^| Please select the directory you wish to    ^|
echo                         ^| install hakchi2 CE.                        ^|
echo                         ^| For example:                               ^|
echo                         ^| C:\Hakchi2ce                               ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
:Ask
echo Select your new hakchi2ce directory...
For /F "Tokens=1 Delims=" %%I In ('cscript //nologo "!tmp!"\Hakchi_BrowseFolder.vbs') Do set _FolderName=%%I
if [!_FolderName!] == [] set "_FolderName=" && call :msg "You didn't select a valid directory! Please try again" && goto screen5
set inputnanddirname=!_FolderName!
set "!_FolderName!="
)
goto screen6
)
if "!INSTALL_MODE!" == "INSTALL" (
if "!HAKCHI_MODE!" == "NAND" (
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|                Question 03                 ^|
echo                         ----------------------------------------------
echo                         ^| Please enter the directory you wish to     ^|
echo                         ^| install hakchi2 CE.                        ^|
echo                         ^| For example:                               ^|
echo                         ^| C:\Hakchi2ce                               ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                              
:Ask
echo Select your new hakchi2ce directory...
For /F "Tokens=1 Delims=" %%I In ('cscript //nologo "!tmp!"\Hakchi_BrowseFolder.vbs') Do set _FolderName=%%I
if [!_FolderName!] == [] set "_FolderName=" && call :msg "You didn't select a valid directory! Please try again" && goto screen5
set inputdirname=!_FolderName!
set "!_FolderName!="
goto screen6
)
if "!HAKCHI_MODE!" == "USB " (
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|                Question 03                 ^|
echo                         ----------------------------------------------
echo                         ^| Please enter the directory your USB Root   ^|
echo                         ^| is located.                                ^|
echo                         ^| For example:                               ^|
echo                         ^| D:\                                        ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                   
:Ask
echo Select your new hakchi2ce directory...
For /F "Tokens=1 Delims=" %%I In ('cscript //nologo "!tmp!"\Hakchi_BrowseFolder.vbs') Do set _FolderName=%%I
if [!_FolderName!] == [] set "_FolderName=" && call :msg "You didn't select a valid directory! Please try again" && goto screen5
set inputdirname=!_FolderName!
set "!_FolderName!="
goto screen6
)
)
rem ============================================================================================  

:screen6
CLS
rem ============================================================================================
rem SCREEN 6a - Update warning...
rem ============================================================================================
if "!INSTALL_MODE!" == "UPDATE "  (
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo                               ** UPDATE WARNING / INFORMATION ** 
echo.
echo.
echo  We attempt to account for every possible permutation of set up / issues that people have.
echo  However there will be a small amount of people who have issues using the updater.
echo.
echo  If you are not bothered about your previous set up, games etc. We always recommend you
echo  un-install the custom kernel and flash your stock kernel using any hakchi GUI and run an
echo  install instead of an update using this app.
echo.
echo  95% of the time the update routine will run fine however, if you find yourself having
echo  issues with your console. Make a backup, un-install the custom kernel and flash your    
echo  stock kernel back to the console using Hakchi.
echo.
echo  If you do not have your stock kernel any more you can find them online using google.
echo.
echo  REMEMBER don't panic! You can not brick or damage your console using Hakchi2ce however
echo  you do take responsibility for modding your own console obviously as we certainly don't!
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
pause
)
rem ============================================================================================
rem SCREEN 6b - Confirmation...
rem ============================================================================================
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo                         ----------------------------------------------
echo                         ^|               Confirmation                 ^|
echo                         ----------------------------------------------
echo                         ^| You selected the following details:        ^|
echo                         ^| Hakchi Mode:  !HAKCHI_MODE!                         ^|
echo                         ^| Install Type: !INSTALL_MODE!                      ^|
echo                         ^| Directory:    See below...                 ^|
echo                         ^| Are you happy to proceed^? ^(Y/N^)            ^|
echo                         ----------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo You selected to install/update in directory:
echo !inputdirname!
:Ask
set INPUT=
set /P INPUT="Are you happy to proceed ^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto screen7
if /I "!INPUT!"=="n" goto exit
echo Incorrect input & goto screen6     
rem ============================================================================================  

:screen7
CLS
rem ============================================================================================
rem SCREEN 7 - Do stuff and run the app....
rem ============================================================================================
cls
echo Checking internet connection...
Ping www.google.com -n 1 -w 1000>nul 2>&1
if errorlevel 1 (set internet=N) else (set internet=Y)

if "!internet!" == "N" (
	echo [ERROR] - You are not connected to the internet! Make sure you connect to the net first!
	pause
	exit /b
)

if "!internet!" == "Y" (
	echo [OK] - You are connected to the internet^!
)

rem ============================================================================================
rem FORMAT CHECK
	for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %inputdirname:~0,2%^|findstr /B "File System Name : "') do (@set DriveType=%%a)
	:filewarning
	if NOT "!DriveType!" == "NTFS" (
		echo.
		echo ^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*
		echo                    WARNING
		echo ^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*
		echo  Drive %inputdirname:~0,2% is not NTFS formatted. Hakchi2ce now
		echo  supports NTFS formatted drives and is the
		echo  recommended format moving forward. We strongly
		echo  suggest you format this drive to NTFS before
		echo  continuing. However you can proceed if you
		echo  wish... Do you want to continue?
		echo ^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*^*
		
		set INPUT=
		set /P INPUT="Are you happy to proceed^? (Y/N)" !=!
		if /I "!INPUT!"=="y" goto continue
		if /I "!INPUT!"=="n" goto exit
		echo Incorrect input & goto filewarning
	)
	:continue
CLS
rem ============================================================================================
rem FOLDER CREATION
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Creating file structure for the USB/SD device...
		mkdir %inputdirname:~0,2%\data
		mkdir %inputdirname:~0,2%\data\log
		mkdir %inputdirname:~0,2%\data\transfer_backup
		mkdir %inputdirname:~0,2%\data\extras
		mkdir %inputdirname:~0,2%\data\hakchi2ce
		mkdir %inputdirname:~0,2%\hakchi
		mkdir %inputdirname:~0,2%\hakchi\saves
		mkdir %inputdirname:~0,2%\hakchi\games
		mkdir %inputdirname:~0,2%\hakchi\fonts
		echo [OK] - Created the file structure!
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Creating file structure for the USB/SD device...
		mkdir !inputdirname!\data
		mkdir !inputdirname!\data\log
		mkdir !inputdirname!\data\transfer_backup
		mkdir !inputdirname!\data\extras
		mkdir !inputdirname!\data\hakchi2ce
		mkdir !inputdirname!\hakchi
		mkdir !inputdirname!\hakchi\saves
		mkdir !inputdirname!\hakchi\games
		mkdir !inputdirname!\hakchi\fonts
		echo [OK] - Created the file structure!	
	)
)

rem Dunno if we should create another folder on top of what the user decides...
rem effectively they can call it bananas for all I care. #IDGAF
if "!HAKCHI_MODE!" == "NAND" (
	echo Creating file structure on your local device...
	echo.
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\extras
	)
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir !inputnanddirname!\extras
	)
	echo [OK] - Created the file structure!
)

rem ============================================================================================
rem HAKCHI PACKAGE DOWNLOADER
echo Downloading the latest Hakchi2 Community edition build...
echo.
if exist "!tmp!"\package.zip (
del "!tmp!"\package.zip
)
wget !HakchiBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\package.zip
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!HakchiBuildURL!', '"!tmp!"\package.zip')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download Hakchi from URL: !HakchiBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\package.zip ( echo [OK] - Downloaded successfully^! )
echo.

echo Unzipping package...
mkdir "!tmp!"\hakchi2ce
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\hakchi2ce'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download unzip downloaded package
	del "!tmp!"\package.zip
	rmdir /S /Q "!tmp!"\hakchi2ce
	pause
	exit /b
)
del "!tmp!"\package.zip
echo [OK] - Unzipped successfully!

rem ============================================================================================
rem INSTALLER/UPDATE FOLDERS
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputnanddirname!
		xcopy /s /y "!tmp!"\hakchi2ce "!inputnanddirname!"
		if exist "!inputnanddirname!"\hakchi.exe (
			echo [OK] - Copied hakchi2ce successfully! 
			rem rmdir /S /Q "!tmp!"\hakchi2ce
		)
		if not exist "!inputnanddirname!"\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q "!tmp!"\hakchi2ce
			pause
			exit /b
		)
		echo Copying old Hakchi2 files over to new build...
		echo If you are asked if something is a file or directory, type D for directory...
		pause
		if not exist "!inputdirname!"\games mkdir "!inputdirname!"\games
		if not exist "!inputdirname!"\games_snes mkdir "!inputdirname!"\games_snes
		move /Y "!inputdirname!"\games "!inputnanddirname!"\games
		move /Y "!inputdirname!"\games_snes "!inputnanddirname!"\games_snes
		if not exist "!inputdirname!"\games mkdir "!inputdirname!"\games
		if not exist "!inputdirname!"\games_snes mkdir "!inputdirname!"\games_snes
		xcopy /s /y "!inputdirname!"\games_cache "!inputnanddirname!"\games_cache
		xcopy /s /y "!inputdirname!"\games_originals "!inputnanddirname!"\games_originals
		xcopy /s /y "!inputdirname!"\config "!inputnanddirname!"\config
		xcopy /s /y "!inputdirname!"\dump "!inputnanddirname!"\dump
		xcopy /s /y "!inputdirname!"\art "!inputnanddirname!"\art
		xcopy /s /y "!inputdirname!"\folder_images "!inputnanddirname!"\folder_images
		xcopy /s /y "!inputdirname!"\user_mods "!inputnanddirname!"\user_mods
		xcopy /s /y "!tmp!"\hakchi2ce\user_mods "!inputnanddirname!"\user_mods
		echo [OK] - Copied old Hakchi2 files successfully!
		rmdir /S /Q "!tmp!"\hakchi2ce
		rem set file=!inputnanddirname!\config\config.ini
		rem echo Fixing up config...
		rem Set initial boot to zero
		rem :loop
		rem 	findstr "^RunCount=0$" "%file%" >nul || (
		rem 		type "%file%"|repl "^RunCount=.*" "RunCount=0" >"%file%.tmp"
		rem 		move "%file%.tmp" "%file%" >nul
		rem 	)
		rem 	ping -n 120 localhost >nul
		rem goto :loop
		rem echo [OK] - Fixed up config successfully!
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!
		xcopy /s "!tmp!"\hakchi2ce "!inputdirname!"
		if exist "!inputdirname!"\hakchi.exe (
			echo [OK] - Copied hakchi2ce successfully! 
			rmdir /S /Q "!tmp!"\hakchi2ce
		)
		if not exist "!inputdirname!"\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q "!tmp!"\hakchi2ce
			pause
			exit /b
		)
	)
)
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: %inputdirname:~0,2%\data\hakchi2ce
		xcopy /s /y "!tmp!"\hakchi2ce %inputdirname:~0,2%\data\hakchi2ce
		if exist %inputdirname:~0,2%\data\hakchi2ce\hakchi.exe (
			echo [OK] - Copied hakchi2ce successfully! 
			rem rmdir /S /Q "!tmp!"\hakchi2ce
		)
		if not exist %inputdirname:~0,2%\data\hakchi2ce\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q "!tmp!"\hakchi2ce
			pause
			exit /b
		)
		echo Copying old Hakchi2 files over to new build...
		echo If you are asked if something is a file or directory, type D for directory...
		pause
		if not exist "!inputdirname!"\games mkdir "!inputdirname!"\games
		if not exist "!inputdirname!"\games_snes mkdir "!inputdirname!"\games_snes
		move /Y "!inputdirname!"\games %inputdirname:~0,2%\data\hakchi2ce\games
		move /Y "!inputdirname!"\games_snes %inputdirname:~0,2%\data\hakchi2ce\games_snes
		if not exist "!inputdirname!"\games mkdir "!inputdirname!"\games
		if not exist "!inputdirname!"\games_snes mkdir "!inputdirname!"\games_snes
		xcopy /s /y "!inputdirname!"\games_cache %inputdirname:~0,2%\data\hakchi2ce\games_cache
		xcopy /s /y "!inputdirname!"\games_originals %inputdirname:~0,2%\data\hakchi2ce\games_originals
		xcopy /s /y "!inputdirname!"\config %inputdirname:~0,2%\data\hakchi2ce\config
		xcopy /s /y "!inputdirname!"\dump !inputnanddirname!\dump
		xcopy /s /y "!inputdirname!"\art %inputdirname:~0,2%\data\hakchi2ce\art
		xcopy /s /y "!inputdirname!"\folder_images %inputdirname:~0,2%\data\hakchi2ce\folder_images
		xcopy /s /y "!inputdirname!"\user_mods %inputdirname:~0,2%\data\hakchi2ce\user_mods
		xcopy /s /y "!tmp!"\hakchi2ce\user_mods %inputdirname:~0,2%\data\hakchi2ce\user_mods
		echo [OK] - Copied old Hakchi2 files successfully!
		rmdir /S /Q "!tmp!"\hakchi2ce
		rem set file=%inputdirname:~0,2%\data\hakchi2ce\config\config.ini
		rem echo Fixing up config...
		rem Set initial boot to zero
		rem :loop
		rem 	findstr "^RunCount=0$" "%file%" >nul || (
		rem 		type "%file%"|repl "^RunCount=.*" "RunCount=0" >"%file%.tmp"
		rem 		move "%file%.tmp" "%file%" >nul
		rem 	)
		rem 	ping -n 120 localhost >nul
		rem goto :loop
		rem echo [OK] - Fixed up config successfully!
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\data\hakchi2ce
		xcopy /s "!tmp!"\hakchi2ce "!inputdirname!"\data\hakchi2ce
		CLS
		if exist "!inputdirname!"\data\hakchi2ce\hakchi.exe (
			echo [OK] - Copied hakchi2ce successfully! 
			rmdir /S /Q "!tmp!"\hakchi2ce
		)
		if not exist "!inputdirname!"\data\hakchi2ce\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q "!tmp!"\hakchi2ce
			pause
			exit /b
		)
	)
)
 
rem ============================================================================================
rem ASCII art porn...

echo                                                      ______   ____
echo                                                     /######\#/####\
echo                                                     ##^*^*^*^*^*^*^*^*^*^*^*##
echo                                                    ##/      ^|    \#
echo                                                  ###^|       ^|     ^| 
echo                                                 ####^|       ^|     ^|             
echo                                                #####^|QQ     ^|QQ   ^|   #######        
echo           Hakchi2 CE installed                 ######\QQ   /#\QQ /#################     
echo              Successfully!                    #####/######\#########################  
echo                                              ##########################################  
echo                                            #############################################
echo                                           ###############################################
echo                                           #############\#################################
echo                                           #########     )################################
echo                                           ########     / xx##############################
echo                                            #######         xx############################
echo                                             #######          xxxxx######################
echo                                               ######              xxxx################
echo                                                 #####                 xxxxxxxxxxxxxx
echo                                                 ######                     ____/
echo                                                #######                 ___/  
echo                                                #######                /
echo.
rem ============================================================================================  
rem custom content...
echo Cool. Looks like everything ran correctly... Unless you saw a lot of red errors, then this
echo message doesn't really apply to you and you should probably try and work out what went
echo wrong and try not to cry... 
echo.
echo If you are happy it ran ok, you should consider looking at the optional modules available
echo as they add extra awesome to your build.
:AskCustomContent
set INPUT=
set /P INPUT="Do you want to check this out^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto screen8
if /I "!INPUT!"=="n" goto AskHelp
echo Incorrect input & goto AskCustomContent

:screen8
CLS
rem ============================================================================================
rem SCREEN 8 - Custom good shit...
rem ============================================================================================
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo                               CUSTOM CONTENT AKA "THE GOOD STUFF"
echo                         ----------------------------------------------
echo. 
echo Here is a list of custom content handpicked by myself which I believe are great mods to
echo include in any build of Hakchi and should be essential to your set up. 
echo.
echo When you are ready, press any key and I will list out each mod one by one with a
echo description of what it does and how it works...
echo.
echo You don't need to install all of them as they are all optional modules.
echo.
echo Please note I have only included mods which are small in file size so they won't
echo take up hardly any space on your Console's NAND memory. If the mod is fairly large I will
echo let you know...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
pause
CLS
rem ============================================================================================
rem   _____ _    _  _____ _______ ____  __  __    _____ ____  _   _ _______ ______ _   _ _______ 
rem  / ____| |  | |/ ____|__   __/ __ \|  \/  |  / ____/ __ \| \ | |__   __|  ____| \ | |__   __|
rem | |    | |  | | (___    | | | |  | | \  / | | |   | |  | |  \| |  | |  | |__  |  \| |  | |   
rem | |    | |  | |\___ \   | | | |  | | |\/| | | |   | |  | | . ` |  | |  |  __| | . ` |  | |   
rem | |____| |__| |____) |  | | | |__| | |  | | | |___| |__| | |\  |  | |  | |____| |\  |  | |   
rem  \_____|\____/|_____/   |_|  \____/|_|  |_|  \_____\____/|_| \_|  |_|  |______|_| \_|  |_|   
rem ============================================================================================     
rem 									    STARTS HERE 
rem ============================================================================================  
rem TODO: we could function'ise' a lot of this but every mod is slightly different so maybe it's 
rem best to keep it like this so we can chop and swap stuff as and when we need to...
cls
echo.
echo --------------------------------------------------
echo Hakchi Options Menu by CompCom
echo --------------------------------------------------
echo This is a options pack which comes with a ton of functionality and useful tools for your
echo Hakchi build. Not only does it contains such things as hmod manager it comes bundled with
echo the hibernate mod which allows you to remotely hibernate your console.
:AskCustomContent1
set INPUT=
set /P INPUT="Do you want to install Hakchi Options Menu^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent1
if /I "!INPUT!"=="n" goto Continue1
echo Incorrect input & goto AskCustomContent1
:InstallCustomContent1
set CustomContentBuild=Options_Deluxe_v1_1_0
set CustomContentBuildURL=https://github.com/CompCom/OptionsMenu/releases/download/v1.1/options_deluxe_v1_1_0.hmod
set CustomContentBuildLastUpdated=2nd March 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue2 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir "!tmp!"\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del "!tmp!"\package.zip
rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del "!tmp!"\package.zip
rem echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM1=Y
set CUSTOM2=N/A
:Continue1
if NOT DEFINED CUSTOM1 (set CUSTOM1=N)
echo.
rem ============================================================================================
rem don't install power mod if option mod installed as it conflicts. Actually, it doesn't... Just don't do it.
if "!CUSTOM1!" == "N" (
    CLS
	echo.
	echo --------------------------------------------------
	echo Hibernate Mod ^(Lite^) by Swingflip
	echo --------------------------------------------------
	echo This is a mod which enables a power menu when you hold L ^+ R ^+ UP during game-play
	echo or when in the menus. You have an option to hibernate or put your console in to
	echo standby just like if you were using the XBOX or Playstation. You can also remotely
	echo wake up the console with the gamepad.
	:AskCustomContent2
	set INPUT=
	set /P INPUT="Do you want to install Hibernate Mod^? (Y/N)" !=!
	if /I "!INPUT!"=="y" goto InstallCustomContent2
	if /I "!INPUT!"=="n" goto Continue2
	echo Incorrect input & goto AskCustomContent2
	:InstallCustomContent2
	set CustomContentBuild=hibernate_mod_lite_v1_3
	set CustomContentBuildURL=https://github.com/swingflip/Hakchi-Hibernate-Mod/releases/download/Deluxe_Lite_1_1_3/hibernate_mod_lite_v1_3.hmod
	set CustomContentBuildLastUpdated=6th February 2018
	echo Downloading the latest !CustomContentBuild! build...
	if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue2 )
	if exist "!tmp!"\!CustomContentBuild!.hmod (
	del "!tmp!"\!CustomContentBuild!.hmod
	)
	wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
	REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
	if not %errorlevel%==0 (
		echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
		pause
		exit /b
	)
	if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
	echo.

	rem echo Unzipping package...
	rem mkdir "!tmp!"\!CustomContentBuild!
	rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
	rem if not %errorlevel%==0 (
	rem 	echo [ERROR] - Couldn't download unzip downloaded package
	rem 	del "!tmp!"\package.zip
	rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
	rem 	pause
	rem 	exit /b
	rem )
	rem del "!tmp!"\package.zip
	rem echo [OK] - Unzipped successfully!
	
	rem We transfer directly into the hmod so they get installed during the kernel flash
	if "!HAKCHI_MODE!" == "NAND" (
		if "!INSTALL_MODE!" == "UPDATE " (
			echo Copying files over to: !inputdirname!\mods\hmods
			xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
		)
		if "!INSTALL_MODE!" == "INSTALL" (
			echo Copying files over to: !inputdirname!\mods\hmods
			xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
		)
	)
	rem We transfer to the transfer folder as these should just install when run
	if "!HAKCHI_MODE!" == "USB " (
		if "!INSTALL_MODE!" == "UPDATE " (
			mkdir %inputdirname:~0,2%\hakchi\transfer		
			echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
			xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
			echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
			xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
		)
		if "!INSTALL_MODE!" == "INSTALL" (
			mkdir !inputdirname!\hakchi\transfer
			echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
			xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
			echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
			xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
		)
	)
	echo [OK] - Installed !CustomContentBuild! Successfully!
	rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
	set CUSTOM2=Y
	:Continue2
	if NOT DEFINED CUSTOM2 ( set CUSTOM2=N )
	echo.
)
rem ============================================================================================
CLS
echo.
echo --------------------------------------------------
echo Canoe Save Compression Mod ^(FAST^) by CompCom
echo --------------------------------------------------
echo This mod compresses all canoe save states using 7zip. On average this turns canoe save
echo states from 2mb to less than 300kb
:AskCustomContent3
set INPUT=
set /P INPUT="Do you want to install Canoe Save Compression Mod^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent3
if /I "!INPUT!"=="n" goto Continue3
echo Incorrect input & goto AskCustomContent3
:InstallCustomContent3
set CustomContentBuild=canoe_save_compress_fast_v1_2
set CustomContentBuildURL=https://github.com/CompCom/hmrepo/raw/master/canoe_save_compress_fast.hmod
set CustomContentBuildLastUpdated=9th February 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue3 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir "!tmp!"\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del "!tmp!"\package.zip
rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del "!tmp!"\package.zip
rem echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM3=Y
:Continue3
if NOT DEFINED CUSTOM3 ( set CUSTOM3=N )
echo.
rem ============================================================================================
CLS
echo.
echo --------------------------------------------------
echo RetroArch 'Neo' 1.7.1 compiled by 'The Other Guys'
echo --------------------------------------------------
echo Retroarch is the core application for your emulation needs. You will need RetroArch if you
echo intend on using any emulator on the system that isn't the default built in one. This
echo retroarch is set up specificly to work with the current release of Hakchi2ce
:AskCustomContent4
set INPUT=
set /P INPUT="Do you want to install RetroArch 1.7.1d^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent4
if /I "!INPUT!"=="n" goto Continue4
echo Incorrect input & goto AskCustomContent4
:InstallCustomContent4
set CustomContentBuild=RetroArch_Neo_v1_7_1d
set CustomContentBuildURL=https://github.com/TheOtherGuys-Hakchi-Projects/Hakchi-Retroarch-Neo-1.7.0/releases/download/v1.7.1d/Hakchi_Retroarch_Neo_v1_7_1d.hmod
set CustomContentBuildLastUpdated=22nd March 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue4 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir "!tmp!"\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del "!tmp!"\package.zip
rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del "!tmp!"\package.zip
rem echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM4=Y
:Continue4
if NOT DEFINED CUSTOM4 ( set CUSTOM4=N )
echo.
rem ============================================================================================
CLS
echo.
echo --------------------------------------------------
echo RetroArch 'Essential Cores' by 'Hakchi'
echo --------------------------------------------------
echo These are a selection of basic (work out of the box) RetroArch Cores (emulators) for the
echo SNES and NES Classic console. 
:AskCustomContent5
set INPUT=
set /P INPUT="Do you want to install the RetroArch 'Essential Cores'^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent5
if /I "!INPUT!"=="n" goto Continue5
echo Incorrect input & goto AskCustomContent5
:InstallCustomContent5
set CustomContentBuild=Hakchi_RetroArch_Essential_Cores_v1_0_0
set CustomContentBuildURL=https://github.com/hakchi/Hakchi-RetroArch-Essential-Cores/releases/download/v1_0_0/Hakchi_RetroArch_Essential_Cores_v1_0_0.zip
set CustomContentBuildLastUpdated=23rd March 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue5 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.zip
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.zip ( echo [OK] - Downloaded successfully^! )
echo.
echo.

echo Unzipping package...
mkdir "!tmp!"\!CustomContentBuild!
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\!CustomContentBuild!.zip'); $target.CopyHere($zip.Items(), 16); }"
if not %errorlevel%==0 (
 	echo [ERROR] - Couldn't download unzip downloaded package
 	del "!tmp!"\!CustomContentBuild!.zip
 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
 	pause
 	exit /b
)
del "!tmp!"\!CustomContentBuild!.zip
echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild! "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild! "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\hakchi2ce "!inputdirname!"
		xcopy /s /y "!tmp!"\!CustomContentBuild! %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild! %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild! %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild! %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM5=Y
:Continue5
if NOT DEFINED CUSTOM5 ( set CUSTOM5=N )
echo.
CLS
rem ============================================================================================
CLS
echo.
echo --------------------------------------------------
echo Hakchi Video Splash Screen Mod by 'The Other Guys'
echo --------------------------------------------------
echo It's an awesome Hakchi2 module (HMOD) which adds a video splash screen to your Nintendo
echo SNES and NES Classic console. It currently supports up-to 480p video and now supports
echo audio as well! (10mb NAND space required!)
:AskCustomContent6
set INPUT=
set /P INPUT="Do you want to install the Hakchi Video Splash Screen Mod^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent6
if /I "!INPUT!"=="n" goto Continue6
echo Incorrect input & goto AskCustomContent6
:InstallCustomContent6
set CustomContentBuild=Hakchi_Video_Splash_Screen_v1_1
set CustomContentBuildURL=https://github.com/TheOtherGuys-Hakchi-Projects/Hakchi_Video_Splash_Screen/releases/download/Video_Splash_v1_video_1/Hakchi_Video_Splash_1.hmod
set CustomContentBuildLastUpdated=2nd March 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue6 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir "!tmp!"\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del "!tmp!"\package.zip
rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del "!tmp!"\package.zip
rem echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM6=Y
:Continue6
if NOT DEFINED CUSTOM6 ( set CUSTOM6=N )
echo.
CLS
rem ============================================================================================
echo.
echo --------------------------------------------------
echo Hakchi Advanced Music Hack by Swingflip
echo --------------------------------------------------
echo This module will disable NES/SNES Mini's default menu music and randomly play as much
echo custom music you want, located on your external USB/SD drive...
:AskCustomContent7
set INPUT=
set /P INPUT="Do you want to install the Hakchi Advanced Music Hack Mod^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent7
if /I "!INPUT!"=="n" goto Continue7
echo Incorrect input & goto AskCustomContent7
:InstallCustomContent7
set CustomContentBuild=Hakchi_Advanced_Music_Hack_v2_1
set CustomContentBuildURL=https://github.com/TheOtherGuys-Hakchi-Projects/Hakchi_Advanced_Music_Hack/releases/download/v2_0_1/Hakchi_Advanced_Music_Hack_v2_0_1.hmod
set CustomContentBuildLastUpdated=22nd March 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue6 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir "!tmp!"\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del "!tmp!"\package.zip
rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del "!tmp!"\package.zip
rem echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM7=Y
:Continue7
if NOT DEFINED CUSTOM7 ( set CUSTOM7=N )
echo.
rem ============================================================================================
CLS
echo.
echo --------------------------------------------------
echo Super Famicom English Translation by rhester72
echo --------------------------------------------------
echo This is a mod which will translate the Super Famicom menu into English. Obviously this is
echo only required if you have a Super Famicom and want it translated into English...
echo I highly recommended NOT installing this on anything but a Super Famicom...
:AskCustomContent8
set INPUT=
set /P INPUT="Do you want to install Super Famicom Translation^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent8
if /I "!INPUT!"=="n" goto Continue8
echo Incorrect input & goto AskCustomContent8
:InstallCustomContent8
set CustomContentBuild=sfc_eng_menu_hack_v0_4
set CustomContentBuildURL=http://www.rendezvo.us/snes/sfc_eng_menu_hack-0.4.hmod
set CustomContentBuildLastUpdated=9th February 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue6 )
if exist "!tmp!"\!CustomContentBuild!.hmod (
del "!tmp!"\!CustomContentBuild!.hmod
)
wget !CustomContentBuildURL! --progress=bar --no-check-certificate --secure-protocol=TLSv1_2 -O "!tmp!"\!CustomContentBuild!.hmod
REM powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '"!tmp!"\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist "!tmp!"\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir "!tmp!"\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('"!tmp!"\!CustomContentBuild!'); $zip = $shell.NameSpace('"!tmp!"\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del "!tmp!"\package.zip
rem 	rmdir /S /Q "!tmp!"\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del "!tmp!"\package.zip
rem echo [OK] - Unzipped successfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod "!inputnanddirname!"\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod "!inputdirname!"\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s "!tmp!"\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rem rmdir /S /Q "!tmp!"\!CustomContentBuild!.hmod
set CUSTOM8=Y
:Continue8
CLS
if NOT DEFINED CUSTOM8 ( set CUSTOM8=N )
echo.
rem ============================================================================================
rem ============================================================================================
rem   _____ _    _  _____ _______ ____  __  __    _____ ____  _   _ _______ ______ _   _ _______ 
rem  / ____| |  | |/ ____|__   __/ __ \|  \/  |  / ____/ __ \| \ | |__   __|  ____| \ | |__   __|
rem | |    | |  | | (___    | | | |  | | \  / | | |   | |  | |  \| |  | |  | |__  |  \| |  | |   
rem | |    | |  | |\___ \   | | | |  | | |\/| | | |   | |  | | . ` |  | |  |  __| | . ` |  | |   
rem | |____| |__| |____) |  | | | |__| | |  | | | |___| |__| | |\  |  | |  | |____| |\  |  | |   
rem  \_____|\____/|_____/   |_|  \____/|_|  |_|  \_____\____/|_| \_|  |_|  |______|_| \_|  |_|   
rem ============================================================================================
rem 									   FINISHES HERE 
rem ============================================================================================    
cls
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo                               CUSTOM CONTENT AKA "THE GOOD STUFF"
echo                         ----------------------------------------------
echo.                                                                           
echo CUSTOM CONTENT INSTALLATION RESULTS:  
echo.              
echo Hakchi Options Menu by CompCom                     Installed - !CUSTOM1!
echo Hibernate Mod ^(Lite^) by Swingflip                  Installed - !CUSTOM2!
echo Canoe Save Compression Mod ^(FAST^) by CompCom       Installed - !CUSTOM3!
echo RetroArch 'Neo' 1.7.1 compiled by 'The Other Guys' Installed - !CUSTOM4!
echo RetroArch 'Essential Cores'                        Installed - !CUSTOM5!
echo Hakchi Video Splash Screen Mod by 'The Other Guys' Installed - !CUSTOM6!
echo Hakchi Advanced Music Hack by Swingflip            Installed - !CUSTOM7!
echo Super Famicom English Translation by rhester72     Installed - !CUSTOM8!
echo.
echo Latest Hakchi2ce installed and optional content installed successfully!
echo You just need to flash the custom kernel to the console...
echo.
pause
rem ============================================================================================

:AskHelp
cls
set INPUT=
set /P INPUT="Do you need help on how to install/upgrade the custom kernel^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto HelpKernel
if /I "!INPUT!"=="n" goto final
echo Incorrect input & goto AskHelp
rem ============================================================================================

:HelpKernel
cls
set INPUT=
set /P INPUT="Is your console already modified^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto HelpUpgrade
if /I "!INPUT!"=="n" goto HelpNew
echo Incorrect input & goto HelpKernel
rem ============================================================================================

:HelpUpgrade
cls
echo Plug your console to the PC with the USB cable.
pause
echo.
echo Open Hakchi2 CE, select the Kernel menu and click "Uninstall".
echo.
echo **NOTE** If you get a "No kernel dump found." error, please copy your original
echo kernel (kernel.img for NES, kernel_snes.img for SNES) to the "\dump"
echo folder in the new hakchi2ce folder and try again. If you don't have your original file
echo for some reason, try to find one online matching your console and region.
pause
echo.
echo If the driver is not already installed, click "Install driver".
pause
echo.
echo Follow the instructions on the "Waiting for your NES/SNES Mini..." pop-up:
echo hold the Reset button on your console and turn it ON,
echo wait until the pop-up disappear before releasing the Reset button.
pause
echo.
echo When the un-install process is done Hakchi2 CE will ask if you want to flash
echo the Original kernel, click No.
pause
echo.
echo Now select the Kernel menu again and click "Flash custom kernel".
pause
echo.
echo Turn OFF your console then hold the Reset button and turn it ON,
echo wait until the pop-up disappear before releasing the Reset button.
pause
echo.
echo Done, your console is now ready.
pause
goto final
rem ============================================================================================

:HelpNew
cls
echo Plug your console to the PC with the USB cable.
pause
echo.
echo Open Hakchi2 CE, select the Kernel menu and click "Dump kernel".
pause
echo.
echo If the driver is not already installed, click "Install driver".
pause
echo.
echo Follow the instructions on the "Waiting for your NES/SNES Mini..." pop-up:
echo hold the Reset button on your console and turn it ON,
echo wait until the pop-up disappear before releasing the Reset button.
pause
echo.
echo Now select the Kernel menu again and click "Flash custom kernel".
pause
echo.
echo Turn OFF your console then hold the Reset button and turn it ON,
echo wait until the pop-up disappear before releasing the Reset button.
pause
echo.
echo Done, your console is now ready.
pause
goto final
rem ============================================================================================

:final
cls
echo.
echo                                   __ __     __       __   _ ___  
echo                                  / // /__ _/ /______/ /  ^(_^)_  ^|
echo                                 / _  / _ `/  '_/ __/ _ \/ / __/
echo                                /_//_/\_,_/_/\_\\__/_//_/_/____/
echo                         ----------------------------------------------
echo                                  Easy Installer/Updater v!InstallerBuild!
echo                         ----------------------------------------------
echo                               CUSTOM CONTENT AKA "THE GOOD STUFF"
echo                         ----------------------------------------------
echo.
echo Ok, you should be ready to go! If you have any issues or require any help you can find us 
echo at the reddit group 'miniSNESmods' @ https://www.reddit.com/r/miniSNESmods/
echo.
echo This release was brought you by 'The Other Guys' and Hakchi Resources
echo https://github.com/TheOtherGuys-Hakchi-Projects
echo https://www.hakchiresources.com
echo. 
echo Credits: Swingflip, CompCom, DNA64, bslenul, Defkorns 
echo Shout Outs: TeamShinkansen for Hakchi2ce and KMFDManic for his work on RA and cores
echo Special thanks to the guys who helped test the project and support us developing.
echo.
echo.
pause
rem ============================================================================================

rem remember to fix NAND install location!
rem #It's the end of the road for you dickhead...
:exit
echo.
echo You're welcome world...
echo.
exit /b


rem Module initializing
:initialize

rem Update these 3 variables if you intend to update the script...
rem Note: Change this to auto fetch the latest build
set HakchiBuild=hakchi2_CE_1.1.0
set HakchiBuildURL=https://github.com/TeamShinkansen/hakchi2/releases/download/v1.1.0/hakchi2_CE_1.1.0.zip
set HakchiBuildLastUpdated=19th February 2018

rem Dynamically create the folder browse VB script in temp directory...
del "!tmp!"\Hakchi_BrowseFolder.vbs >nul 2>&1
@echo Const MY_COMPUTER = ^&H11^& >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Const WINDOW_HANDLE = 0 >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Const OPTIONS = 0  >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo. >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Set objShell = CreateObject("Shell.Application") >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Set objFolder = objShell.Namespace(MY_COMPUTER) >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Set objFolderItem = objFolder.Self >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo strPath = objFolderItem.Path >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo. >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Set objShell = CreateObject("Shell.Application") >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Set objFolder = objShell.BrowseForFolder _ >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo     (WINDOW_HANDLE, "Select a folder:", OPTIONS, strPath) >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo. >> "!tmp!"\Hakchi_BrowseFolder.vbs     
@echo If objFolder Is Nothing Then >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo     Wscript.Quit >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo End If >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo. >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Set objFolderItem = objFolder.Self >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo objPath = objFolderItem.Path >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo. >> "!tmp!"\Hakchi_BrowseFolder.vbs
@echo Wscript.Echo objPath >> "!tmp!"\Hakchi_BrowseFolder.vbs

goto finish_initialize
rem Finished initializing

rem Functions
:msg 
echo set WshShell = WScript.CreateObject("WScript.Shell") > "!tmp!"\hakchi_msg_tmp.vbs
echo WScript.Quit (WshShell.Popup( "%~1" ,10 ,"Hakchi2ce Easy Installer/Updater", 0)) >> "!tmp!"\hakchi_msg_tmp.vbs
cscript /nologo "!tmp!"\hakchi_msg_tmp.vbs
if !errorlevel!==1 (
  echo You Clicked OK
) else (
  echo The Message timed out.
)
del "!tmp!"\tmp.vbs
EXIT /B 0
