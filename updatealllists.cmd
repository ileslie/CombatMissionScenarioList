@echo off

call cleanalllists.cmd
if errorlevel 1 exit /b 1

call updateonelist.cmd BattleForNormandy
if errorlevel 1 exit /b 1

call updateonelist.cmd BlackSea
if errorlevel 1 exit /b 1

call updateonelist.cmd ColdWar
if errorlevel 1 exit /b 1

call updateonelist.cmd FinalBlitzkrieg
if errorlevel 1 exit /b 1

call updateonelist.cmd FortressItaly
if errorlevel 1 exit /b 1

call updateonelist.cmd RedThunder
if errorlevel 1 exit /b 1

call updateonelist.cmd ShockForce
if errorlevel 1 exit /b 1
