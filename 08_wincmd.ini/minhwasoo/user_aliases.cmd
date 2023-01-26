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
lp=cls $t dir
find=findstr /sin $*


..=..\$*
...=..\..\$*
~=cd /d %USERPROFILE%
mydir=cd /d %_ME_%

pwd=cd
clear=cls
;= history=cat "%_TCOMMANDER_%\config\.history"
;= unalias=alias /d $1

vi=gvim $*
sub=sublime_text $*


;= qho : quick hosts file
;= qal : quick alias command
;= qpr : quick profile command

qho=%_EDITOR_% "C:\windows\system32\drivers\etc\hosts"
qal=%_EDITOR_% "%_TCOMMANDER_%\user_aliases.cmd" 
qpr=%_EDITOR_% "%_TCOMMANDER_%\user_profile.cmd"

cmder_config=cd /d "%_TCOMMANDER_%""

ana=cd  /d C:\ProgramData\Anaconda3\envs


history=doskey /history
;= h [SHOW | SAVE | TSAVE ]
h=IF ".$*." == ".." (echo "usage: h [ SHOW | SAVE | TSAVE ]" && doskey/history) ELSE (IF /I "$1" == "SAVE" (doskey/history $g$g %USERPROFILE%\cmd\history.log & ECHO Command history saved) ELSE (IF /I "$1" == "TSAVE" (echo **** %date% %time% **** >> %USERPROFILE%\cmd\history.log & doskey/history $g$g %USERPROFILE%\cmd\history.log & ECHO Command history saved) ELSE (IF /I "$1" == "SHOW" (type %USERPROFILE%\cmd\history.log) ELSE (doskey/history))))
loghistory=doskey /history >> %USERPROFILE%\cmd\history.log

;= exit=echo **** %date% %time% **** >> %USERPROFILE%\cmd\history.log & doskey/history $g$g %USERPROFILE%\cmd\history.log & ECHO Command history saved, exiting & timeout 1 & exit $*
exit=echo **** %date% %time% **** >> %USERPROFILE%\cmd\history.log & doskey/history $g$g %USERPROFILE%\cmd\history.log & exit $*
