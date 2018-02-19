@echo off
mode con: cols=92 lines=35
setlocal enabledelayedexpansion
color 0A

rem Update these 3 variables if you intend to update the script...
rem Note: Change this to auto fetch the latest build
set HakchiBuild=hakchi2_CE_1.0.1
set HakchiBuildURL=https://github.com/TeamShinkansen/hakchi2/releases/download/v1.0.1/hakchi2_CE_1.0.1.zip
set HakchiBuildLastUpdated=6th Feburary 2018

rem set "file=music.mp3"
rem ( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
rem   echo Sound.URL = "%file%"
rem   echo Sound.Controls.play
rem   echo do while Sound.currentmedia.duration = 0
rem   echo wscript.sleep 100
rem   echo loop
rem   echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
rem start /min sound.vbs

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
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
pause
rem ============================================================================================


rem ============================================================================================
rem SCREEN 2 - Info screen...
rem ============================================================================================
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo  if you have any issues with the install process you can ask for help at the SNES mini
echo  reddit page at: www.reddit.com/r/miniSNESmods
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
echo.
pause
rem ============================================================================================

rem lets do this shit...

:screen3
rem ============================================================================================
rem SCREEN 3 - USB-HOST or NAND screen...
rem ============================================================================================
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo                         ^| (USB-HOST mode uses external USB storage)  ^|
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
rem ============================================================================================
rem SCREEN 4 - Install or update...
rem ============================================================================================
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
rem ============================================================================================
rem SCREEN 5 - Set working directory...
rem ============================================================================================
if "!INSTALL_MODE!" == "UPDATE " (
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  ^(_^)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo                         ^| Please enter the directory your current    ^|
echo                         ^| hakchi2 folder is located.                 ^|
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
echo ^(Your current directory is: !cd!\^)
:Ask
set /P inputdirname= Please enter a valid directory:
rem clean up any potential mistakes....
set "inputdirname=!inputdirname:/=\!"
set "inputdirname=!inputdirname:;=:!"
if "!HAKCHI_MODE!" == "NAND" (
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  ^(_^)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo ^(Your current directory is: !cd!\^)
:Ask
set /P inputnanddirname= Please enter a valid directory:
rem clean up any potential mistakes....
set "inputnanddirname=!inputnanddirname:/=\!"
set "inputnanddirname=!inputnanddirname:;=:!"
)
goto screen6
)
if "!INSTALL_MODE!" == "INSTALL" (
if "!HAKCHI_MODE!" == "NAND" (
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  ^(_^)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo ^(Your current directory is: !cd!\^)
:Ask
set /P inputdirname= Please enter a valid directory:
rem clean up any potential mistakes....
set "inputdirname=!inputdirname:/=\!"
set "inputdirname=!inputdirname:;=:!"
goto screen6
)
if "!HAKCHI_MODE!" == "USB " (
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  ^(_^)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo ^(Your current directory is: !cd!\^)
:Ask
set /P inputdirname= Please enter a valid directory:
rem clean up any potential mistakes....
set "inputdirname=!inputdirname:/=\!"
set "inputdirname=!inputdirname:;=:!"
goto screen6
)
)
rem ============================================================================================  

:screen6
rem ============================================================================================
rem SCREEN 6 - Confirmation...
rem ============================================================================================
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
rem ============================================================================================
rem SCREEN 7 - Do stuff and run the app....
rem ============================================================================================
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
echo.
echo.
echo.
echo.
echo.
echo.                                              
echo.
echo checking internet connection...
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
if exist !temp!\package.zip (
del !temp!\package.zip
)
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('!HakchiBuildURL!', '!temp!\package.zip')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download Hakchi from URL: !HakchiBuildURL!
	pause
	exit /b
)
if exist !temp!\package.zip ( echo [OK] - Downloaded successfully^! )
echo.

echo Unzipping package...
mkdir !tmp!\hakchi2ce
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('!temp!\hakchi2ce'); $zip = $shell.NameSpace('!temp!\package.zip'); $target.CopyHere($zip.Items(), 16); }"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download unzip downloaded package
	del !temp!\package.zip
	rmdir /S /Q !tmp!\hakchi2ce
	pause
	exit /b
)
del !temp!\package.zip
echo [OK] - Unzipped succesfully!

rem ============================================================================================
rem INSTALLER/UPDATE FOLDERS
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputnanddirname!
		xcopy /s /y !temp!\hakchi2ce !inputnanddirname!
		if exist !inputnanddirname!\hakchi.exe (
			echo [OK] - Copied hakchi2ce succesfully! 
			rem rmdir /S /Q !tmp!\hakchi2ce
		)
		if not exist !inputnanddirname!\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q !tmp!\hakchi2ce
			pause
			exit /b
		)
		echo Copying old Hakchi2 files over to new build...
		echo If you are asked if something is a file or directory, type D for directory...
		pause
		xcopy /s /y !inputdirname!\games !inputnanddirname!\games
		xcopy /s /y !inputdirname!\games_snes !inputnanddirname!\games_snes
		xcopy /s /y !inputdirname!\config !inputnanddirname!\config
		xcopy /s /y !inputdirname!\art !inputnanddirname!\art
		xcopy /s /y !inputdirname!\folder_images !inputnanddirname!\folder_images
		xcopy /s /y !inputdirname!\user_mods !inputnanddirname!\user_mods
		xcopy /s /y !tmp!\hakchi2ce\user_mods !inputnanddirname!\user_mods
		rem We need to set the flag to restore originals (this doesn't exist yet but it will)
		echo [OK] - Copied old Hakchi2 files succesfully!
		rmdir /S /Q !tmp!\hakchi2ce
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!
		xcopy /s !temp!\hakchi2ce !inputdirname!
		if exist !inputdirname!\hakchi.exe (
			echo [OK] - Copied hakchi2ce succesfully! 
			rmdir /S /Q !tmp!\hakchi2ce
		)
		if not exist !inputdirname!\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q !tmp!\hakchi2ce
			pause
			exit /b
		)
	)
)
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: %inputdirname:~0,2%\data\hakchi2ce
		xcopy /s /y !temp!\hakchi2ce %inputdirname:~0,2%\data\hakchi2ce
		if exist %inputdirname:~0,2%\data\hakchi2ce\hakchi.exe (
			echo [OK] - Copied hakchi2ce succesfully! 
			rem rmdir /S /Q !tmp!\hakchi2ce
		)
		if not exist %inputdirname:~0,2%\data\hakchi2ce\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q !tmp!\hakchi2ce
			pause
			exit /b
		)
		echo Copying old Hakchi2 files over to new build...
		echo If you are asked if something is a file or directory, type D for directory...
		pause
		xcopy /s /y !inputdirname!\games %inputdirname:~0,2%\data\hakchi2ce\games
		xcopy /s /y !inputdirname!\games_snes %inputdirname:~0,2%\data\hakchi2ce\games_snes
		xcopy /s /y !inputdirname!\config %inputdirname:~0,2%\data\hakchi2ce\config
		xcopy /s /y !inputdirname!\art %inputdirname:~0,2%\data\hakchi2ce\art
		xcopy /s /y !inputdirname!\folder_images %inputdirname:~0,2%\data\hakchi2ce\folder_images
		xcopy /s /y !inputdirname!\user_mods %inputdirname:~0,2%\data\hakchi2ce\user_mods
		xcopy /s /y !tmp!\hakchi2ce\user_mods %inputdirname:~0,2%\data\hakchi2ce\user_mods
		rem We need to set the flag to restore originals (this doesn't exist yet but it will)
		echo [OK] - Copied old Hakchi2 files succesfully!
		rmdir /S /Q !tmp!\hakchi2ce
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\data\hakchi2ce
		xcopy /s !temp!\hakchi2ce !inputdirname!\data\hakchi2ce
		if exist !inputdirname!\data\hakchi2ce\hakchi.exe (
			echo [OK] - Copied hakchi2ce succesfully! 
			rmdir /S /Q !tmp!\hakchi2ce
		)
		if not exist !inputdirname!\data\hakchi2ce\hakchi.exe (
			echo [ERROR] - Failed to copy hakchi2ce 
			rmdir /S /Q !tmp!\hakchi2ce
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
rem ============================================================================================
rem SCREEN 8 - Custom good shit...
rem ============================================================================================
echo.
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
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
echo.
echo ----------------------------------------------
echo Hakchi Options Menu by CompCom
echo ----------------------------------------------
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
set CustomContentBuild=XXXXX
set CustomContentBuildURL=XXXXX
set CustomContentBuildLastUpdated=6th Feburary 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue1 )
if exist !temp!\package.zip (
del !temp!\package.zip
)
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '!temp!\package.zip')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist !temp!\package.zip ( echo [OK] - Downloaded successfully^! )
echo.

echo Unzipping package...
mkdir !tmp!\!CustomContentBuild!
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('!temp!\!CustomContentBuild!'); $zip = $shell.NameSpace('!temp!\package.zip'); $target.CopyHere($zip.Items(), 16); }"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download unzip downloaded package
	del !temp!\package.zip
	rmdir /S /Q !tmp!\!CustomContentBuild!
	pause
	exit /b
)
del !temp!\package.zip
echo [OK] - Unzipped succesfully!
rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y !temp!\!CustomContentBuild! !inputnanddirname!\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s !temp!\!CustomContentBuild! !inputdirname!\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y !temp!\!CustomContentBuild! %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild! %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s !temp!\!CustomContentBuild! %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild! %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rmdir /S /Q !tmp!\!CustomContentBuild!
set CUSTOM1=Y
:Continue1
if NOT DEFINED CUSTOM1 (set CUSTOM1=N)
echo.
rem ============================================================================================
rem don't install power mod if option mod installed as it conflicts. Actually, it doesn't... Just don't do it.
if "!CUSTOM1!" == "N" (
	echo.
	echo ----------------------------------------------
	echo Hibernate Mod ^(Lite^) by Swingflip
	echo ----------------------------------------------
	echo This is a mod which enables a power menu when you hold L ^+ R ^+ UP during gameplay
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
	set CustomContentBuildLastUpdated=6th Feburary 2018
	echo Downloading the latest !CustomContentBuild! build...
	if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue2 )
	if exist !temp!\!CustomContentBuild!.hmod (
	del !temp!\!CustomContentBuild!.hmod
	)
	powershell.exe -command "(New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '!temp!\!CustomContentBuild!.hmod')"
	if not %errorlevel%==0 (
		echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
		pause
		exit /b
	)
	if exist !temp!\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
	echo.

	rem echo Unzipping package...
	rem mkdir !tmp!\!CustomContentBuild!
	rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('!temp!\!CustomContentBuild!'); $zip = $shell.NameSpace('!temp!\package.zip'); $target.CopyHere($zip.Items(), 16); }"
	rem if not %errorlevel%==0 (
	rem 	echo [ERROR] - Couldn't download unzip downloaded package
	rem 	del !temp!\package.zip
	rem 	rmdir /S /Q !tmp!\!CustomContentBuild!
	rem 	pause
	rem 	exit /b
	rem )
	rem del !temp!\package.zip
	rem echo [OK] - Unzipped succesfully!
	
	rem We transfer directly into the hmod so they get installed during the kernel flash
	if "!HAKCHI_MODE!" == "NAND" (
		if "!INSTALL_MODE!" == "UPDATE " (
			echo Copying files over to: !inputdirname!\mods\hmods
			xcopy /s /y !temp!\!CustomContentBuild!.hmod !inputnanddirname!\mods\hmods
		)
		if "!INSTALL_MODE!" == "INSTALL" (
			echo Copying files over to: !inputdirname!\mods\hmods
			xcopy /s !temp!\!CustomContentBuild!.hmod !inputdirname!\mods\hmods
		)
	)
	rem We transfer to the transfer folder as these should just install when run
	if "!HAKCHI_MODE!" == "USB " (
		if "!INSTALL_MODE!" == "UPDATE " (
			mkdir %inputdirname:~0,2%\hakchi\transfer		
			echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
			xcopy /s /y !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
			echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
			xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
		)
		if "!INSTALL_MODE!" == "INSTALL" (
			mkdir !inputdirname!\hakchi\transfer
			echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
			xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
			echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
			xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
		)
	)
	echo [OK] - Installed !CustomContentBuild! Successfully!
	rmdir /S /Q !tmp!\!CustomContentBuild!.hmod
	set CUSTOM2=Y
	:Continue2
	if NOT DEFINED CUSTOM2 ( set CUSTOM2=N )
	echo.
)
rem ============================================================================================
echo.
echo ----------------------------------------------
echo Canoe Save Compression Mod ^(FAST^) by CompCom
echo ----------------------------------------------
echo This mod compresses all canoe save states using 7zip. This turns canoe save states from
echo 2mb to less than 300kb in most cases.
:AskCustomContent3
set INPUT=
set /P INPUT="Do you want to install Canoe Save Compression Mod^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent3
if /I "!INPUT!"=="n" goto Continue3
echo Incorrect input & goto AskCustomContent3
:InstallCustomContent3
set CustomContentBuild=canoe_save_compress_fast_v1_2
set CustomContentBuildURL=https://github.com/CompCom/hmrepo/raw/master/canoe_save_compress_fast.hmod
set CustomContentBuildLastUpdated=9th Feburary 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue3 )
if exist !temp!\!CustomContentBuild!.hmod (
del !temp!\!CustomContentBuild!.hmod
)
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '!temp!\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist !temp!\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir !tmp!\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('!temp!\!CustomContentBuild!'); $zip = $shell.NameSpace('!temp!\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del !temp!\package.zip
rem 	rmdir /S /Q !tmp!\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del !temp!\package.zip
rem echo [OK] - Unzipped succesfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y !temp!\!CustomContentBuild!.hmod !inputnanddirname!\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s !temp!\!CustomContentBuild!.hmod !inputdirname!\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rmdir /S /Q !tmp!\!CustomContentBuild!.hmod
set CUSTOM3=Y
:Continue3
if NOT DEFINED CUSTOM3 ( set CUSTOM3=N )
echo.
rem ============================================================================================
echo.
echo ----------------------------------------------
echo RetroArch 1.7.0 compiled by KMFDManic
echo ----------------------------------------------
echo Retroarch is the core application for your emulation needs. You will need RetroArch if you
echo intend on using any emulator on the system that isn't the default built in one. This
echo retroarch is set up specificly to work with the current release of Hakchi2ce
:AskCustomContent4
set INPUT=
set /P INPUT="Do you want to install RetroArch 1.7.0^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent4
if /I "!INPUT!"=="n" goto Continue4
echo Incorrect input & goto AskCustomContent4
:InstallCustomContent4
set CustomContentBuild=RetroArch_v1_7_0
set CustomContentBuildURL=https://github.com/KMFDManic/NESC-SNESC-Modifications/releases/download/v.2.5-2018-CE/_km_retroarch_170.hmod
set CustomContentBuildLastUpdated=9th Feburary 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue4 )
if exist !temp!\!CustomContentBuild!.hmod (
del !temp!\!CustomContentBuild!.hmod
)
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '!temp!\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist !temp!\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir !tmp!\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('!temp!\!CustomContentBuild!'); $zip = $shell.NameSpace('!temp!\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del !temp!\package.zip
rem 	rmdir /S /Q !tmp!\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del !temp!\package.zip
rem echo [OK] - Unzipped succesfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y !temp!\!CustomContentBuild!.hmod !inputnanddirname!\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s !temp!\!CustomContentBuild!.hmod !inputdirname!\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rmdir /S /Q !tmp!\!CustomContentBuild!.hmod
set CUSTOM4=Y
:Continue4
if NOT DEFINED CUSTOM4 ( set CUSTOM4=N )
echo.
rem ============================================================================================
echo.
echo ----------------------------------------------
echo Super Famicom English Translation by rhester72
echo ----------------------------------------------
echo This is a mod which will translate the Super famicom menu into english. Obviously this is
echo only required if you have a Super Famicom and want it translated into english...
echo I highly recommended NOT installing this on anything but a Super Famicom...
:AskCustomContent6
set INPUT=
set /P INPUT="Do you want to install Super Famicom Translation^? (Y/N)" !=!
if /I "!INPUT!"=="y" goto InstallCustomContent6
if /I "!INPUT!"=="n" goto Continue6
echo Incorrect input & goto AskCustomContent6
:InstallCustomContent6
set CustomContentBuild=sfc_eng_menu_hack_v0_4
set CustomContentBuildURL=http://www.rendezvo.us/snes/sfc_eng_menu_hack-0.4.hmod
set CustomContentBuildLastUpdated=9th Feburary 2018
echo Downloading the latest !CustomContentBuild! build...
if "!CustomContentBuild!" == "XXXXX" ( echo Unfortunately this mod is unavailable at the moment...Skipping Install... && goto Continue6 )
if exist !temp!\!CustomContentBuild!.hmod (
del !temp!\!CustomContentBuild!.hmod
)
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('!CustomContentBuildURL!', '!temp!\!CustomContentBuild!.hmod')"
if not %errorlevel%==0 (
	echo [ERROR] - Couldn't download !CustomContentBuild! from URL: !CustomContentBuildURL!
	pause
	exit /b
)
if exist !temp!\!CustomContentBuild!.hmod ( echo [OK] - Downloaded successfully^! )
echo.

rem echo Unzipping package...
rem mkdir !tmp!\!CustomContentBuild!
rem powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('!temp!\!CustomContentBuild!'); $zip = $shell.NameSpace('!temp!\package.zip'); $target.CopyHere($zip.Items(), 16); }"
rem if not %errorlevel%==0 (
rem 	echo [ERROR] - Couldn't download unzip downloaded package
rem 	del !temp!\package.zip
rem 	rmdir /S /Q !tmp!\!CustomContentBuild!
rem 	pause
rem 	exit /b
rem )
rem del !temp!\package.zip
rem echo [OK] - Unzipped succesfully!

rem We transfer directly into the hmod so they get installed during the kernel flash
if "!HAKCHI_MODE!" == "NAND" (
	if "!INSTALL_MODE!" == "UPDATE " (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s /y !temp!\!CustomContentBuild!.hmod !inputnanddirname!\mods\hmods
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		echo Copying files over to: !inputdirname!\mods\hmods
		xcopy /s !temp!\!CustomContentBuild!.hmod !inputdirname!\mods\hmods
	)
)
rem We transfer to the transfer folder as these should just install when run
if "!HAKCHI_MODE!" == "USB " (
	if "!INSTALL_MODE!" == "UPDATE " (
		mkdir %inputdirname:~0,2%\hakchi\transfer		
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s /y !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
	if "!INSTALL_MODE!" == "INSTALL" (
		mkdir !inputdirname!\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\hakchi\transfer
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\hakchi\transfer
		echo Copying files over to: %inputdirname:~0,2%\data\transfer_backup
		xcopy /s !temp!\!CustomContentBuild!.hmod %inputdirname:~0,2%\data\transfer_backup
	)
)
echo [OK] - Installed !CustomContentBuild! Successfully!
rmdir /S /Q !tmp!\!CustomContentBuild!.hmod
set CUSTOM6=Y
:Continue6
if NOT DEFINED CUSTOM6 ( set CUSTOM6=N )
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
echo                            __ __     __       __   _ ___    _________
echo                           / // /__ _/ /______/ /  (_)_  ^|  / ___/ __/
echo                          / _  / _ `/  '_/ __/ _ \/ / __/  / /__/ _/  
echo                         /_//_/\_,_/_/\_\\__/_//_/_/____/  \___/___/  
echo                         ----------------------------------------------
echo                                Easy Web Installer/Updater v1.0
echo                         ----------------------------------------------
echo                               CUSTOM CONTENT AKA "THE GOOD STUFF"
echo                         ----------------------------------------------
echo.                                                                           
echo CUSTOM CONTENTINSTALLATION RESULTS:  
echo.              
echo Hakchi Options Menu by CompCom                   Installed - !CUSTOM1!
echo Hibernate Mod ^(Lite^) by Swingflip              Installed - !CUSTOM2!
echo Canoe Save Compression Mod ^(FAST^) by CompCom   Installed - !CUSTOM3!
echo RetroArch 1.7.0 compiled by KMFDManic          Installed - !CUSTOM4!
rem saving Custom 5 for essential cores for RetroArch
echo Super Famicom English Translation by rhester72 Installed - !CUSTOM6!
echo.
echo.
echo Latest Hakchi2ce installed and optional content installed. Press any key to continue to
echo the last step regarding flashing the kernel and you are all good to go
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
pause
echo.
echo If the driver is not already installed, click "Install driver".
pause
echo.
echo Now hold the Reset button on your console and turn it ON,
echo wait until the pop-up disappear before releasing the Reset button.
pause
echo.
echo When the uninstall process is done Hakchi2 CE will ask if you want to flash
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
echo Now hold the Reset button on your console and turn it ON,
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
echo Bla bla bla, final words, bla bla bla.
pause
rem ============================================================================================

rem remember to fix nand install location!
rem #It's the end of the road for you dickhead...
:exit
echo.
echo You're welcome world...
echo.
exit /b
