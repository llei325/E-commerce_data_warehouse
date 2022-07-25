#!/bin/bash
# 增量数据采集
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

# 转换日期格式，20260101 改为 2026-01-01
dt_new=`date +%Y-%m-%d --date="${dt}"`


# SQL语句
user_order_sql="select order_id,order_date,user_id,order_money,order_type,order_status,pay_id,update_time from user_order where order_date >= '${dt_new} 00:00:00' and order_date <= '${dt_new} 23:59:59'"


# 路径后缀
path_prefix="hdfs://bigdata01:9000/data/ods"

# 输出路径
user_order_path="${path_prefix}/user_order/${dt}"


# 采集数据
echo "开始采集..."
echo "采集表：user_order"
sh /data/soft/warehouse_job/sqoop_collect_data_util.sh "${user_order_sql}" "${user_order_path}"
echo "结束采集..."



