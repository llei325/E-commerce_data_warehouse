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
insert overwrite table dwd_mall.dwd_user_active partition(dt='${dt}')  select
get_json_object(log,'$.uid') as user_id,
get_json_object(log,'$.xaid') as xaid,
get_json_object(log,'$.platform') as platform,
get_json_object(log,'$.ver') as ver,
get_json_object(log,'$.vercode') as vercode,
get_json_object(log,'$.net') as net,
get_json_object(log,'$.brand') as brand,
get_json_object(log,'$.model') as model,
get_json_object(log,'$.display') as display,
get_json_object(log,'$.osver') as osver,
get_json_object(log,'$.acttime') as acttime,
get_json_object(log,'$.ad_status') as ad_status,
get_json_object(log,'$.loading_time') as loading_time
from 
(
select log from ods_mall.ods_user_active where dt = '${dt}' group by log
) as tmp
where get_json_object(log,'$.xaid') !='';



insert overwrite table dwd_mall.dwd_click_good partition(dt='${dt}')  select 
get_json_object(log,'$.uid') as user_id,
get_json_object(log,'$.xaid') as xaid,
get_json_object(log,'$.platform') as platform,
get_json_object(log,'$.ver') as ver,
get_json_object(log,'$.vercode') as vercode,
get_json_object(log,'$.net') as net,
get_json_object(log,'$.brand') as brand,
get_json_object(log,'$.model') as model,
get_json_object(log,'$.display') as display,
get_json_object(log,'$.osver') as osver,
get_json_object(log,'$.acttime') as acttime,
get_json_object(log,'$.goods_id') as goods_id,
get_json_object(log,'$.location') as location
from
(
select log from ods_mall.ods_click_good where dt = '${dt}' group by log
) as tmp
where get_json_object(log,'$.xaid') !='';


insert overwrite table dwd_mall.dwd_good_item partition(dt='${dt}') select 
get_json_object(log,'$.uid') as user_id,
get_json_object(log,'$.xaid') as xaid,
get_json_object(log,'$.platform') as platform,
get_json_object(log,'$.ver') as ver,
get_json_object(log,'$.vercode') as vercode,
get_json_object(log,'$.net') as net,
get_json_object(log,'$.brand') as brand,
get_json_object(log,'$.model') as model,
get_json_object(log,'$.display') as display,
get_json_object(log,'$.osver') as osver,
get_json_object(log,'$.acttime') as acttime,
get_json_object(log,'$.goods_id') as goods_id,
get_json_object(log,'$.stay_time') as stay_time,
get_json_object(log,'$.loading_time') as loading_time
from
(
select log from ods_mall.ods_good_item where dt = '${dt}' group by log
) as tmp
where get_json_object(log,'$.xaid') !='';



insert overwrite table dwd_mall.dwd_good_list partition(dt='${dt}') select 
get_json_object(log,'$.uid') as user_id,
get_json_object(log,'$.xaid') as xaid,
get_json_object(log,'$.platform') as platform,
get_json_object(log,'$.ver') as ver,
get_json_object(log,'$.vercode') as vercode,
get_json_object(log,'$.net') as net,
get_json_object(log,'$.brand') as brand,
get_json_object(log,'$.model') as model,
get_json_object(log,'$.display') as display,
get_json_object(log,'$.osver') as osver,
get_json_object(log,'$.acttime') as acttime,
get_json_object(log,'$.loading_time') as loading_time,
get_json_object(log,'$.loading_type') as loading_type,
get_json_object(log,'$.goods_num') as goods_num
from
(
select log from ods_mall.ods_good_list where dt = '${dt}' group by log
) as tmp
where get_json_object(log,'$.xaid') !='';


insert overwrite table dwd_mall.dwd_app_close partition(dt='${dt}') select 
get_json_object(log,'$.uid') as user_id,
get_json_object(log,'$.xaid') as xaid,
get_json_object(log,'$.platform') as platform,
get_json_object(log,'$.ver') as ver,
get_json_object(log,'$.vercode') as vercode,
get_json_object(log,'$.net') as net,
get_json_object(log,'$.brand') as brand,
get_json_object(log,'$.model') as model,
get_json_object(log,'$.display') as display,
get_json_object(log,'$.osver') as osver,
get_json_object(log,'$.acttime') as acttime
from
(
select log from ods_mall.ods_app_close where dt = '${dt}' group by log
) as tmp
where get_json_object(log,'$.xaid') !='';
"