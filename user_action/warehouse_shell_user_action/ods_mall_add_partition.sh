#!/bin/bash
# 给ods层的表添加分区，这个脚本后期每天执行一次
# 每天凌晨，添加昨天的分区，添加完分区之后，再执行后面的计算脚本

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

#alter table ods_mall.ods_user_active add  if not exists partition(dt='20260101') location '20260101/1';
#alter table ods_mall.ods_click_good add  if not exists partition(dt='20260101') location '20260101/2';
#alter table ods_mall.ods_good_item add  if not exists partition(dt='20260101') location '20260101/3';
#alter table ods_mall.ods_good_list add  if not exists partition(dt='20260101') location '20260101/4';
#alter table ods_mall.ods_app_close add  if not exists partition(dt='20260101') location '20260101/5';
sh add_partition.sh ods_mall.ods_user_active ${dt} ${dt}/1
sh add_partition.sh ods_mall.ods_click_good ${dt} ${dt}/2
sh add_partition.sh ods_mall.ods_good_item ${dt} ${dt}/3
sh add_partition.sh ods_mall.ods_good_list ${dt} ${dt}/4
sh add_partition.sh ods_mall.ods_app_close ${dt} ${dt}/5