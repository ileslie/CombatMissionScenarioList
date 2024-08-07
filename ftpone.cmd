@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

rem Verify that FTP log in info is available
if "%FTP_USER%" == "" echo FTP_USER must be set & pause & goto end
if "%FTP_CREDENTIALS%" == "" echo FTP_CREDENTIALS must be set & pause & goto end

echo Uploading html for %GAMENAME%
echo open sftp://%FTP_USER%:%FTP_CREDENTIALS%@ftp.lesliesoftware.com/> ftpcmd.dat

echo option batch continue>> ftpcmd.dat
echo option confirm off>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%">> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Campaigns">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat

echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Campaigns">> ftpcmd.dat
echo lcd "html/%GAMENAME%/Campaigns">> ftpcmd.dat

echo put *.html>> ftpcmd.dat

rem Actually cd to the directory so the in clause will just be the dir name
cd html\%GAMENAME%\Campaigns

FOR /D %%p IN (*) DO (
	echo "%%p"
    echo option batch continue>> ..\..\..\ftpcmd.dat
    echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Campaigns/%%p">> ..\..\..\ftpcmd.dat
    echo option batch abort>> ..\..\..\ftpcmd.dat
	echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Campaigns/%%p">> ..\..\..\ftpcmd.dat
	echo lcd "%%p">> ..\..\..\ftpcmd.dat

	if exist "%%p\*.html" (
		echo put *.html>> ..\..\..\ftpcmd.dat
	)
	
	if exist "%%p\*.jpg" (
		echo put *.jpg>> ..\..\..\ftpcmd.dat
	)
	
	if exist "%%p\*.png" (
		echo put *.png>> ..\..\..\ftpcmd.dat
	)
	
	if exist "%%p\scenpics\" (
        echo option batch continue>> ..\..\..\ftpcmd.dat
        echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Campaigns/%%p/scenpics">> ..\..\..\ftpcmd.dat
        echo option batch abort>> ..\..\..\ftpcmd.dat
	    echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Campaigns/%%p/scenpics">> ..\..\..\ftpcmd.dat
		echo lcd scenpics>> ..\..\..\ftpcmd.dat
	    echo put *.jpg>> ..\..\..\ftpcmd.dat
		echo lcd ..>> ..\..\..\ftpcmd.dat
	)
	echo lcd ..>> ..\..\..\ftpcmd.dat
)

rem Go back to the dir where the command is being run so the paths match up when calling the ftp command
cd ..\..\..

echo option batch continue>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Scenarios">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Scenarios">> ftpcmd.dat
echo lcd ../Scenarios>> ftpcmd.dat
echo put *.html>> ftpcmd.dat

echo option batch continue>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Scenarios/scenpics">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Scenarios/scenpics">> ftpcmd.dat
echo lcd "scenpics">> ftpcmd.dat
echo put "*.jpg">> ftpcmd.dat


echo option batch continue>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Maps">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Maps">> ftpcmd.dat
echo lcd ../../Maps>> ftpcmd.dat
echo put *.html>> ftpcmd.dat

echo option batch continue>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Maps/scenpics">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/Maps/scenpics">> ftpcmd.dat
echo lcd "scenpics">> ftpcmd.dat
echo put "*.jpg">> ftpcmd.dat


echo option batch continue>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/QBMaps">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/QBMaps">> ftpcmd.dat
echo lcd ../../QBMaps>> ftpcmd.dat
echo put *.html>> ftpcmd.dat

echo option batch continue>> ftpcmd.dat
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/QBMaps/scenpics">> ftpcmd.dat
echo option batch abort>> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/%GAMENAME%/QBMaps/scenpics">> ftpcmd.dat
echo lcd "scenpics">> ftpcmd.dat
echo put "*.jpg">> ftpcmd.dat


echo bye>> ftpcmd.dat

rem Actually upload the files
"c:\Program Files (x86)\WinSCP\WinSCP.com" /ini=null /log=sftp%GAMENAME%.log /script=ftpcmd.dat
if errorlevel 1 goto ftperror
echo %GAMENAME% files successfully uploaded to the website.
del ftpcmd.dat
echo FTP upload successful %date%-%time%>>FTPStatusFor%GAMENAME%.txt
goto end 

:ftperror
echo There was an error uploading %GAMENAME% files to the web site. 
echo The command file ftpcmd.dat has been preserved.
echo FTP upload failed %date%-%time% - See sftp%GAMENAME%.log for more infomration
echo FTP upload failed %date%-%time% - See sftp%GAMENAME%.log for more infomration>>FTPStatusFor%GAMENAME%.txt
exit /b 1

:usage
@echo ftpone gamename
@echo Upload the html and supporting files for gamename
pause
goto end

:end
