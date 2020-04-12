SELECT browserName as 浏览器, browserVersion as 版本, COUNT(*) as 频率
FROM device GROUP BY browserName, browserVersion;

SELECT os 操作系统, COUNT(*) 频率
FROM device GROUP BY os ORDER BY 频率 desc;

SELECT phoneBrand as 品牌, phoneModel as 型号, COUNT(*) as 频率
FROM device
GROUP BY phoneBrand, phoneModel;

SELECT * FROM device;

drop table behavior;

CREATE TABLE `company`
(
    `id`          int(20)      DEFAULT NULL,
    `name`        varchar(100) DEFAULT NULL,
    `shareholder` varchar(100) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
INSERT INTO `company` VALUES ('1', '阿里巴巴', '马云');
INSERT INTO `company` VALUES ('2', '淘宝', '马云,孙正义');

# 将逗号分隔的数据分成多行
select shareholder, count(*) times
from (SELECT a.id, a.Name,
             substring_index(substring_index(a.shareholder,',', b.help_topic_id + 1),',', - 1) AS shareholder
      FROM company a
               JOIN mysql.help_topic b ON b.help_topic_id <
                                          (length(a.shareholder) - length(REPLACE(a.shareholder, ',', '')) + 1)) c
group by c.shareholder order by times desc;

create or replace view company_copy as
select * from (SELECT a.id, a.Name,
        substring_index(substring_index(a.shareholder,',', b.help_topic_id + 1),',', - 1) AS shareholder
    FROM company a
        JOIN mysql.help_topic b ON b.help_topic_id <
            (length(a.shareholder) - length(REPLACE(a.shareholder, ',', '')) + 1)) c;


select * from device
where if(pid=1,any_value(browserVersion),browserName='Chrome');

select name, shareholder, count(shareholder) num from company
group by name, shareholder order by name desc ;

SELECT browserName as name, COUNT(*) AS y
FROM device WHERE browserName!= '' GROUP BY browserName ORDER BY y DESC;

# 各国有效问卷数
select nationalityName, count(*)
from v_overall_data a, t_dim_nationality b
where a.nationalityCode=b.nationalityCode;
# group by nationalityName;

select phoneBrand as name, COUNT(*) as y from v_overall_data
group by phoneBrand having y>100 order by y desc;

select browserName as name, COUNT(*) as y from device a, demographic b, t_dim_nationality c
where a.pid = b.pid and b.nationalityCode = c.nationalityCode and browserName !=''
and c.nationalityName = 'China' group by browserName order by y desc;

select phoneBrand as name, COUNT(*) as y from v_overall_data a, t_dim_nationality b
where a.nationalityCode = b.nationalityCode and nationalityName = 'China'
group by phoneBrand having y>10 order by y desc;

select phoneBrand as name, COUNT(*) as y from v_overall_data group by phoneBrand having y>100 order by y desc;

select TTFAName as name, COUNT(*) as y from v_pid_ttfa group by TTFAName order by y desc;

select TTFAName as name, COUNT(*) as y from v_pid_ttfa a, v_overall_data b, t_dim_nationality c
where a.pid=b.pid and b.nationalityCode=c.nationalityCode and c.nationalityName = 'China' group by TTFAName order by y desc;

select TTFAName as name, COUNT(*) as y from v_pid_ttfa where nationalityName = 'China' group by TTFAName order by y desc;

select HTFAName as name, COUNT(*) as y from v_pid_htfa group by HTFAName order by y desc;

select HTFAName as name, COUNT(*) as y from v_pid_htfa a, v_overall_data b, t_dim_nationality c
where a.pid=b.pid and b.nationalityCode=c.nationalityCode and c.nationalityName = 'China' group by HTFAName order by y desc;

select HTFAName as name, COUNT(*) as y from v_pid_htfa where nationalityName = 'China' group by HTFAName order by y desc;

select TTFACode from v_overall_data;

# create or replace view company_copy as
create or replace view v_pid_htfa as
select pid, a.HTFACode, HTFAName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.HTFACode,',', b.help_topic_id + 1),',', - 1) AS HTFACode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.HTFACode) - length(REPLACE(a.HTFACode, ',', '')) + 1)) a, t_dim_htfa b, t_dim_nationality c
    where a.HTFACode!='' and a.HTFACode=b.HTFACode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_ttfa as
select pid, a.TTFACode, TTFAName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.TTFACode,',', b.help_topic_id + 1),',', - 1) AS TTFACode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.TTFACode) - length(REPLACE(a.TTFACode, ',', '')) + 1)) a, t_dim_ttfa b, t_dim_nationality c
where a.TTFACode!='' and a.TTFACode=b.TTFACode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_cfda as
select pid, a.CFDACode, CFDAName, nationalityName from (SELECT a.pid,substring_index(substring_index(a.CFDACode,',', b.help_topic_id + 1),',', - 1) AS CFDACode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.CFDACode) - length(REPLACE(a.CFDACode, ',', '')) + 1)) a, t_dim_cfda b, t_dim_nationality c
where a.CFDACode!='' and a.CFDACode=b.CFDACode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_rfda as
select pid, a.RFDACode, RFDAName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.RFDACode,',', b.help_topic_id + 1),',', - 1) AS RFDACode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.RFDACode) - length(REPLACE(a.RFDACode, ',', '')) + 1)) a, t_dim_rfda b, t_dim_nationality c
where a.RFDACode!='' and a.RFDACode=b.RFDACode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_rfsu as
select pid, a.RFSUCode, RFSUName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.RFSUCode,',', b.help_topic_id + 1),',', - 1) AS RFSUCode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.RFSUCode) - length(REPLACE(a.RFSUCode, ',', '')) + 1)) a, t_dim_rfsu b, t_dim_nationality c
where a.RFSUCode!='' and a.RFSUCode=b.RFSUCode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_toad as
select pid, a.TOADCode, TOAName as TOADName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.TOADCode,',', b.help_topic_id + 1),',', - 1) AS TOADCode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.TOADCode) - length(REPLACE(a.TOADCode, ',', '')) + 1)) a, t_dim_toa b, t_dim_nationality c
where a.TOADCode!='' and a.TOADCode=b.TOACode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_rfra as
select pid, a.RFRACode, RFRAName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.RFRACode,',', b.help_topic_id + 1),',', - 1) AS RFRACode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.RFRACode) - length(REPLACE(a.RFRACode, ',', '')) + 1)) a, t_dim_rfra b, t_dim_nationality c
where a.RFRACode!='' and a.RFRACode=b.RFRACode and a.nationalityCode=c.nationalityCode;

create or replace view v_pid_rfsm as
select pid, a.RFSMCode, RFSMName, c.nationalityName from (SELECT a.pid,substring_index(substring_index(a.RFSMCode,',', b.help_topic_id + 1),',', - 1) AS RFSMCode, nationalityCode
FROM v_overall_data a JOIN mysql.help_topic b ON b.help_topic_id < (length(a.RFSMCode) - length(REPLACE(a.RFSMCode, ',', '')) + 1)) a, t_dim_rfsm b, t_dim_nationality c
where a.RFSMCode!='' and a.RFSMCode=b.RFSMCode and a.nationalityCode=c.nationalityCode;


select RFDAName as name, COUNT(*) as y from v_pid_rfda group by RFDAName order by y desc;
select TOADName as name, COUNT(*) as y from v_pid_toad group by TOADName having y>=1000 order by y desc;
select TOADName as name, COUNT(*) as y from v_pid_toad group by TOADName order by y desc limit 15;
select CFDAName as name, COUNT(*) as y from v_pid_cfda group by CFDAName order by y desc;
select RFDAName, nationalityName as name, COUNT(*) as y from v_pid_rfda group by RFDAName, nationalityName order by nationalityName desc;
select RFDAName as name, COUNT(*) as y from v_pid_rfda where nationalityName = 'China' group by RFDAName order by y desc;
select CFDAName as name, COUNT(*) as y from v_pid_cfda where nationalityName = 'China' group by CFDAName order by y desc;

select nationalityName, count(*) from v_pid_cfda group by nationalityName;

select FOVASName name, count(*) y from v_overall_data a, t_dim_nationality b, t_dim_fovas c
where a.nationalityCode=b.nationalityCode and a.FOVASCode=c.FOVASCode group by a.FOVASCode order by y desc ;

select count(*) from device where phoneBrand!='';
select count(*) from device where browserName!='';
select count(*) from v_overall_data where browserName!='';

create or replace view v_analysis_lohi as
select a.pid, b.LOHICode, LOHIName, RFSMName
from device a, demographic b, v_pid_rfsm c, t_dim_lohi d
where a.pid=b.pid and a.pid=c.pid and b.LOHICode=d.LOHICode;

select RFSMName name, LOHIName y, count(*) num from v_analysis_lohi group by RFSMName, LOHIName order by LOHIName;

create or replace view v_analysis_ttfa as
select a.pid, a.genderCode, genderName, a.ageCode, ageName, a.LOECode, LOEName, TTFAName
from demographic a, v_pid_ttfa b, t_dim_gender c, t_dim_age d, t_dim_loe e
where a.pid=b.pid and a.genderCode=c.genderCode and a.ageCode=d.ageCode and a.LOECode=e.LOECode;

create or replace view v_analysis_toad as
select a.pid, a.genderCode, genderName, a.ageCode, ageName, a.LOECode, LOEName, TOADName
from demographic a, v_pid_toad b, t_dim_gender c, t_dim_age d, t_dim_loe e
where a.pid=b.pid and a.genderCode=c.genderCode and a.ageCode=d.ageCode and a.LOECode=e.LOECode

create or replace view v_analysis_cfda as
select a.pid, a.genderCode, genderName, a.ageCode, ageName, a.LOECode, LOEName, CFDAName
from demographic a, v_pid_cfda b, t_dim_gender c, t_dim_age d, t_dim_loe e
where a.pid=b.pid and a.genderCode=c.genderCode and a.ageCode=d.ageCode and a.LOECode=e.LOECode

create or replace view v_analysis_rfda as
select a.pid, a.genderCode, genderName, a.ageCode, ageName, a.LOECode, LOEName, RFDAName
from demographic a, v_pid_rfda b, t_dim_gender c, t_dim_age d, t_dim_loe e
where a.pid=b.pid and a.genderCode=c.genderCode and a.ageCode=d.ageCode and a.LOECode=e.LOECode

create or replace view v_analysis_rfsu as
select a.pid, a.genderCode, genderName, a.ageCode, ageName, a.LOECode, LOEName, RFSUName
from demographic a, v_pid_rfsu b, t_dim_gender c, t_dim_age d, t_dim_loe e
where a.pid=b.pid and a.genderCode=c.genderCode and a.ageCode=d.ageCode and a.LOECode=e.LOECode

select TTFAName name, genderName y, count(*) num from v_analysis_ttfa
group by TTFAName, genderName order by genderName;

select TTFAName name, ageName y, count(*) num from v_analysis_ttfa
group by TTFAName, ageCode order by ageCode

select LOHIName name, count(*) y from v_analysis_lohi group by LOHIName order by y desc;

select phoneBrand name, count(*) y from v_overall_data group by phoneBrand order by y desc limit 11;

select LOHIName name, count(*) y from v_overall_data a, demographic b, t_dim_lohi c
where a.pid=b.pid and b.LOHICode=c.LOHICode and a.phoneBrand='Samsung' group by LOHIName;

select LOHIName name, count(*) y from demographic a, t_dim_lohi b where a.LOHICode=b.LOHICode group by a.LOHICode order by a.LOHICode

select TTFAName y, genderName name, count(*) num from v_analysis_ttfa group by TTFAName, genderCode order by genderCode

select phoneBrand name, count(*) y from device a, demographic b, t_dim_lohi c
where a.pid=b.pid and b.LOHICode=c.LOHICode and LOHIName='Low' group by name order by y desc;

select FOVASName, ADPMName, count(*) from v_fovas_adpm where FOVASName='Never' group by FOVASCode, ADPMCode;

create or replace view v_fovas_adpm as
select a.pid, a.FOVASCode, FOVASName, a.ADPMCode, ADPMName
from v_overall_data a, t_dim_fovas b, t_dim_adpm c
where a.FOVASCode=b.FOVASCode and a.ADPMCode=c.ADPMCode;

select FOVASName name, count(*) y from v_overall_data a, t_dim_nationality b, t_dim_fovas c where a.nationalityCode=b.nationalityCode and a.FOVASCode=c.FOVASCode group by a.FOVASCode order by a.FOVASCode;

select genderName name, count(*) y from demographic a, t_dim_gender b where a.genderCode=b.genderCode group by a.genderCode order by a.genderCode

select TOADName name, count(*) y from v_analysis_toad where ageName='Under 18' group by TOADName, ageCode order by ageCode;

select ageName name, count(*) y from demographic a, t_dim_age b where a.ageCode=b.ageCode group by a.ageCode order by a.ageCode

