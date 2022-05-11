@echo off
cls
ver>nul
echo.
echo "Please, type location for Windows PE files [ Example: C:\PE ]:"
echo.
set /p perootfldr=
call copype.cmd x86 "%perootfldr%\x86"
call copype.cmd amd64 "%perootfldr%\amd64"

:mount
cls
"%DandIRoot%\x86\DISM\dism.exe" /Mount-Image /ImageFile:"%perootfldr%\X86\media\sources\boot.wim" /Index:1 /MountDir:"%perootfldr%\x86\mount"
"%DandIRoot%\amd64\DISM\dism.exe" /Mount-Image /ImageFile:"%perootfldr%\amd64\media\sources\boot.wim" /Index:1 /MountDir:"%perootfldr%\amd64\mount"

:Features
cls
dir /B "%WinPERoot%\x86\WinPE_OCs\*.cab"
echo.
echo "Y. Includes all features."
echo "N. Will not include any features."
echo "M. More information: Opens Microsoft website about optional features."
echo.
ver>nul
choice /C YNM /N /M "Select: "
if %errorlevel%==1 ( goto include_x86 )
if %errorlevel%==2 ( goto InputLocale )
if %errorlevel%==3 ( start https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-add-packages--optional-components-reference#winpe-optional-components && goto Features )
goto eof

:include_x86
cls
cd "%WinPERoot%\x86\WinPE_OCs"
"%DandIRoot%\x86\DISM\DISM.EXE" /Image:"%perootfldr%\x86\mount" /Add-Package ^
/PackagePath:WinPE-WMI.cab ^
/PackagePath:WinPE-Scripting.cab ^
/PackagePath:WinPE-NetFx.cab ^
/PackagePath:WinPE-SecureStartup.cab ^
/PackagePath:WinPE-FMAPI.cab ^
/PackagePath:WinPE-Dot3Svc.cab ^
/PackagePath:WinPE-PPPoE.cab ^
/PackagePath:WinPE-RNDIS.cab ^
/PackagePath:WinPE-PlatformId.cab ^
/PackagePath:WinPE-PowerShell.cab ^
/PackagePath:WinPE-DismCmdlets.cab ^
/PackagePath:WinPE-SecureBootCmdlets.cab ^
/PackagePath:WinPE-WinReCfg.cab ^
/PackagePath:WinPE-MDAC.cab ^
/PackagePath:WinPE-StorageWMI.cab ^
/PackagePath:WinPE-HTA.cab ^
/PackagePath:WinPE-EnhancedStorage.cab ^
/PackagePath:WinPE-WDS-Tools.cab ^
/PackagePath:WinPE-Fonts-Legacy.cab


:include_amd64
cd "%WinPERoot%\amd64\WinPE_OCs"
"%DandIRoot%\amd64\DISM\DISM.EXE" /Image:"%perootfldr%\amd64\mount" /Add-Package ^
/PackagePath:WinPE-WMI.cab ^
/PackagePath:WinPE-Scripting.cab ^
/PackagePath:WinPE-NetFx.cab ^
/PackagePath:WinPE-SecureStartup.cab ^
/PackagePath:WinPE-FMAPI.cab ^
/PackagePath:WinPE-Dot3Svc.cab ^
/PackagePath:WinPE-PPPoE.cab ^
/PackagePath:WinPE-RNDIS.cab ^
/PackagePath:WinPE-PlatformId.cab ^
/PackagePath:WinPE-PowerShell.cab ^
/PackagePath:WinPE-DismCmdlets.cab ^
/PackagePath:WinPE-SecureBootCmdlets.cab ^
/PackagePath:WinPE-WinReCfg.cab ^
/PackagePath:WinPE-MDAC.cab ^
/PackagePath:WinPE-StorageWMI.cab ^
/PackagePath:WinPE-HTA.cab ^
/PackagePath:WinPE-EnhancedStorage.cab ^
/PackagePath:WinPE-WDS-Tools.cab ^
/PackagePath:WinPE-Fonts-Legacy.cab


:multilingual
choice /C YN /M "Do we create multilanguage PE ? "
IF %errorlevel%==1 ( goto language_select )
IF %errorlevel%==2 ( goto InputLocale )

:language_select
cls
dir /A:D /B "%WinPERoot%\x86\WinPE_OCs"
echo.
echo "Write language locale from above list [Empty: Continues as en-US, Ex. fi-FI]:" 
echo.
set /p langselect=
IF [%langselect%]==[] ( goto InputLocale )

:lang_include_x86
cd "%WinPERoot%\x86\WinPE_OCs"
"%DandIRoot%\x86\DISM\DISM.EXE" /Image:"%perootfldr%\x86\mount" /Add-Package ^
/PackagePath:.\%langselect%\lp.cab ^
/PackagePath:.\%langselect%\WinPE-WMI_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-Scripting_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-NetFx_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-SecureStartup_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-Dot3Svc_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-PPPoE_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-RNDIS_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-PowerShell_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-DismCmdlets_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-WinReCfg_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-MDAC_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-StorageWMI_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-HTA_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-EnhancedStorage_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-WDS-Tools_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-Rejuv_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-SRT_%langselect%.cab


:lang_include_amd64
cd "%WinPERoot%\amd64\WinPE_OCs"
"%DandIRoot%\amd64\DISM\DISM.EXE" /Image:"%perootfldr%\amd64\mount" /Add-Package ^
/PackagePath:.\%langselect%\lp.cab ^
/PackagePath:.\%langselect%\WinPE-WMI_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-Scripting_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-NetFx_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-SecureStartup_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-Dot3Svc_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-PPPoE_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-RNDIS_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-PowerShell_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-DismCmdlets_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-WinReCfg_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-MDAC_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-StorageWMI_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-HTA_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-EnhancedStorage_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-WDS-Tools_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-Rejuv_%langselect%.cab ^
/PackagePath:.\%langselect%\WinPE-SRT_%langselect%.cab


:InputLocale

dir /A:D /B "%WinPERoot%\x86\WinPE_OCs\"
echo.
echo "Write input locale from above list:" 
echo.
set /p inputselect=
IF [%inputselect%]==[] ( goto RAMUsage )
"%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-InputLocale:%inputselect%
"%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-InputLocale:%inputselect%

:PELanguage

echo.
ver>nul
choice /C YN /M "What language would you like Windows PE to use as default language ? [C]urrent input: %inputselect% or [N]o for default: en-US"
if %errorlevel%==1 (
"%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-AllIntl:%inputselect%
"%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-AllIntl:%inputselect%
goto RAMUsage
)
if %errorlevel%==2 ( goto RAMUsage )
if %errorlevel%==255 ( goto RAMUsage )

:RAMUsage
cls
echo.
echo "How much scratch space / RAM memory you want the PE to use ? [valid values: 32,64,128,256,512-2047]"
echo "NOTE: WinPE takes about 448-512MB as default, ideally using dism inside winpe requires about 1.5GB of free RAM."
echo.
echo "Please, select memory amount [Enter leaves dynamic allocation modified by installed RAM while booting]:"
echo.
set /p MemUsage=
if %MemUsage% EQU 32 ( "%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-ScratchSpace:%MemUsage% & "%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-ScratchSpace:%MemUsage% )
if %MemUsage% EQU 64 ( "%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-ScratchSpace:%MemUsage% & "%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-ScratchSpace:%MemUsage% )
if %MemUsage% EQU 128 ( "%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-ScratchSpace:%MemUsage% & "%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-ScratchSpace:%MemUsage% )
if %MemUsage% EQU 256 ( "%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-ScratchSpace:%MemUsage% & "%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-ScratchSpace:%MemUsage% )
if %MemUsage% EQU 512 ( "%DandIRoot%\x86\DISM\dism.exe" /Image:%perootfldr%\x86\mount /Set-ScratchSpace:%MemUsage% & "%DandIRoot%\amd64\DISM\dism.exe" /Image:%perootfldr%\amd64\mount /Set-ScratchSpace:%MemUsage% )
if %MemUsage% GEQ 513 (
cls
echo.
echo ------------------------------------------------------------------------------------
echo  Modifying scratch space.... Size: %MemUsage% MB
echo ------------------------------------------------------------------------------------
echo.
REG LOAD HKLM\x86_temp %perootfldr%\x86\mount\Windows\System32\CONFIG\SYSTEM
REG LOAD HKLM\amd64_temp %perootfldr%\amd64\mount\Windows\System32\CONFIG\SYSTEM
REG ADD HKLM\x86_temp\ControlSet001\Services\FBWF /v WinPECacheThreshold /t REG_DWORD /d %MemUsage% /f
REG ADD HKLM\amd64_temp\ControlSet001\Services\FBWF /v WinPECacheThreshold /t REG_DWORD /d %MemUsage% /f
REG UNLOAD HKLM\x86_temp
REG UNLOAD HKLM\amd64_temp
)

:UnMount
"%DandIRoot%\x86\DISM\dism.exe" /Unmount-Image /MountDir:"%perootfldr%\x86\mount" /Commit
"%DandIRoot%\amd64\DISM\dism.exe" /Unmount-Image /MountDir:"%perootfldr%\amd64\mount" /Commit

:ISO
echo.
ver>nul
Choice /C YN /M "Do we make cd-images ?"
IF %errorlevel%==1 ( call MakeWinPEMedia /ISO %perootfldr%\x86 D:\x86.iso & call MakeWinPEMedia /ISO %perootfldr%\amd64 D:\amd64.iso )
IF %errorlevel%==2 ( goto eof )
IF %errorlevel%==255 ( goto eof )

:cleanup
echo.
ver>nul
Choice /C YN /M "Do we wanna clean-up and delete the PE work folder ?"
IF %errorlevel%==1 ( RMDIR /S /Q %perootfldr% )
IF %errorlevel%==2 ( goto eof )
IF %errorlevel%==255 ( goto eof )

:eof
