@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

@echo Clean %GAMENAME%
@echo.
@echo Will clean generated directories
FOR /D %%p IN ("%GAMENAME%\Scenarios\*.*" "%GAMENAME%\Campaigns\*.*" "%GAMENAME%\Maps\*.*" "%GAMENAME%\QBMaps\*.*") DO echo "%%p"

Choice /C yn /M "Continue and delete all generated files"
if %errorlevel%==2 exit /b 1

@echo Cleaning...
FOR /D %%p IN ("%GAMENAME%\Scenarios\*.*" "%GAMENAME%\Campaigns\*.*" "%GAMENAME%\Maps\*.*" "%GAMENAME%\QBMaps\*.*") DO rmdir "%%p" /s /q

@echo Cleaning file lists
if exist "%GAMENAME%\Scenarios\Scenario_Listing.xml" del "%GAMENAME%\Scenarios\Scenario_Listing.xml"
if exist "%GAMENAME%\Campaigns\Campaign_Listing.xml" del "%GAMENAME%\Campaigns\Campaign_Listing.xml"
if exist "%GAMENAME%\Maps\Map_Listing.xml" del "%GAMENAME%\Maps\Map_Listing.xml"
if exist "%GAMENAME%\QBMaps\QBMap_Listing.xml" del "%GAMENAME%\QBMaps\QBMap_Listing.xml"
@echo.
@echo.

goto end

:usage
@echo cleanonelist gamename
@echo Deletes the generated sub folders under gamename\Scenarios, gamename\Campaigns, gamename\Maps, gamename\QBMaps and the campaign, scenario, map and qbmap lists
pause
goto end

:end
