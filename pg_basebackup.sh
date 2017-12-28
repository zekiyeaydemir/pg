#!/bin/bash

DB_USER="replication"
DB_HOST="10.0.0.163"
BACKUP_DIRECTORY="/var/lib/postgresql/9.6/backup/basebackup"
LOG_DIR="/var/lib/postgresql/9.6/backup/basebackup"
PG_BIN_DIR="/usr/lib/postgresql/9.6/bin"
OPTIONS="--xlog-method=stream --progress --write-recovery-conf --checkpoint=fast --verbose"
DATE_PREFIX=$(date +"%Y%m%d")
LOG_FILE=$LOG_DIR/$DATE_PREFIX-pg_basebackup.log
START_LOG="$(date) - pg_basebackup STARTING"

logger -s $START_LOG >> $LOG_FILE 2>&1

$PG_BIN_DIR/pg_basebackup --username=$DB_USER --host=$DB_HOST  $OPTIONS --pgdata="$BACKUP_DIRECTORY/pg_basebackup-$DATE_PREFIX" >> $LOG_FILE 2>&1
STATUS=$?
END_LOG="$(date) - pg_basebackup ENDED"
logger -s $END_LOG >> $LOG_FILE 2>&1
if [ $STATUS -eq 0 ]; then
		echo " Command executed successfully" >>  $LOG_FILE
	else
	       echo " Command terminated unsuccessfully " >> $LOG_FILE
fi
	
