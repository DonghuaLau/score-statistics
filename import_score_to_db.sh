#! /bin/sh

#data file line format
# name,class,sex,student number,score
if [ $# != 2 ]; then
	echo "Usage: $0 <data file> <db table>"
	exit
fi

datafile=$1
dbtable=$2

mysqlcmd="mysql -uroot -ptango9896 scores"

while read line; do
	data=($(echo $line | tr "," "\n"))
	#echo "--: ${data[0]}"
	sql="insert into ${dbtable} (no, name, sex, class, score) values ('${data[3]}', '${data[0]}', '${data[2]}', '${data[1]}', '${data[4]}')"
	echo ${sql} | ${mysqlcmd}
	#echo ${sql}
	#break
done < ${datafile}
