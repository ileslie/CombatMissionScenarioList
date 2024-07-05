@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

call updateonelist.cmd %GAMENAME%
if errorlevel 1 exit /b 1

call generateonehtml.cmd %GAMENAME% %1
if errorlevel 1 exit /b 1

call ftpone.cmd %GAMENAME%
if errorlevel 1 exit /b 1

goto end

:usage
@echo updatefully gamename [displayname]
@echo Run CM2 Scanner to update the scenario, campaign, map and qbmap list for gamename then generate the html and finally upload the html files.
pause
goto end


:end
