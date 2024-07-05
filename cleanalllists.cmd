@echo off

call cleanonelist.cmd BattleForNormandy
if errorlevel 1 exit /b 1

call cleanonelist.cmd BlackSea
if errorlevel 1 exit /b 1

call cleanonelist.cmd ColdWar
if errorlevel 1 exit /b 1

call cleanonelist.cmd FinalBlitzkrieg
if errorlevel 1 exit /b 1

call cleanonelist.cmd FortressItaly
if errorlevel 1 exit /b 1

call cleanonelist.cmd RedThunder
if errorlevel 1 exit /b 1

call cleanonelist.cmd ShockForce
if errorlevel 1 exit /b 1
