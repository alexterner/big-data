
// if hive driver has error then enter : export HADOOP_USER_CLASSPATH_FIRST=true


// Beeline driver

Beeline  : http://www.bmc.com/blogs/apache-hive-beeline-client-import-csv-file-into-hive/
 

// if  beeline failing on connect then run  hiveserver2 &

beeline -u jdbc:hive2://localhost:10000


SET hive.mapred.supports.subdirectories=TRUE;
SET mapred.input.dir.recursive=TRUE;
set hive.execution.engine=spark;

CREATE DATABASE db;
USE db ; 


CREATE EXTERNAL TABLE IF NOT EXISTS tbl(
id INT,
sentence STRING,
author STRIåNG,
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.MultiDelimitSerDe' 
WITH SERDEPROPERTIES ("field.delim"="@@")
STORED AS TEXTFILE
LOCATION 'hdfs://localhost/dev/examples';

Select * from tbl where id = 65568;

Select * from tbl limit 1;
