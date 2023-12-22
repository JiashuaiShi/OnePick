#!/bin/bash

# 定义文件路径数组
files=(
"/workspace/shell/bench_test/FastZip/test/out_compress/out_1221063900.fastqzip"
"/workspace/shell/bench_test/FastZip/test/out_compress/out_1221073659.fastqzip"
"/workspace/shell/bench_test/FastZip/test/out_compress/out_1221083544.fastqzip"
"/workspace/shell/bench_test/FastZip/test/out_compress/out_1221091205.fastqzip"
)

# 初始化计数器
counter=0

# 循环调用decompress.sh脚本
for file in "${files[@]}"; do
    # 如果计数器是偶数，关闭-g
    if (( counter % 2 == 0 )); then
        ./decompress.sh "$file"
    else
        ./decompress.sh "$file" "-g"
    fi
    # 计数器加1
    ((counter++))
done