
rem This  just copies b3d.dll to your system32 directory...!

echo off
copy redist\b3d.dll %windir%\system32
if exist %windir%\system32\b3d.dll (echo b3d.dll successfully copied to your system32 directory.) else (echo *****ERROR***** Failed to copy b3d.dll to your system32 directory.)
pause
echo on
