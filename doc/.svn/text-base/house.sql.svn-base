/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2013/10/31 21:14:14                          */
/*==============================================================*/


drop table if exists tb_building_dict;

drop table if exists tb_city_info;

drop table if exists tb_decorate_dict;

drop table if exists tb_house_info;

drop table if exists tb_information_catagory;

drop table if exists tb_information_library;

drop table if exists tb_land_info;

drop table if exists tb_land_use_dict;

drop table if exists tb_sector_dict;

drop table if exists tb_structure_dict;

drop table if exists tb_user_info;

/*==============================================================*/
/* Table: tb_building_dict                                      */
/*==============================================================*/
create table tb_building_dict
(
   buildings_id         integer not null auto_increment,
   buildings_name       varchar(100),
   city_no              varchar(20),
   sector_id            int,
   pinyin               varchar(100),
   pinyin_letter        varchar(50),
   building_address     varchar(200),
   primary key (buildings_id)
);

/*==============================================================*/
/* Table: tb_city_info                                          */
/*==============================================================*/
create table tb_city_info
(
   city_no              varchar(20) not null,
   city_name            varchar(50),
   parent_no            varchar(20),
   primary key (city_no)
);

/*==============================================================*/
/* Table: tb_decorate_dict                                      */
/*==============================================================*/
create table tb_decorate_dict
(
   dict_id              int not null auto_increment,
   dict_name            varchar(50),
   primary key (dict_id)
);

/*==============================================================*/
/* Table: tb_house_info                                         */
/*==============================================================*/
create table tb_house_info
(
   house_id             integer not null auto_increment,
   house_type           char(1) comment '1商铺，2住宅，3办公，4工业',
   deal_type            char(1) comment '1出售，2出租',
   house_name           varchar(100),
   house_no             varchar(100),
   deal_time            datetime,
   city_no              varchar(20),
   locate               varchar(200),
   area_no              varchar(100),
   realuse              varchar(200),
   business_state       varchar(100),
   structure            varchar(100),
   construction_area    float,
   pool_area            float,
   building_date        varchar(10),
   new_situation        varchar(50),
   total_floor          int,
   floor                int,
   floor_height         float,
   decorate_situation   int comment '对应装修字典表',
   land_use_right       int comment '0出让，1划拨',
   land_expired_date    varchar(100),
   street_side          varchar(200),
   street_length        varchar(100),
   depth                varchar(50),
   total_price          float,
   unit_price           float,
   hire_state           varchar(200),
   hire_unit_price      float,
   Supporting_facilities varchar(200),
   contact_tel          varchar(20),
   collecter            varchar(50),
   remark               varchar(500),
   lng                  double,
   lat                  double,
   img                  varchar(100),
   contract             varchar(100),
   user_id              int,
   hire_expired_date    datetime,
   hire_price           float,
   transfer_fee         float,
   deposit              float,
   property_management_fee float,
   insert_time          datetime,
   office_facilities    varchar(200),
   parking_facilities   varchar(200),
   pilespacing          float,
   crane_beam           int,
   span                 float,
   primary key (house_id)
);

/*==============================================================*/
/* Table: tb_information_catagory                               */
/*==============================================================*/
create table tb_information_catagory
(
   catagory_id          int not null auto_increment,
   catagory_name        varchar(50),
   parent_id            int,
   primary key (catagory_id)
);

/*==============================================================*/
/* Table: tb_information_library                                */
/*==============================================================*/
create table tb_information_library
(
   info_id              int not null auto_increment,
   info_title           varchar(200),
   catagory_id          int,
   content              text,
   attachment           varchar(200),
   insert_time          datetime,
   user_id              int,
   primary key (info_id)
);

/*==============================================================*/
/* Table: tb_land_info                                          */
/*==============================================================*/
create table tb_land_info
(
   land_id              integer not null auto_increment,
   list_no              varchar(100),
   deal_time            datetime,
   city                 varchar(20),
   county               varchar(20),
   locate               varchar(100),
   level                int,
   use_no               int,
   use_scale            varchar(100),
   acreage              float,
   area_ratio           float,
   age_limit            int,
   starting_price       float,
   total_price          float,
   unit_price1          float,
   unit_price2          float,
   floor_price          float,
   deal_unit            varchar(100),
   bid_times            int,
   deal_confirmation    varchar(100) comment '附件-保留文件名',
   design_sheets        varchar(100) comment '保留文件名',
   mapping_result       varchar(100) comment '保留文件名',
   assessment_report    varchar(100) comment '保留文件名',
   lng                  double,
   lat                  double,
   remark               varchar(500),
   primary key (land_id)
);

/*==============================================================*/
/* Table: tb_land_use_dict                                      */
/*==============================================================*/
create table tb_land_use_dict
(
   dict_id              int not null,
   dict_name            varchar(50),
   parent_id            int,
   primary key (dict_id)
);

/*==============================================================*/
/* Table: tb_sector_dict                                        */
/*==============================================================*/
create table tb_sector_dict
(
   dict_id              int not null auto_increment,
   dict_name            varchar(50),
   city_no              varchar(20),
   primary key (dict_id)
);

/*==============================================================*/
/* Table: tb_structure_dict                                     */
/*==============================================================*/
create table tb_structure_dict
(
   dict_id              int not null auto_increment,
   dict_name            varchar(50),
   primary key (dict_id)
);

/*==============================================================*/
/* Table: tb_user_info                                          */
/*==============================================================*/
create table tb_user_info
(
   user_id              int not null auto_increment,
   username             varchar(20),
   user_pwd             varchar(16),
   true_name            varchar(20),
   user_level           int comment '0普通 1录入员 2超级管理员',
   is_valid             int,
   mobile               varchar(20),
   qq                   varchar(20),
   rank                 varchar(20),
   dept                 varchar(20),
   photo                varchar(100),
   idcard               varchar(30),
   address              varchar(200),
   remark               varchar(200),
   primary key (user_id)
);

