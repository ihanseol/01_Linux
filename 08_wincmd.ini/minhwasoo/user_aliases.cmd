;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here

e.=explorer .
gl=git log --oneline --all --graph --decorate  $*
gs=git status $*
ga=git add $*
gc=git commit $*
gpush=git push origin master
gpull=git pull origin master

l=ls --show-control-chars -F --color $*
ls=ls --show-control-chars -F --color $*
ll=ls -l -F --show-control-chars --color $*

..=..\$*
...=..\..\$*
~=cd %USERPROFILE%
mydir=cd /d %ME%

pwd=cd
clear=cls
;history=cat "%CMDER_ROOT%\config\.history"
;unalias=alias /d $1

vi=gvim $*
cmderr=cd /d "%CMDER_ROOT%"
lp=cls $t dir
find=findstr /sin $*

eh=%VI% "C:\windows\system32\drivers\etc\hosts"
qal=%VI% "%CMDER_ROOT%\config\user_aliases.cmd" $t alias/reload
sett=%VI% "%CMDER_ROOT%\config\user_profile.cmd"

min=c: $t cd %ME%
ana=cd C:\ProgramData\Anaconda3\envs
sub=sublime_text $*

history=doskey /history
;= h [SHOW | SAVE | TSAVE ]
h=IF ".$*." == ".." (echo "usage: h [ SHOW | SAVE | TSAVE ]" && doskey/history) ELSE (IF /I "$1" == "SAVE" (doskey/history $g$g %USERPROFILE%\cmd\history.log & ECHO Command history saved) ELSE (IF /I "$1" == "TSAVE" (echo **** %date% %time% **** >> %USERPROFILE%\cmd\history.log & doskey/history $g$g %USERPROFILE%\cmd\history.log & ECHO Command history saved) ELSE (IF /I "$1" == "SHOW" (type %USERPROFILE%\cmd\history.log) ELSE (doskey/history))))
loghistory=doskey /history >> %USERPROFILE%\cmd\history.log

;=exit=echo **** %date% %time% **** >> %USERPROFILE%\cmd\history.log & doskey/history $g$g %USERPROFILE%\cmd\history.log & ECHO Command history saved, exiting & timeout 1 & exit $*
exit=echo **** %date% %time% **** >> %USERPROFILE%\cmd\history.log & doskey/history $g$g %USERPROFILE%\cmd\history.log & exit $*
