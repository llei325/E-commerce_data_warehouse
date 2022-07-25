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


#alter table ods_mall.ods_user add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_user_extend add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_user_addr add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_goods_info add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_category_code add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_user_order add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_order_item add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_order_delivery add if not exists partition(dt='20260101') location '20260101';
#alter table ods_mall.ods_payment_flow add if not exists partition(dt='20260101') location '20260101';

sh add_partition.sh ods_mall.ods_user ${dt} ${dt}
sh add_partition.sh ods_mall.ods_user_extend ${dt} ${dt}
sh add_partition.sh ods_mall.ods_user_addr ${dt} ${dt}
sh add_partition.sh ods_mall.ods_goods_info ${dt} ${dt}
sh add_partition.sh ods_mall.ods_category_code ${dt} ${dt}
sh add_partition.sh ods_mall.ods_user_order ${dt} ${dt}
sh add_partition.sh ods_mall.ods_order_item ${dt} ${dt}
sh add_partition.sh ods_mall.ods_order_delivery ${dt} ${dt}
sh add_partition.sh ods_mall.ods_payment_flow ${dt} ${dt}

