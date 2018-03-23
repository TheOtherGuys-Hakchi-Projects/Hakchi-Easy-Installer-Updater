[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=0
UseLongFileName=0
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=
DisplayLicense=C:\Users\Ryan Hamlin\Desktop\Hakchi Easy Installer-Updater\Hakchi Easy Installer-Updater\LICENSE.txt
FinishMessage=Presented by www.hakchiresources.com
TargetName=C:\Users\Ryan Hamlin\Desktop\Hakchi Easy Installer-Updater\Hakchi Easy Installer-Updater\Hakchi Easy Installer-Updater.exe
FriendlyName=Hakchi Easy Installer Updater
AppLaunched=cmd /c Hakchi_Easy_Install-Updater.bat
PostInstallCmd=cmd /K "HAKCHI~1.BAT"
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0="Hakchi_Easy_Install-Updater.bat"
FILE1="wget.exe"
[SourceFiles]
SourceFiles0=C:\Users\Ryan Hamlin\Desktop\Hakchi Easy Installer-Updater\Hakchi Easy Installer-Updater\
[SourceFiles0]
%FILE0%=
%FILE1%=
