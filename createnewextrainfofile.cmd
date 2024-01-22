@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

if not exist "%GAMENAME%" (@echo %GAMENAME% not found & @echo. & goto usage)

if "%URLPARSER_HOME%" == "" set URLPARSER_HOME=P:\ParseShortCutLinks
if "%URLPARSER_JAR%" == "" set URLPARSER_JAR=ParseShortCutLinks.jar


echo Processing %GAMENAME%
echo Generating Extra_Info_New.xml for Scenario list
cd %GAMENAME%\Scenarios
echo Inside %cd% run java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml
java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml

echo Generating Extra_Info_New.xml for Campaign list
cd ../Campaigns
echo Inside %cd% run java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -cam -dir=. -xmlout=Extra_Info_New.xml
java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml

echo Generating Extra_Info_New.xml for Map list
cd ../Maps
echo Inside %cd% run java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml
java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml

echo Generating Extra_Info_New.xml for QBMap list
cd ../QBMaps
echo Inside %cd% run java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml
java -jar %URLPARSER_HOME%\%URLPARSER_JAR% -f -url -btt -dir=. -xmlout=Extra_Info_New.xml

cd ..
cd ..
@echo.
@echo.

goto end

:usage
@echo createnewextrainfofile gamename
@echo Run ParseShortCutLinks to update the Extra_Info.xml files under scenario, campaign, map and qbmap list for gamename.
@echo.
@echo This creates a Extra_Info_New.xml file for scenaro and campaign files for gamename. This allows you to manually 
@echo edit the Extra_Info.xml and Extra_Info_New.xml file to merge any new scenario or campaign files added to the 
@echo directory.
@echo.
pause
goto end


:end
