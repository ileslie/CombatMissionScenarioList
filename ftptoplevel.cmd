@echo off

if "%FTP_USER%" == "" echo FTP_USER must be set & pause & goto end
if "%FTP_CREDENTIALS%" == "" echo FTP_CREDENTIALS must be set & pause & goto end

echo Uploading html for root directory
echo open sftp://%FTP_USER%:%FTP_CREDENTIALS%@ftp.lesliesoftware.com/> ftpcmd.dat

echo option batch continue>> ftpcmd.dat
echo option confirm off>> ftpcmd.dat

echo cd "/home/ileslie/combatmission.lesliesoftware.com">> ftpcmd.dat
echo lcd "html">> ftpcmd.dat

rem Create and copy the root site files
echo put *.html>> ftpcmd.dat
echo put *.ico>> ftpcmd.dat
echo put *.gif>> ftpcmd.dat

rem Create and copy the javascript files
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/javascript">> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/javascript">> ftpcmd.dat
echo lcd javascript>> ftpcmd.dat
echo put *.js>> ftpcmd.dat

rem Create and copy the css files
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/css">> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/css">> ftpcmd.dat
echo lcd ../css>> ftpcmd.dat
echo put *.css>> ftpcmd.dat

rem Create and copy the image files
echo mkdir "/home/ileslie/combatmission.lesliesoftware.com/images">> ftpcmd.dat
echo cd "/home/ileslie/combatmission.lesliesoftware.com/images">> ftpcmd.dat
echo lcd ../images>> ftpcmd.dat
echo put *.jpg>> ftpcmd.dat
echo put *.gif>> ftpcmd.dat
echo put *.png>> ftpcmd.dat

echo bye>> ftpcmd.dat

"c:\Program Files (x86)\WinSCP\WinSCP.com" /ini=nul /log=sftp.log /script=ftpcmd.dat
del ftpcmd.dat

:end