@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

if "%CM2SCANNER_HOME%" == "" set CM2SCANNER_HOME=P:\ScAnCaDe
if "%CMSCANNER_JAR%" == "" set CMSCANNER_JAR=CMx2_ScAn_CaDe_v2.2.jar

echo Processing %GAMENAME%
echo Generating Scenario list
cd %GAMENAME%\Scenarios
echo Inside %cd% run java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
if errorlevel 1 (echo There was an error scanning Scenarios for %GAMENAME%. See exception.log for details. & exit /b 1)
if not exist Scenario_Listing.xml copy ..\..\Empty_Listing.xml Scenario_Listing.xml

echo Generating Campaign list
cd ../Campaigns
echo Inside %cd% run java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
if errorlevel 1 (echo There was an error scanning Capmaigns for %GAMENAME%. See exception.log for details. & exit /b 1)
if not exist Campaign_Listing.xml copy ..\..\Empty_Listing.xml Campaign_Listing.xml

echo Generating Map list
cd ../Maps
echo Inside %cd% run java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
if errorlevel 1 (echo There was an error scanning Maps for %GAMENAME%. See exception.log for details. & exit /b 1)
if not exist Scenario_Listing.xml copy ..\..\Empty_Listing.xml Scenario_Listing.xml

echo Generating QBMap list
cd ../QBMaps
echo Inside %cd% run java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
java -jar %CM2SCANNER_HOME%\%CMSCANNER_JAR% -p btt -p bmp -s
if errorlevel 1 (echo There was an error scanning QBMaps for %GAMENAME%. See exception.log for details. & exit /b 1)
if not exist Scenario_Listing.xml copy ..\..\Empty_Listing.xml Scenario_Listing.xml

cd ..
cd ..
@echo.
@echo.

goto end

:usage
@echo updateonelist gamename
@echo Run CM2 Scanner to update the scenario, campaign, map and qbmap list for gamename
pause
goto end


:end
