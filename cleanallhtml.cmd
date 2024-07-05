@echo off

call cleanonehtml.cmd BattleForNormandy
if errorlevel 1 exit /b 1

call cleanonehtml.cmd BlackSea
if errorlevel 1 exit /b 1

call cleanonehtml.cmd ColdWar
if errorlevel 1 exit /b 1

call cleanonehtml.cmd FinalBlitzkrieg
if errorlevel 1 exit /b 1

call cleanonehtml.cmd FortressItaly
if errorlevel 1 exit /b 1

call cleanonehtml.cmd RedThunder
if errorlevel 1 exit /b 1

call cleanonehtml.cmd ShockForce
if errorlevel 1 exit /b 1
