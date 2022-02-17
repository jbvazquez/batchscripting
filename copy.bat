@ECHO OFF
pushd %~dp0


REM Get timestamp
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set datestamp=%dt:~0,8%
set timestamp=%dt:~8,6%
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set HH=%dt:~8,2%
set Min=%dt:~10,2%
set Sec=%dt:~12,2%

SET STAMP=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%

ECHO Logfile created >> %STAMP%.log 2>&1

REM Kill Explorer
REM taskkill /f /im explorer.exe >> %STAMP%.log 2>&1 | type %STAMP%.log

REM Logging

REM Create backup folder
MKDIR "backup_%STAMP%" >> %STAMP%.log 2>&1

ECHO Backup folder created >> %STAMP%.log 2>&1

REM Copy files

SET "SOURCE=%USERPROFILE%\Desktop"
SET "DESTINATION=%~d0\backup_%STAMP%"


REM Copy with robocopy

REM Copy options
REM s  - Copies subdirectories. This option automatically excludes empty directories.
REM e  - Copies subdirectories. This option automatically includes empty directories.
REM File selection options
REM is - Includes the same files.
REM Logging
REM v  - Produces verbose output, and shows all skipped files.
REM ts - Includes source file time stamps in the output.
REM fp - Includes the full path names of the files in the output.
ROBOCOPY %SOURCE% %DESTINATION% /s /e /is /v /ts /fp >> %STAMP%.log 2>&1 | type %STAMP%.log


REM Copy with xcopy

REM f - Display files as well as directories. If you use this option, the name of each file is displayed beneath the name of the directory in which it resides.
REM s - Copies directories and subdirectories, unless they are empty. If you omit /s, xcopy works within a single directory.
REM e - Copies all subdirectories, even if they are empty. Use /e with the /s and /t command-line options.
REM y - Suppresses prompting to confirm that you want to overwrite an existing destination file.

REM xcopy %SOURCE% %DESTINATION% /f /s /e /y

REM List Files

TREE /a /f %~dp0 >> %STAMP%.log 2>&1 | type %STAMP%.log

PAUSE