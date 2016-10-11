#! /bin/sh

#data file line format
# name,class,sex,student number,score
if [ $# != 1 ]; then
	echo "Usage: $0 <db table>"
	exit
fi

dbtable=$2
mysql_cmd="mysql -uroot -ptango9896 scores"
csv_cmd="awk '{printf(\"%s,%s,%s,%s\\n\", $1,$2,$3,$4);}'"

total_score=120
pass_score=$(echo "${total_score} * 0.6" | bc -l)
excellent_score=$(echo "${total_score} * 0.9" | bc -l)

# average
sub1='select class,sum(score) as sum, count(score) as count, round(sum(score)/count(score),2) as average from math_201610 group by class'

# pass
sub2="select class, count(score) as count from math_201610 where score > ${pass_score} group by class"

# excellent
sub3="select class, count(score) as count from math_201610 where score > ${excellent_score} group by class"

# final
sub4="select t1.class as class, t1.average as average, t2.count as pass_count from (${sub1}) as t1 inner join (${sub2}) as t2 on t1.class = t2.class"
sql="select t4.class as class, t4.average as average, t4.pass_count as pass_count, t3.count as excellent_count from (${sub3}) as t3 inner join (${sub4}) as t4 on t3.class = t4.class"

#echo ${sql}
echo ${sql} | ${mysql_cmd} | 
	awk '{printf("%s,%s,%s,%s\n", $1,$2,$3,$4);}'
