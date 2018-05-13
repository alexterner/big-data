SET hive.mapred.supports.subdirectories=TRUE;
SET mapred.input.dir.recursive=TRUE;
set hive.execution.engine=spark;


CREATE EXTERNAL TABLE IF NOT EXISTS examples(
id INT,
sentence STRING,
author STRING,
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/dev/examples/comma';

Select * from examples limit 5;

Select * from examples where id = 65568;
