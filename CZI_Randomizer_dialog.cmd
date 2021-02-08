@echo off
setlocal enabledelayedexpansion
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose the input image folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder1=%%I"
cd /d "!folder1!"
set "psCommand2="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose the destination image folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell !psCommand2!`) do set "folder=%%I"
if not exist "!folder!" mkdir "!folder!"
echo:Copying from "!folder1!" to "!folder!"
echo:"Nb","Original","NEW"> !folder!\translationTable.csv
set ordinal=0
for /F  "delims=" %%i in ('dir /b /s *.czi') do (
	set myR1=!random!
	set myR1=00000!myR1!
	set myR2=!random!
	set myR2=00000!myR2!
	set myRandom=!myR1:~-5!_!myR2:~-5!
	set /a ordinal=!ordinal! + 1
	echo:!ordinal!,"%%i","!myRandom!.czi">> !folder!\translationTable.csv
	echo:Copying !ordinal! : "%%i" to "!folder!\!myRandom!.czi"
	copy "%%i" "!folder!\!myRandom!.czi"
)
exit/B
