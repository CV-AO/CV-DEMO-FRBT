#!/bin/sh
#
# Module package
# auth <<CV.AO T-SHIOTSUKA>>
#

# 開始宣言
echo "[START][ao-front-modulepack]`date`"

MODULEDIR=/opt/cv/ao-front-module

# dropboxファイル一覧取得（.out .end）、差分未処理ファイル作成
echo "--- ao-front-filelist.sh ---"
${MODULEDIR}/ao-front-filelist.sh

# 空ファイルチェック
filename=/opt/cv-data/work/f-dbdiff.list
NUM=`wc -l ${filename} | awk '{print $1}'`
if [ ${NUM} = 0 ]; then
 # 終了宣言
 echo "[END][ao-front-modulepack]`date`"
 exit 0
fi

# 取込みSQLファイル作成処理
echo "--- ao-front-sql.py ---"
python ${MODULEDIR}/ao-front-sql.py

# SQLファイル取込み、処理済み完了トリガファイル作成
echo "--- ao-front-insert.sh ---"
${MODULEDIR}/ao-front-insert.sh
sleep 3

# 終了宣言
echo "[END][ao-front-modulepack]`date`"
