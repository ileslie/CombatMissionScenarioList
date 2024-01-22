@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

call updateonelist.cmd %GAMENAME%

call generateonehtml.cmd %GAMENAME% %1

goto end

:usage
@echo updatelocally gamename [displayname]
@echo Run CM2 Scanner to update the scenario, campaign, map and qbmap list for gamename then generate the html locally.
pause
goto end


:end
