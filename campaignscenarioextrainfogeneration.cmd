@echo off
setlocal enableDelayedExpansion
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

@echo Generating Extra_Info.xml files for the campaign scenarios for %GAMENAME%
@echo.
@echo Found generated directories
cd "%GAMENAME%\Campaigns"
FOR /D %%p IN (*.*) DO (IF NOT "%%p" == "campaignpics" (echo will look in "%%p"))
@echo Generating...
FOR /D %%p IN (*.*) DO (IF NOT "%%p" == "campaignpics" (set TEMPNAME=%%p&set NAME=!TEMPNAME:~0,-10!&java -jar ..\..\ParseShotCutLinks.jar -btt -dir="%%p" -xmlout="Extra_Info-!NAME!.xml"))
cd ..\..
@echo.

goto end

:usage
@echo campaignscenarioextrainfogeneration gamename
@echo Generates Extra_Info files for the generated sub folders under gamename\Campaigns
pause
goto end

:end
