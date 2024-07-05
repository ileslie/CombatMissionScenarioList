@echo off

call cleanalllists.cmd
if errorlevel 1 exit /b 1

call cleanallhtml.cmd
if errorlevel 1 exit /b 1

call updatealllists.cmd
if errorlevel 1 exit /b 1

call generateallhtml.cmd
if errorlevel 1 exit /b 1

call ftpall.cmd
if errorlevel 1 exit /b 1

