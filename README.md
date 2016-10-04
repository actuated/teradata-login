# teradata-login
Quick and dirty Windows batch login scanner for Teradata databases.

# Usage
Modify the variables at the beginning of the batch file to set your input file, output file, target server, and password:
```
SET strINFILE=***SETME***
SET strOUTFILE=***SETME***
SET strSERVER=***SETME***
SET strPASS=***SETME***
```

This script requires [BTEQ, a Teradata-provided utility](https://downloads.teradata.com/download/tools/teradata-tools-and-utilities-windows-installation-package), to be installed.

The script will read each line of `strINFILE` as the current username, using `BTEQ` to in to `strSERVER` with that username, and the password set with `strPASS`.

If the login fails, the `ABORT` and `.QUIT` commands will end the `BTEQ` session for that user. If the login succeeds, the prompt will unfortunately be stuck waiting for input. Timestamps are provided to you can tell how long it has been since the login attempt for that user had started. You can enter `.QUIT` to end that successful `BTEQ` session and continue the attack.

Standard output from the login attempts will be written to `strOUTFILE`. 
* `*** Failure 8017 The UserId, Password or Account is invalid.` indicates failed logins.
* `*** Logon successfully completed.` indicates successful logins.

# Example Output
### Terminal Output with User3 Success
```
================[ teradata-login.bat - Ted R (github: actuated) ]================

FYI: OutTest.txt already exists. Continue to append, or Ctrl+C to exit.
Press any key to continue . . .

Started: Tue 10/04/2016  8:30:19.68

 8:30:19.68: User1:P@ssword
 8:30:19.68: User2:P@ssword
 8:30:19.68: User3:P@ssword
.QUIT
 8:30:23.45: User4:P@ssword

Done: Tue 10/04/2016  8:30:26.75

=====================================[ fin ]=====================================
```
### Output File
```

Started: Tue 10/04/2016  8:30:19.68 

 Teradata BTEQ x.x.x.x for WIN32. PID: 6104
 Copyright 1984-2016, Teradata Corporation. ALL RIGHTS RESERVED.
 Enter your logon or BTEQ command:

.LOGON 192.168.1.1/User1,
 *** Failure 8017 The UserId, Password or Account is invalid.
 
 *** Total elapsed time was 1 second.
 
 *** Exiting BTEQ...
 *** RC (return code) = 8 

 Teradata BTEQ x.x.x.x for WIN32. PID: 3184
 Copyright 1984-2016, Teradata Corporation. ALL RIGHTS RESERVED.
 Enter your logon or BTEQ command:

.LOGON 192.168.1.1/User2,
 *** Failure 8017 The UserId, Password or Account is invalid.
 
 *** Total elapsed time was 1 second.
 
 *** Exiting BTEQ...
 *** RC (return code) = 8 

 Teradata BTEQ x.x.x.x for WIN32. PID: 5520
 Copyright 1984-2016, Teradata Corporation. ALL RIGHTS RESERVED.
 Enter your logon or BTEQ command:

.LOGON 192.168.1.1/User3,

 *** Logon successfully completed.
 *** Teradata Database Release is x.x.x.x                   
 *** Teradata Database Version is x.x.x.x                     
 *** Transaction Semantics are BTET.
 *** Session Character Set Name is 'ASCII'.
 
 *** Total elapsed time was 1 second.
 
 BTEQ -- Enter your SQL request or BTEQ command: 

.QUIT
 *** You are now logged off from the DBC.
 *** Exiting BTEQ...
 *** RC (return code) = 0 

 Teradata BTEQ x.x.x.x for WIN32. PID: 1976
 Copyright 1984-2016, Teradata Corporation. ALL RIGHTS RESERVED.
 Enter your logon or BTEQ command:

.LOGON 192.168.1.1/User4,
 *** Failure 8017 The UserId, Password or Account is invalid.
 
 *** Total elapsed time was 1 second.
 
 *** Exiting BTEQ...
 *** RC (return code) = 8 
 
Done: Tue 10/04/2016  8:30:26.75 
```
