#! /bin/sh

mysqlcmd="mysql -uroot -ptango9896 scores"

function math_table()
{
	table="math_$1"
	sql="create table ${table} ( 
		 id int NOT NULL AUTO_INCREMENT
		,no varchar(32)
		,name varchar(64)
		,sex char(8)
		,class char(16)
		,score double NOT NULL DEFAULT 0
		,UNIQUE KEY id (id)
	) ENGINE=InnoDB CHARSET=utf8mb4;"
	echo ${sql} | ${mysqlcmd}
}

math_table "201610"
#math_table 

