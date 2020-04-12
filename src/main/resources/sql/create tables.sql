create database db_muba default character set utf8;

use db_muba;

-- frequency of visiting app store = FOVAS（访问应用商店的频率）
create table t_dim_FOVAS
(
    FOVASCode int   default null,
    FOVASName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_FOVAS
values ('1', 'Never');
insert into t_dim_FOVAS
values ('2', 'Less than once a month');
insert into t_dim_FOVAS
values ('3', 'Once a month');
insert into t_dim_FOVAS
values ('4', 'More than once a month');
insert into t_dim_FOVAS
values ('5', 'Once a week');
insert into t_dim_FOVAS
values ('6', 'More than once a week');
insert into t_dim_FOVAS
values ('7', 'Once a day');
insert into t_dim_FOVAS
values ('8', 'Several times a day');
insert into t_dim_FOVAS
values ('9', 'Other');

-- apps downloaded per month = ADPM（每月下载的应用数）
create table t_dim_ADPM
(
    ADPMCode int   default null,
    ADPMName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_ADPM
values ('1', '0-1');
insert into t_dim_ADPM
values ('2', '2-5');
insert into t_dim_ADPM
values ('3', '6-10');
insert into t_dim_ADPM
values ('4', '11-20');
insert into t_dim_ADPM
values ('5', '21-30');
insert into t_dim_ADPM
values ('6', 'More than 30');

-- time to find apps = TTFA（在何时寻找应用）
create table t_dim_TTFA
(
    TTFACode int   default null,
    TTFAName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_TTFA
values ('1', 'When feeling depressed.');
insert into t_dim_TTFA
values ('2', 'When I need to carry out a task.');
insert into t_dim_TTFA
values ('3', 'When I am feeling bored.');
insert into t_dim_TTFA
values ('4', 'When I want to be entertained.');
insert into t_dim_TTFA
values ('5', 'When I need to know something.');
insert into t_dim_TTFA
values ('6', 'Other');

-- how to find apps = HTFA（如何寻找应用）
create table t_dim_HTFA
(
    HTFACode int   default null,
    HTFAName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_HTFA
values ('1', 'I compare several apps in order to choose the best ones.');
insert into t_dim_HTFA
values ('2', 'I download the first app that I see on the list of apps presented to me.');
insert into t_dim_HTFA
values ('3', 'I look for apps that are featured on the front page of the app store.');
insert into t_dim_HTFA
values ('4', 'I look at the top downloads chart.');
insert into t_dim_HTFA
values ('5', 'I browse randomly for apps that might interest me.');
insert into t_dim_HTFA
values ('7', 'I search the app store using keywords/name.');
insert into t_dim_HTFA
values ('8', 'I visit websites that review apps.');
insert into t_dim_HTFA
values ('9', 'I use search engines.');
insert into t_dim_HTFA
values ('10', 'Other');

-- considerations for downloading apps = CFDA（下载应用的考虑因素）
create table t_dim_CFDA
(
    CFDACode int   default null,
    CFDAName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_CFDA
values ('1', 'Reviews by other users');
insert into t_dim_CFDA
values ('2', 'Name of app');
insert into t_dim_CFDA
values ('3', 'Number of users who have downloaded the app');
insert into t_dim_CFDA
values ('4', 'Icon');
insert into t_dim_CFDA
values ('5', 'Description of the app');
insert into t_dim_CFDA
values ('6', 'Features');
insert into t_dim_CFDA
values ('7', 'Number of users who have rated the app');
insert into t_dim_CFDA
values ('8', 'Price');
insert into t_dim_CFDA
values ('9', 'Star rating');
insert into t_dim_CFDA
values ('10', 'Size of app');
insert into t_dim_CFDA
values ('11', 'Screen shots');
insert into t_dim_CFDA
values ('12', 'Who developed the app');
insert into t_dim_CFDA
values ('13', 'Other');

# drop table t_dim_cfda;

-- reasons for downloading apps = RFDA（下载应用的原因）
create table t_dim_RFDA
(
    RFDACode int   default null,
    RFDAName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_RFDA
values ('1', 'To interact with friends and/or family.');
insert into t_dim_RFDA
values ('2', 'To interact with people I do not know.');
insert into t_dim_RFDA
values ('3', 'To help me carry out a task.');
insert into t_dim_RFDA
values ('4', 'It is featured in the app store.');
insert into t_dim_RFDA
values ('5', 'It is on the top downloads chart.');
insert into t_dim_RFDA
values ('6', 'It is advertised in the apps that I am using.');
insert into t_dim_RFDA
values ('7', 'For entertainment.');
insert into t_dim_RFDA
values ('8', 'Out of curiosity.');
insert into t_dim_RFDA
values ('9', 'An impulsive purchase.');
insert into t_dim_RFDA
values ('10', 'It features brands or celebrities that I like.');
insert into t_dim_RFDA
values ('11', 'It was mentioned in the media.');
insert into t_dim_RFDA
values ('12', 'It is an extension of the website that I use.');
insert into t_dim_RFDA
values ('13', 'It is recommended by friends and/or family.');
insert into t_dim_RFDA
values ('14', 'For someone else.');
insert into t_dim_RFDA
values ('15', 'Other');

# drop table t_dim_rfda;

# drop table t_dim_rfsm;

-- reasons for spending money on apps = RFSM（在应用内消费的原因）
create table t_dim_RFSM
(
    RFSMCode int   default null,
    RFSMName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_RFSM
values ('1', 'I do not pay for apps.');
insert into t_dim_RFSM
values ('2', 'To remove ads from the app.');
insert into t_dim_RFSM
values ('3', 'The paid app is on sale for a reduced price.');
insert into t_dim_RFSM
values ('4', 'To subscribe to free content.');
insert into t_dim_RFSM
values ('5', 'The app is initially free but I have to pay for features that I want.');
insert into t_dim_RFSM
values ('6', 'I can not find a free app with similar features.');
insert into t_dim_RFSM
values ('7', 'To get additional features or content for a paid app.');
insert into t_dim_RFSM
values ('8', 'To subscribe to paid content.');
insert into t_dim_RFSM
values ('9', 'The paid app appears to be of better quality.');
insert into t_dim_RFSM
values ('10', 'Other');
insert into t_dim_RFSM
values ('11', 'I think paid apps have better quality.');
insert into t_dim_RFSM
values ('12', 'I think paid apps have more features.');

-- reasons for rating apps = RFRA（评价应用的原因）
create table t_dim_RFRA
(
    RFRACode int   default null,
    RFRAName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_RFRA
values ('1', 'I do not rate apps.');
insert into t_dim_RFRA
values ('2', 'To let other users to know that the app is good.');
insert into t_dim_RFRA
values ('3', 'Someone asked me to do so.');
insert into t_dim_RFRA
values ('4', 'The app asked me to rate it.');
insert into t_dim_RFRA
values ('5', 'To let other users know that the app is bad.');
insert into t_dim_RFRA
values ('6', 'The app rewards me for rating it.');
insert into t_dim_RFRA
values ('7', 'Other');

-- reasons for stopping using an app = RFSU（停止使用应用的原因）
create table t_dim_RFSU
(
    RFSUCode int   default null,
    RFSUName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_RFSU
values ('1', 'It crashes.');
insert into t_dim_RFSU
values ('2', 'I found better alternatives.');
insert into t_dim_RFSU
values ('3', 'The ads are annoying.');
insert into t_dim_RFSU
values ('4', 'It is difficult to use.');
insert into t_dim_RFSU
values ('5', 'It is no longer used by my friends and/or family.');
insert into t_dim_RFSU
values ('6', 'I need to pay extra for the features I need.');
insert into t_dim_RFSU
values ('7', 'I forgot about the app.');
insert into t_dim_RFSU
values ('8', 'I do not need the features it provides.');
insert into t_dim_RFSU
values ('9', 'It invades my privacy.');
insert into t_dim_RFSU
values ('10', 'It is too slow.');
insert into t_dim_RFSU
values ('11', 'I got bored about it.');
insert into t_dim_RFSU
values ('12', 'It does not work.');
insert into t_dim_RFSU
values ('13', 'It does not have the features I hoped for.');
insert into t_dim_RFSU
values ('14', 'Other');
insert into t_dim_RFSU
values ('15', 'I do not need it anymore.');

-- type of apps = TOAD（下载应用的类别）
create table t_dim_TOAD
(
    TOADCode int   default null,
    TOADName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_TOAD
values ('1', 'Navigation');
insert into t_dim_TOAD
values ('2', 'Business');
insert into t_dim_TOAD
values ('3', 'Catalogues');
insert into t_dim_TOAD
values ('4', 'Travel');
insert into t_dim_TOAD
values ('5', 'Books');
insert into t_dim_TOAD
values ('6', 'Photo & video');
insert into t_dim_TOAD
values ('7', 'Lifestyle');
insert into t_dim_TOAD
values ('8', 'Entertainment');
insert into t_dim_TOAD
values ('9', 'Finance');
insert into t_dim_TOAD
values ('10', 'News');
insert into t_dim_TOAD
values ('11', 'Travel');
insert into t_dim_TOAD
values ('12', 'Health & fitness');
insert into t_dim_TOAD
values ('13', 'Games');
insert into t_dim_TOAD
values ('14', 'Food & drink');
insert into t_dim_TOAD
values ('15', 'Education');
insert into t_dim_TOAD
values ('16', 'Medical');
insert into t_dim_TOAD
values ('17', 'Social networking');
insert into t_dim_TOAD
values ('18', 'Reference');
insert into t_dim_TOAD
values ('19', 'Sports');
insert into t_dim_TOAD
values ('20', 'Utilities');
insert into t_dim_TOAD
values ('21', 'Weather');
insert into t_dim_TOAD
values ('22', 'Productivity');
insert into t_dim_TOAD
values ('23', 'Other');
insert into t_dim_TOAD
values ('24', 'Cannot remember or never use app');

-- gender（性别）
create table t_dim_gender
(
    genderCode int   default null,
    genderName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_gender
values ('1', 'Male');
insert into t_dim_gender
values ('2', 'Female');

-- age（年龄）
create table t_dim_age
(
    ageCode int   default null,
    ageName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_age
values ('1', 'Under 18');
insert into t_dim_age
values ('2', '18-30');
insert into t_dim_age
values ('3', '31-45');
insert into t_dim_age
values ('4', '46-60');
insert into t_dim_age
values ('5', 'Over 60');

-- martial status = MS（婚姻状况）
create table t_dim_MS
(
    MSCode int   default null,
    MSName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_MS
values ('1', 'In a relationship');
insert into t_dim_MS
values ('2', 'Single');
insert into t_dim_MS
values ('3', 'Married');
insert into t_dim_MS
values ('4', 'Divorced');
insert into t_dim_MS
values ('5', 'Widowed');
insert into t_dim_MS
values ('6', 'Separated');
insert into t_dim_MS
values ('7', 'Other');

-- nationality（国籍）
create table t_dim_nationality
(
    nationalityCode int   default null,
    nationalityName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_nationality
values ('1', 'United States');
insert into t_dim_nationality
values ('2', 'Australia');
insert into t_dim_nationality
values ('3', 'Brazil');
insert into t_dim_nationality
values ('4', 'United Kingdom');
insert into t_dim_nationality
values ('5', 'Canada');
insert into t_dim_nationality
values ('6', 'China');
insert into t_dim_nationality
values ('7', 'France');
insert into t_dim_nationality
values ('8', 'Germany');
insert into t_dim_nationality
values ('9', 'India');
insert into t_dim_nationality
values ('10', 'Italy');
insert into t_dim_nationality
values ('11', 'Japan');
insert into t_dim_nationality
values ('12', 'Mexico');
insert into t_dim_nationality
values ('13', 'Russian Federation');
insert into t_dim_nationality
values ('14', 'Republic of Korea');
insert into t_dim_nationality
values ('15', 'Spain');
insert into t_dim_nationality
values ('16', 'Other');

# drop table t_dim_nationality;

-- level of education = LOE（受教育程度）
create table t_dim_LOE
(
    LOECode int   default null,
    LOEName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_LOE
values ('1', 'Primary school');
insert into t_dim_LOE
values ('2', 'Secondary/High school');
insert into t_dim_LOE
values ('3', 'Diploma');
insert into t_dim_LOE
values ('4', 'Vocational training');
insert into t_dim_LOE
values ('5', 'Undergraduate degree');
insert into t_dim_LOE
values ('6', 'Master''s degree');
insert into t_dim_LOE
values ('7', 'Doctoral degree');
insert into t_dim_LOE
values ('8', 'Other');

-- current employment status = CES（当前就业状态）
create table t_dim_CES
(
    CESCode int   default null,
    CESName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_CES
values ('1', 'Full-time');
insert into t_dim_CES
values ('2', 'Part-time');
insert into t_dim_CES
values ('3', 'Self-employed');
insert into t_dim_CES
values ('4', 'Student');
insert into t_dim_CES
values ('5', 'Homemaker');
insert into t_dim_CES
values ('6', 'Unemployed');
insert into t_dim_CES
values ('7', 'Unable to work');
insert into t_dim_CES
values ('8', 'Retired');
insert into t_dim_CES
values ('9', 'Other');

-- occupation（职业）
create table t_dim_occupation
(
    occupationCode int   default null,
    occupationName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_occupation values ('1', 'Management');
insert into t_dim_occupation values ('2', 'Business and Financial Operations');
insert into t_dim_occupation values ('3', 'Computer and Mathematical');
insert into t_dim_occupation values ('4', 'Architecture and Engineering');
insert into t_dim_occupation values ('5', 'Life, Physical, and Social Science');
insert into t_dim_occupation values ('6', 'Community and Social Services');
insert into t_dim_occupation values ('7', 'Legal');
insert into t_dim_occupation values ('8', 'Education, Training, and Library');
insert into t_dim_occupation values ('9', 'Arts, Design, Entertainment, Sports, and Media');
insert into t_dim_occupation values ('10', 'Healthcare Practitioners and Technical');
insert into t_dim_occupation values ('11', 'Healthcare Support');
insert into t_dim_occupation values ('12', 'Protective Service');
insert into t_dim_occupation values ('13', 'Food Preparation and Serving Related');
insert into t_dim_occupation values ('14', 'Building and Grounds Cleaning and Maintenance');
insert into t_dim_occupation values ('15', 'Personal Care and Service');
insert into t_dim_occupation values ('16', 'Sales and Related');
insert into t_dim_occupation values ('17', 'Office and Administrative Support');
insert into t_dim_occupation values ('18', 'Farming, Fishing, and Forestry');
insert into t_dim_occupation values ('19', 'Construction and Extraction');
insert into t_dim_occupation values ('20', 'Installation, Maintenance, and Repair');
insert into t_dim_occupation values ('21', 'Production');
insert into t_dim_occupation values ('22', 'Transportation and Material Moving');
insert into t_dim_occupation values ('23', 'Military Specific');
insert into t_dim_occupation values ('24', 'Student');
insert into t_dim_occupation values ('25', 'Other');

-- household income currency = HIC（家庭收入的货币种类）
create table t_dim_HIC
(
    HICCode int   default null,
    HICName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_HIC
values ('1', 'AUD');
insert into t_dim_HIC
values ('2', 'BRL');
insert into t_dim_HIC
values ('3', 'GBP');
insert into t_dim_HIC
values ('4', 'CAD');
insert into t_dim_HIC
values ('5', 'CNY');
insert into t_dim_HIC
values ('6', 'EUR');
insert into t_dim_HIC
values ('7', 'INR');
insert into t_dim_HIC
values ('8', 'JPY');
insert into t_dim_HIC
values ('9', 'MXN');
insert into t_dim_HIC
values ('10', 'RUB');
insert into t_dim_HIC
values ('11', 'KRW');
insert into t_dim_HIC
values ('12', 'USD');
insert into t_dim_HIC
values ('13', 'Other');

# drop table t_dim_lohi;

-- level of household income = LOHI（家庭收入水平）
create table t_dim_LOHI
(
    LOHICode int   default null,
    LOHIName varchar(100) default null
) engine = InnoDB
  default charset = utf8;

insert into t_dim_LOHI
values ('1', 'Low');
insert into t_dim_LOHI
values ('2', 'Medium');
insert into t_dim_LOHI
values ('3', 'High');
insert into t_dim_LOHI
values ('4', 'Prefer not to say');

--  device info（用户设备信息）
create table device
(
    pid            varchar(5)  default null comment '参与者id',
    browserName    varchar(50) default null comment '浏览器名称',
    browserVersion varchar(50) default null comment '浏览器版本',
    os             varchar(50) default null comment '操作系统',
    phoneBrand     varchar(50) default null comment '手机品牌',
    phoneModel     varchar(50) default null comment '手机型号'
) engine = InnoDB
  default charset = utf8;

-- # drop table device;

-- user behavior（用户行为）
create table behavior
(
    pid       varchar(5) default null comment '参与者id',
    FOVASCode varchar(100) default null comment '访问应用商店的频率',
    TOFACode  varchar(100) default null comment '最喜欢的应用的类别',
    TOADCode  varchar(100) default null comment '下载应用的类别',
    ADPMCode  varchar(100) default null comment '每月下载的应用数',
    TTFACode  varchar(100) default null comment '在何时寻找应用',
    HTFACode  varchar(100) default null comment '如何寻找应用',
    CFDACode  varchar(100) default null comment '下载应用的考虑因素',
    RFDACode  varchar(100) default null comment '下载应用的原因',
    RFSMCode  varchar(100) default null comment '在应用内消费的原因',
    RFRACode  varchar(100) default null comment '评价应用的原因',
    RFSUCode  varchar(100) default null comment '停止使用应用的原因'
) engine = InnoDB
  default charset = utf8;

-- #  drop table behavior;

-- demographic info（人口统计信息）
create table demographic
(
    pid             varchar(5) default null comment '参与者id',
    genderCode      varchar(50) default null comment '性别编码',
    ageCode             varchar(50) default null comment '年龄段编码',
    MSCode          varchar(50) default null comment '婚姻状况编码',
    nationalityCode varchar(50) default null comment '国籍编码',
    LOECode         varchar(50) default null comment '受教育程度编码',
    CESCode         varchar(50) default null comment '就业状态编码',
    occupationCode  varchar(50) default null comment '职业编码',
    HICCode         varchar(50) default null comment '收入货币编码',
    LOHICode        varchar(50) default null comment '收入水平编码',
    BigFiveE        varchar(50) default null comment '人格-外倾性',
    BigFiveN        varchar(50) default null comment '人格-神经质',
    BigFiveA        varchar(50) default null comment '人格-开放性',
    BigFiveO        varchar(50) default null comment '人格-随和性',
    BigFiveC        varchar(50) default null comment '人格-尽责性'
) engine = InnoDB
  default charset = utf8;

# drop table demographic;

INSERT INTO device VALUES ('1','MSIE','10','Windows','Samsung',''),
                          ('2','Chrome','80.0.3987.149','Windows','One Plus',''),
                          ('3','Chrome','80.0.3987.149','Linux','Apple',''),
                          ('4','Chrome','80.0.3987.149','Linux','Samsung',''),
                          ('5','Firefox','73.0.1','Linux','Apple',''),
                          ('6','Firefox','73.0.1','Windows','Samsung',''),
                          ('7','Chrome','80.0.3987.149','Windows','Huawei',''),
                          ('8','Chrome','80.0.3987.149','Windows','Huawei',''),
                          ('9','Firefox','73.0.1','Linux','Samsung',''),
                          ('10','Chrome','80.0.3987.149','Windows','Xiaomi',''),
                          ('11','Firefox','73.0.1','Windows','Samsung',''),
                          ('12','Safari','12.0.3','Mac OS','Xiaomi',''),
                          ('13','MSIE','10','Windows','One Plus',''),
                          ('14','Safari','12.0.3','Mac OS','One Plus',''),
                          ('15','MSIE','10','Windows','Honor','');

# 数据总览
create or replace view v_overall_data as
select a.pid, browserName, phoneBrand, FOVASCode, TOADCode, ADPMCode, TTFACode, HTFACode,
       CFDACode, RFDACode, RFSMCode, RFRACode, RFSUCode, nationalityCode
from device a, behavior b, demographic c
where a.pid=b.pid and b.pid=c.pid;

# 访问应用商店的频率和每月下载应用数
create or replace view v_fovas_adpm as
select pid, FOVASName, ADPMName
from behavior a, t_dim_fovas b, t_dim_adpm c
where a.FOVASCode=b.FOVASCode and a.ADPMCode=c.ADPMCode;

# 以下新建视图代码不能直接用，必须先把原始表中的逗号分隔数据进行转换
# 做法：新建一个视图来存放分解之后的数据，再将下面的behavior表替换为新建的视图
# 年龄和下载应用的类别
create or replace view v_toad_age as
select a.pid, TOAName, ageCode
from behavior a, demographic b, t_dim_toa c
where a.pid=b.pid and a.TOADCode=c.TOACode
group by ageCode desc;
# 收入水平和在应用内消费的原因
create or replace view v_rfsm_lohi as
select a.pid, LOHIName, RFSMName
from behavior a, demographic b, t_dim_rfsm c, t_dim_lohi d
where a.pid=b.pid and a.RFSMCode=c.RFSMCode and b.LOHICode=d.LOHICode;
# 职业和下载应用的类别
create or replace view v_toad_occupation as
select a.pid, occupationName, TOAName
from behavior a, demographic b, t_dim_toa c, t_dim_occupation d
where a.pid=b.pid and a.TOADCode=c.TOACode and b.occupationCode=d.occupationCode;
# 性别和下载应用时的考虑因素
create or replace view v_cfda_gender as
select a.pid, genderName, CFDAName
from behavior a, demographic b, t_dim_cfda c, t_dim_gender d
where a.pid=b.pid and a.CFDACode=c.CFDACode and b.genderCode=d.genderCode;
# 年龄和在何时寻找应用
create or replace view v_ttfa_age as
select a.pid, ageCode, TTFAName
from behavior a, demographic b, t_dim_ttfa c
where a.pid=b.pid and a.TTFACode=c.TTFACode;
# 性别和在应用内消费的原因
create or replace view v_rfsm_gender as
select a.pid, genderName, RFSMName
from behavior a, demographic b, t_dim_rfsm c, t_dim_gender d
where a.pid=b.pid and a.RFSMCode=c.RFSMCode and b.genderCode=d.genderCode;
# 受教育程度和寻找应用的方式
create or replace view v_htfa_loe as
select a.pid, HTFAName, LOEName
from behavior a, demographic b, t_dim_htfa c, t_dim_loe d
where a.pid=b.pid and a.HTFACode=c.HTFACode and b.LOECode=d.LOECode;
# 收入水平和手机品牌
create view v_phonebrand_lohi as
select a.pid, phoneBrand, LOHIName
from device a, demographic b, t_dim_lohi c
where a.pid=b.pid and b.LOHICode=c.LOHICode;

# 将逗号分隔的数据列分解成多行生成视图
create or replace view v_gender_toad as
select a.pid, genderName, TOAName from (SELECT a.pid, substring_index(substring_index(a.TOADCode,',', b.help_topic_id + 1),',', - 1) AS TOADCode
FROM behavior a JOIN mysql.help_topic b ON b.help_topic_id <
    (length(a.TOADCode) - length(REPLACE(a.TOADCode, ',', '')) + 1)) a, demographic b, t_dim_toa c, t_dim_gender d
where a.pid=b.pid and a.TOADCode=c.TOACode and b.genderCode=d.genderCode