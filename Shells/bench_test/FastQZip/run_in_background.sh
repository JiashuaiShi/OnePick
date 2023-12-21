#!/bin/bash

# 检查参数数量
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 script_to_run"
    exit 1
fi

# 获取脚本名称
script="$1"

# 在后台运行脚本
nohup ./"$script" > output.log 2>&1 &