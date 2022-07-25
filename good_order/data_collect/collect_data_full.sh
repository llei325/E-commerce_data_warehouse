#!/bin/bash
# 全量数据采集
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi


# SQL语句
user_sql="select user_id,user_name,user_gender,user_birthday,e_mail,concat(left(mobile,3), '****' ,right(mobile,4)) as mobile,register_time,is_blacklist from user where 1=1"
user_extend_sql="select user_id,is_pregnant_woman,is_have_children,is_have_car,phone_brand,phone_cnt,change_phone_cnt,weight,height from user_extend where 1=1"
user_addr_sql="select addr_id,user_id,addr_name,order_flag,user_name,concat(left(mobile,3), '****' ,right(mobile,4)) as mobile from user_addr where 1=1"
goods_info_sql="select goods_id,goods_no,goods_name,curr_price,third_category_id,goods_desc,create_time from goods_info where 1=1"
category_code_sql="select first_category_id,first_category_name,second_category_id,second_catery_name,third_category_id,third_category_name from category_code where 1=1"

# 路径后缀
path_prefix="hdfs://bigdata01:9000/data/ods"

# 输出路径
user_path="${path_prefix}/user/${dt}"
user_extend_path="${path_prefix}/user_extend/${dt}"
user_addr_path="${path_prefix}/user_addr/${dt}"
goods_info_path="${path_prefix}/goods_info/${dt}"
category_code_path="${path_prefix}/category_code/${dt}"

# 采集数据
echo "开始采集..."
echo "采集表：user"
sh sqoop_collect_data_util.sh "${user_sql}" "${user_path}"
echo "采集表：user_extend"
sh sqoop_collect_data_util.sh "${user_extend_sql}" "${user_extend_path}"
echo "采集表：user_addr"
sh sqoop_collect_data_util.sh "${user_addr_sql}" "${user_addr_path}"
echo "采集表：goods_info"
sh sqoop_collect_data_util.sh "${goods_info_sql}" "${goods_info_path}"
echo "采集表：category_code"
sh sqoop_collect_data_util.sh "${category_code_sql}" "${category_code_path}"
echo "结束采集..."











