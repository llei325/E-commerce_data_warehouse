#!/bin/bash
# 需求三：用户7日流失push提醒
# dws层数据库和表初始化脚本，只需要执行一次即可

hive -e "
create database if not exists dws_mall;

create external table if not exists dws_mall.dws_user_lost_item(
    xaid    string
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dws/user_lost_item';
"