#!/bin/bash
# 需求六：APP崩溃相关指标
# app层数据库和表初始化脚本，只需要执行一次即可

hive -e "
create database if not exists app_mall;

create external table if not exists app_mall.app_app_close_platform_all(
    ty    string,
	num    int
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/app/app_close_platform_all';


create external table if not exists app_mall.app_app_close_android_vercode(
    ty    string,
	num    int
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/app/app_close_android_vercode';


create external table if not exists app_mall.app_app_close_ios_vercode(
    ty    string,
	num    int
)partitioned by(dt string)
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/app/app_close_ios_vercode';
"