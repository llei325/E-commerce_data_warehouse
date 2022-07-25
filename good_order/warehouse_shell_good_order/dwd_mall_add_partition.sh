#!/bin/bash
# 基于ods层的表进行清洗，将清洗之后的数据添加到dwd层对应表的对应分区中
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
 
insert overwrite table dwd_mall.dwd_user partition(dt='${dt}')  select 
   user_id,
   user_name,
   user_gender,
   user_birthday,
   e_mail,
   mobile,
   register_time,
   is_blacklist
from ods_mall.ods_user
where dt = '${dt}' and user_id is not null;
 
 
insert overwrite table dwd_mall.dwd_user_extend partition(dt='${dt}')  select 
   user_id,
   is_pregnant_woman,
   is_have_children,
   is_have_car,
   phone_brand,
   phone_cnt,
   change_phone_cnt,
   weight,
   height
from ods_mall.ods_user_extend
where dt = '${dt}' and user_id is not null;

 
insert overwrite table dwd_mall.dwd_user_addr partition(dt='${dt}')  select 
   addr_id,
   user_id,
   addr_name,
   order_flag,
   user_name,
   mobile
from ods_mall.ods_user_addr
where dt = '${dt}' and addr_id is not null;
 

 
insert overwrite table dwd_mall.dwd_goods_info partition(dt='${dt}')  select 
   goods_id,
   goods_no,
   goods_name,
   curr_price,
   third_category_id,
   goods_desc,
   create_time
from ods_mall.ods_goods_info
where dt = '${dt}' and goods_id is not null;
 

insert overwrite table dwd_mall.dwd_category_code partition(dt='${dt}')  select 
   first_category_id,
   first_category_name,
   second_category_id,
   second_catery_name,
   third_category_id,
   third_category_name
from ods_mall.ods_category_code
where dt = '${dt}' and first_category_id is not null;

 
insert overwrite table dwd_mall.dwd_user_order partition(dt='${dt}')  select 
   order_id,
   order_date,
   user_id,
   order_money,
   order_type,
   order_status,
   pay_id,
   update_time 
from ods_mall.ods_user_order
where dt = '${dt}' and order_id is not null;
 

insert overwrite table dwd_mall.dwd_order_item partition(dt='${dt}')  select 
   order_id,
   goods_id,
   goods_amount,
   curr_price,
   create_time
from ods_mall.ods_order_item
where dt = '${dt}' and order_id is not null;


insert overwrite table dwd_mall.dwd_order_delivery partition(dt='${dt}')  select 
   order_id,
   addr_id,
   user_id,
   carriage_money,
   create_time
from ods_mall.ods_order_delivery
where dt = '${dt}' and order_id is not null;


insert overwrite table dwd_mall.dwd_payment_flow partition(dt='${dt}')  select 
   pay_id,
   order_id,
   trade_no,
   pay_money,
   pay_type,
   pay_time
from ods_mall.ods_payment_flow
where dt = '${dt}' and order_id is not null;
"