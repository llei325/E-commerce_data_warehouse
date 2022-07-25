#!/bin/bash
# 需求三：商品相关指标
# dws层数据库和表初始化脚本，只需要执行一次即可

hive -e "
create database if not exists dws_mall;

create external table if not exists dws_mall.dws_order_goods_all_info(
   order_id             bigint,
   goods_id             bigint,
   goods_amount         int,
   order_curr_price           double,
   order_create_time          string,
   goods_no             string,
   goods_name           string,
   goods_curr_price           double,
   goods_desc           string,
   goods_create_time          string,
   first_category_id    int,
   first_category_name  string,
   second_category_id   int,
   second_catery_name   string,
   third_category_id    int,
   third_category_name  string
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dws/order_goods_all_info/';
"