@echo off
echo Connecting to Database...
echo +++++++++++++++++++++++++
(
echo user/pass@instance
echo select 'Version ID:   ' ^^^|^^^| a1.BACKUP_VERSION  ^^^|^^^| CHR^^^(13^^^) ^^^|^^^| CHR^^^(10^^^)^^^|^^^|'Status:  ' ^^^|^^^| a1.STORAGE_STATUS ^^^|^^^|  CHR^^^(13^^^) ^^^|^^^| CHR^^^(10^^^)^^^|^^^| 'Distribution ID:  ' ^^^|^^^| a1.DISTRIBUTION_ID FROM epc1_distrib_version a1;
) 
echo +++++++++++++++++++++++++