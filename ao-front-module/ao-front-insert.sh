#!/bin/sh
#
# SQL File Insert
# auth <<CV.AO T-SHIOTSUKA>>
#

# DB CONFIG
DBNAME=db_cvao_demo
TABLENAME=ao_timeline
DBUSER=root
DBPASS=1qazxsw2

ROOTDIR=/opt/cv-data
WORKDIR=${ROOTDIR}/work
SQLFILE=${WORKDIR}/ao_timeline.sql
DIFFFILE=${WORKDIR}/f-dbdiff.list

# DB INSERT
echo "[INFO]DB INSERT Start.[TABLE:${TABLENAME}]"
mysql -u ${DBUSER} -p${DBPASS} ${DBNAME} < ${SQLFILE}
if [ $? -eq 0 ]
then
	echo "[INFO]DB INSERT End.[TABLE:${TABLENAME}]"
else
	echo "[ERROR]DB INSERT End.[TABLE:${TABLENAME}]"
	exit 9
fi

# リスト初期化
cat /dev/null > ${SQLFILE}

# 取込完了ファイル作成
filename=${DIFFFILE}
cat ${filename} | while read line
do
	echo "[INFO]PUT END File Start.[${line}.end]"
	touch ${ROOTDIR}/dbEND/${line}.end
	echo "[INFO]PUT END File End.[${line}.end]"
done
