#!/bin/bash
# 需求六：APP崩溃相关指标
# dws层数据库和表初始化脚本，只需要执行一次即可

hive -e "
create database if not exists dws_mall;

create external table if not exists dws_mall.dws_app_close_platform_vercode(
    platform    string,
	vercode    string,
	num    int
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dws/app_close_platform_vercode';
"