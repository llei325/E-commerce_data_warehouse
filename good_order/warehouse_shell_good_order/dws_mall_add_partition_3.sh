#!/bin/bash
# 需求三：商品相关指标
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
insert overwrite table dws_mall.dws_order_goods_all_info partition(dt='${dt}')  select 
   doi.order_id,
   doi.goods_id,
   doi.goods_amount,
   doi.curr_price as order_curr_price,
   doi.create_time as order_create_time,
   dgi.goods_no,
   dgi.goods_name,
   dgi.curr_price as goods_curr_price,
   dgi.goods_desc,
   dgi.create_time as goods_create_time,
   dcc.first_category_id,
   dcc.first_category_name,
   dcc.second_category_id,
   dcc.second_catery_name,
   dcc.third_category_id,
   dcc.third_category_name
from dwd_mall.dwd_order_item as doi
left join dwd_mall.dwd_goods_info as dgi
on doi.goods_id = dgi.goods_id
left join dwd_mall.dwd_category_code as dcc
on dgi.third_category_id = dcc.third_category_id
where doi.dt = '${dt}' and dgi.dt = '${dt}' and dcc.dt = '${dt}';
"