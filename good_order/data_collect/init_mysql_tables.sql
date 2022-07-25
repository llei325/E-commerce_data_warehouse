create database if not exists mall;

use mall;

drop table if exists user;
create table user
(
   user_id              bigint not null,
   user_name            varchar(64) not null,
   user_gender          tinyint not null,
   user_birthday        datetime not null,
   e_mail               varchar(256) not null,
   mobile               bigint not null,
   register_time        datetime not null,
   is_blacklist         tinyint not null,
   primary key (user_id)
);


drop table if exists user_extend;
create table user_extend
(
   user_id              bigint not null ,
   is_pregnant_woman    tinyint not null,
   is_have_children     tinyint not null,
   is_have_car          tinyint not null,
   phone_brand          varchar(64) not null,
   phone_cnt            int not null,
   change_phone_cnt     int not null,
   weight               int not null,
   height               int not null,
   primary key (user_id)
);




drop table if exists user_order;
create table user_order
(
   order_id             bigint not null,
   order_date           datetime not null,
   user_id              bigint not null,
   order_money          decimal(18,2) not null,
   order_type           int not null,
   order_status         int not null,
   pay_id               bigint not null,
   update_time          datetime not null,
   primary key (order_id)
);





drop table if exists payment_flow;
create table payment_flow
(
   pay_id               bigint not null,
   order_id             bigint not null,
   trade_no             bigint not null,
   pay_money            decimal(18,2) not null,
   pay_type             int not null,
   pay_time             datetime not null,
   primary key (pay_id)
);




drop table if exists category_code;
create table category_code
(
   first_category_id    int not null,
   first_category_name  varchar(32) not null,
   second_category_id   int not null,
   second_catery_name   varchar(32) not null,
   third_category_id    int not null,
   third_category_name  varchar(32) not null
);



drop table if exists goods_info;
create table goods_info
(
   goods_id             bigint not null,
   goods_no             varchar(64) not null,
   goods_name           varchar(256) not null,
   curr_price           decimal(18,2) not null,
   third_category_id    int not null,
   goods_desc           varchar(256) not null,
   create_time          datetime not null,
   primary key (goods_id)
);




drop table if exists order_item;
create table order_item
(
   order_id             bigint not null,
   goods_id             bigint not null,
   goods_amount         int not null,
   curr_price           decimal(18,2) not null,
   create_time          datetime not null,
   primary key (order_id, goods_id)
);





drop table if exists user_addr;
create table user_addr
(
   addr_id              bigint not null,
   user_id              bigint not null,
   addr_name            varchar(512) not null,
   order_flag           tinyint not null,
   user_name            varchar(64) not null,
   mobile               bigint not null,
   primary key (addr_id, user_id)
);




drop table if exists order_delivery;
create table order_delivery
(
   order_id             bigint not null,
   addr_id              bigint not null,
   user_id              bigint not null,
   carriage_money       decimal(18,2) not null,
   create_time          datetime not null,
   primary key (order_id)
);
