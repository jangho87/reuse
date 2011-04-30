CREATE TABLE asset (
id int auto_increment not null,
asset_name varchar(200),
overall_description varchar(1000),
overall_description_file varchar(1000),
key(id),
primary key(asset_name));

CREATE TABLE domain
(domain_type char(200) ,
domain_name char(200) ,
asset_name char(200) references asset(asset_name));

CREATE TABLE project
(project_name char(200) ,
project_description varchar(1000),
project_institute char(200),
project_duration char(200),
asset_name char(200) references asset(asset_name));

CREATE TABLE relevant_asset
(relevanct_asset_type char(200) ,
relevanct_asset_file varchar(500),
asset_name char(200) references asset(asset_name));

CREATE TABLE interface
(required_interface char(200),
provided_interface char(200),
interface_upload char(200),
asset_name char(200) references asset(asset_name));

CREATE TABLE version
(version_name char(200),
asset_name char(200) references asset(asset_name));

CREATE TABLE operation_environment
(operation_env_pro_lang char(200),
operation_env_oper_system char(200),
operation_env_minimal_hw_spec char(200),
operation_env_compatible char(200),
asset_name char(200) references asset(asset_name));

CREATE TABLE required_libraries
(required_libraries_name char(200),
asset_name char(200) references asset(asset_name));

CREATE TABLE reuse_guidance
(reuse_guidance_type char(200),
reuse_guidance_link varchar(1000),
asset_name char(200) references asset(asset_name));

CREATE TABLE related_knowledge
(related_knowledge_name char(200),
asset_name char(200) references asset(asset_name));

CREATE TABLE alternatives_asset
(alternatives_asset_type char(200),
alternatives_asset_files varchar(1000),
asset_name char(200) references asset(asset_name));

CREATE TABLE problem
(problem_type char(200),
problem_subtype char(200),
problem_detail_description varchar(1000),
asset_name char(200) references asset(asset_name));

CREATE TABLE reuse_history
(reuse_history_count int,
reuse_history_domain varchar(1000),
reuse_history_project varchar(1000),
asset_name char(200) references asset(asset_name));

DROP table asset;
DROP table domain;
DROP table project
DROP table relevant_asset;
DROP table interface;
DROP table version;
DROP table operation_environment;
DROP table required_libraries;
DROP table reuse_guidance;
DROP table related_knowledge;
DROP table alternatives_asset;
DROP table problem;
DROP table reuse_history;
