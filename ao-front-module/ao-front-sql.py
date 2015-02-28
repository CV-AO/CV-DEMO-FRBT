# coding: UTF-8
import glob
import os

datadir = '/opt/cv-data/dbTEXT/'
inputfile = '/opt/cv-data/work/f-dbdiff.list'
outputfile = '/opt/cv-data/work/ao_timeline.sql'

print "[INFO]PUT SQL File Start.[" + outputfile + "]"
sql = open(outputfile, 'w')
sql.write("") # 初期化
f = open(inputfile, 'r')
for line in f:
	# 音声ファイルのメタ情報取得
	line = line.strip("\n")
	metainfo = line.split("_")
        dict = {metainfo[0]:metainfo[1],
                metainfo[2]:metainfo[3],
                metainfo[4]:metainfo[5],
                metainfo[6]:metainfo[7],
                "FILE1":line + ".out",
		"FILE2":line + ".m4a"}
		# FILE1:結果ファイル名 FILE2:元ファイル名
	# 音声解析結果取得
        result = open(datadir + dict['FILE1'],'r')
        fulltext = result.readline()
        sentence = fulltext.strip("sentence1: ")
        dict['TEXT'] = sentence.strip("\n")
        result.close()
        # 標準出力(デバッグ用)
        # print dict
	# print dict['TEXT'].decode("utf-8")

	# インポート用CSV書き出し
	sql.write("INSERT INTO ao_timeline VALUES ('" + 
		  dict['ID'] + "','" +
		  dict['LATITUDE'] + "','" + 
		  dict['LONGTUDE'] + "','" + 
		  dict['TIME'] + "','" +
		  dict['TEXT'] + "','" +
		  dict['FILE2'] + "','0','0',now(),now());\r\n")
f.close()
sql.close() 
print "[INFO]PUT SQL File END.[" + outputfile + "]"
