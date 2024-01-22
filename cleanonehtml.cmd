@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

@echo Clean %GAMENAME%
@echo.
@echo Will clean generated directories
FOR /D %%p IN ("html\%GAMENAME%\Scenarios\*.*" "html\%GAMENAME%\Campaigns\*.*" "html\%GAMENAME%\Maps\*.*" "html\%GAMENAME%\QBMaps\*.*") DO echo "%%p"
@echo Cleaning...
FOR /D %%p IN ("html\%GAMENAME%\Scenarios\*.*" "html\%GAMENAME%\Campaigns\*.*" "html\%GAMENAME%\Maps\*.*" "html\%GAMENAME%\QBMaps\*.*") DO rmdir "%%p" /s /q

@echo Cleaning generated html files
if exist "html\%GAMENAME%\Scenarios\*.html" del "html\%GAMENAME%\Scenarios\*.html"
if exist "html\%GAMENAME%\Campaigns\*.html" del "html\%GAMENAME%\Campaigns\*.html"
if exist "html\%GAMENAME%\Maps\*.html" del "html\%GAMENAME%\Maps\*.html"
if exist "html\%GAMENAME%\QBMaps\*.html" del "html\%GAMENAME%\QBMaps\*.html"
@echo.

goto end

:usage
@echo cleanonehtml gamename
@echo Deletes the generated html files for gamename
pause
goto end

:end
