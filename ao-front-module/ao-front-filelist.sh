#!/bin/sh
#
# Dropbox Filelist
# auth <<CV.AO T-SHIOTSUKA>>
#

ROOTDIR=/opt/cv-data
TEXTDIR=${ROOTDIR}/dbTEXT
ENDDIR=${ROOTDIR}/dbEND
WORKDIR=${ROOTDIR}/work

FILE1=${WORKDIR}/f-dbtext.list
FILE2=${WORKDIR}/f-dbend.list
FILE3=${WORKDIR}/f-dbdiff.list

# ファイルリスト作成
echo "[INFO]Dropbox Filelist(dbTEXT) Start.[${FILE1}]"
ls ${TEXTDIR} | grep out | sed -e "s/\.out//" > ${FILE1}
echo "[INFO]Dropbox Filelist(dbTEXT) End.[${FILE1}]"

echo "[INFO]Dropbox Filelist(dbEND) Start.[${FILE2}]"
ls ${ENDDIR} | grep end | sed -e "s/\.end//" > ${FILE2}
echo "[INFO]Dropbox Filelist(dbEND) End.[${FILE2}]"

# リスト初期化
cat /dev/null > ${FILE3}

# 差分ファイル作成
echo "[INFO]Dropbox Filelist(dbDIFF) Start.[${FILE3}]"
diff ${FILE1} ${FILE2} | awk 'NR!=1' | awk '{print $2}' > ${FILE3}
echo "[INFO]Dropbox Filelist(dbDIFF) End.[${FILE3}]"
