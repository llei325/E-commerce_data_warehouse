#!/bin/bash
# 需求一：每日新增用户相关指标
# dws层数据库和表初始化脚本，只需要执行一次即可


# 由于这个表需要每天创建一个，用完之后删除，所以选择把这个建表语句放到添加分区数据的脚本中
#create table if not exists dws_mall.dws_user_active_20260201_tmp(
#    xaid    string,
#	times   int
#);

hive -e "
create database if not exists dws_mall;

create external table if not exists dws_mall.dws_user_active_history(
    xaid    string,
	times   int
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dws/user_active_history';
 
 
create external table if not exists dws_mall.dws_user_new_item(
    xaid    string
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dws/user_new_item';
"