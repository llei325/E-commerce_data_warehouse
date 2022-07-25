#!/bin/bash
# 需求四：漏斗分析
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
insert overwrite table app_mall.app_user_conver_funnel partition(dt='${dt}')  select 
duah.active_num,
dgi.item_num,
duo.order_num,
duo.pay_num,
dgi.item_num/duah.active_num as active_to_item_ratio,
duo.order_num/dgi.item_num as item_to_order_ratio,
duo.pay_num/duo.order_num as order_to_pay_ratio
from
(
    select 
	count(*) as active_num
	from dws_mall.dws_user_active_history
	where dt = '${dt}'
) as duah
join
(
    select 
	count(distinct goods_id) as item_num
	from dwd_mall.dwd_good_item
    where dt = '${dt}'
)as dgi
on 1=1
join
(
    select
	count(*) as order_num,
	sum(case when order_status != 0 then 1 else 0 end) as pay_num
	from dwd_mall.dwd_user_order
	where dt = '${dt}'
) as duo
on 1=1;
"