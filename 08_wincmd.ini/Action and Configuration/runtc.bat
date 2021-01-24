:: http://woshub.com/run-program-without-admin-password-and-bypass-uac-prompt/
::

Set ApplicationPath="C:\Program Files\totalcmd\TOTALCMD64.EXE"
cmd /min /C "set __COMPAT_LAYER=RUNASINVOKER && start "" %ApplicationPath%"


