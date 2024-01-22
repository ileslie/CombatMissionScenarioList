@echo off
if "%1" == "" goto usage

rem Retrieve the mandatory command line options
set GAMENAME=%1
shift

set DISPLAYNAMEPARAM=
if '%1' == '' goto nodisplayname
set DISPLAYNAMEPARAM=gameName=%1

:nodisplayname

set GAMENAMEPARAM=game=%GAMENAME%
set QBPARAM=qb=y
set MAPPARAM=map=y

echo Processing bmp files for %GAMENAME%
cd %GAMENAME%
FOR /D /r %%p IN (*) DO if exist "%%p"\*.bmp if exist "%%p"\*.bmp echo processing "%%p" & if exist "%%p"\*.bmp mogrify -format jpg -path "%%p" -resize x120^> "%%p"\*.bmp
FOR /D /r %%p IN (*) DO if exist "%%p"\*.jpg~ if exist "%%p"\*.jpg~ echo cleaning temp files for "%%p" & if exist "%%p"\*.jpg~ del "%%p"\*.jpg~
cd ..

echo Copying supporting files for Scenarios
xcopy /E /Y /Q %GAMENAME%\Scenarios\*.jpg html\%GAMENAME%\Scenarios
xcopy /E /Y /Q %GAMENAME%\Scenarios\*.png html\%GAMENAME%\Scenarios

echo Generating Scenario list html
echo saxon9t -s:%GAMENAME%\Scenarios\Scenario_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\Scenarios\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% extrainfopath=%GAMENAME%/Scenarios
call saxon9t -s:%GAMENAME%\Scenarios\Scenario_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\Scenarios\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% extrainfopath=%GAMENAME%/Scenarios

echo Copying supporting files for Campaigns
xcopy /E /Y /Q %GAMENAME%\Campaigns\*.jpg html\%GAMENAME%\Campaigns
xcopy /E /Y /Q %GAMENAME%\Campaigns\*.png html\%GAMENAME%\Campaigns

echo Generating Campaign list html
echo saxon9t -s:%GAMENAME%\Campaigns\Campaign_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\Campaigns\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% extrainfopath=%GAMENAME%/Campaigns
call saxon9t -s:%GAMENAME%\Campaigns\Campaign_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\Campaigns\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% extrainfopath=%GAMENAME%/Campaigns

echo Copying supporting files for Maps
xcopy /E /Y /Q %GAMENAME%\Maps\*.jpg html\%GAMENAME%\Maps
xcopy /E /Y /Q %GAMENAME%\Maps\*.png html\%GAMENAME%\Maps

echo Generating Map list html
echo saxon9t -s:%GAMENAME%\Maps\Scenario_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\Maps\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% %MAPPARAM% extrainfopath=%GAMENAME%/Maps
call saxon9t -s:%GAMENAME%\Maps\Scenario_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\Maps\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% %MAPPARAM% extrainfopath=%GAMENAME%/Maps

echo Copying supporting files for QBMaps
xcopy /E /Y /Q %GAMENAME%\QBMaps\*.jpg html\%GAMENAME%\QBMaps
xcopy /E /Y /Q %GAMENAME%\QBMaps\*.png html\%GAMENAME%\QBMaps

echo Generating QBMap list html
echo saxon9t -s:%GAMENAME%\QBMaps\Scenario_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\QBMaps\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% %QBPARAM% extrainfopath=%GAMENAME%/QBMaps
call saxon9t -s:%GAMENAME%\QBMaps\Scenario_Listing.xml -xsl:scenario_campaign_listing.xsl -o:html\%GAMENAME%\QBMaps\index.html %DISPLAYNAMEPARAM% %GAMENAMEPARAM% %QBPARAM% extrainfopath=%GAMENAME%/QBMaps

echo Creating theBlitz icons
if not exist theBlitzIcons\%GAMENAME%\ mkdir theBlitzIcons\%GAMENAME%\
if not exist theBlitzIcons\%GAMENAME%\Scenarios\ mkdir theBlitzIcons\%GAMENAME%\Scenarios
mogrify -path theBlitzIcons\%GAMENAME%\Scenarios -gravity center -background transparent -extent 356x230 -format png %GAMENAME%\Scenarios\scenpics\*.jpg

if not exist theBlitzIcons\%GAMENAME%\Campaigns\ mkdir theBlitzIcons\%GAMENAME%\Campaigns
mogrify -path theBlitzIcons\%GAMENAME%\Campaigns -gravity center -background transparent -extent 356x230 -format png %GAMENAME%\Campaigns\campaignpics\*.jpg

if not exist theBlitzIcons\%GAMENAME%\Maps\ mkdir theBlitzIcons\%GAMENAME%\Maps
mogrify -path theBlitzIcons\%GAMENAME%\Maps -gravity center -background transparent -extent 356x230 -format png %GAMENAME%\Maps\scenpics\*.jpg

if not exist theBlitzIcons\%GAMENAME%\QBMaps\ mkdir theBlitzIcons\%GAMENAME%\QBMaps
mogrify -path theBlitzIcons\%GAMENAME%\QBMaps -gravity center -background transparent -extent 356x230 -format png %GAMENAME%\QBMaps\scenpics\*.jpg

goto end

:usage
@echo updateonehtml gamename [displayname]
@echo Run Xalan transformation(s) to create the htmlfor the scenario, campaign, map and QBmap list for gamename passing in the parameter displayname to the transformation if it is there.
pause
goto end


:end
