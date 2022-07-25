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
insert overwrite table app_mall.app_goods_sales_item partition(dt='${dt}')  select 
goods_name,
first_category_name,
count(order_id) as order_total,
sum(goods_amount * order_curr_price) as price_total
from dws_mall.dws_order_goods_all_info
where dt = '${dt}'
group by goods_name,first_category_name;


insert overwrite table app_mall.app_category_top10 partition(dt='${dt}')  select 
first_category_name,
sum(order_total) as order_total
from app_mall.app_goods_sales_item 
where dt ='${dt}'
group by first_category_name
order by order_total desc
limit 10;

"
