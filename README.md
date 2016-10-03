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
