#!/bin/bash
# Name    : start_script.py
# Date    : 2016.03.28
# Func    : 启动脚本
# Note    : 注意：当前路径为应用部署文件夹

#############################################################
# 初始化环境

# 用户自定义
app_folder="mysqld_exporter"                 # 项目根目录
process_name="mysqld_exporter"       # 进程名

install_base="/data/exporter"          # 安装根目录
data_base="/data/easyops"             # 日志/数据根目录

#############################################################

# 执行准备
install_path="${install_base}/${app_folder}/"
if [[ ! -d ${install_path} ]]; then
    echo "${install_path} is not exist"
    exit 1
fi

# 配置文件
config_path="$install_path/conf/my.cnf"
if [[ ! -f ${config_path} ]]; then
    config_path="$install_path/conf/my.default.cnf"
fi

# 启动命令
start_cmd="./bin/mysqld_exporter --web.listen-address=:9104 --config.my-cnf=${config_path} >/dev/null 2>log/${app_folder}.log &"


# 日志目录
log_path="${data_base}/${app_folder}/log"
mkdir -p ${log_path}
cd ${install_path} && ln -snf ${log_path} log


#############################################################

# 启动程序
echo "start by cmd: ${start_cmd}"
cd ${install_path} && eval "${start_cmd}"
if [[ $? -ne 0 ]];then
    echo "start error, exit"
    exit 1
fi
#############################################################
