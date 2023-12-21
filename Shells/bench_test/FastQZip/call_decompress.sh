#!/bin/bash

# 定义文件路径数组
files=(
"/data/lush-dev/liuzhaoxi/data/FASTQ/HG005_NA24631_son/BGISEQ500_PCRfree_NA24631_CL100076244_L01_read_1.fq"
"/data/lush-dev/liuzhaoxi/data/FASTQ/HG005_NA24631_son/BGISEQ500_PCRfree_NA24631_CL100076244_L01_read_1.fq.gz"
"/data/lush-dev/liuzhaoxi/data/FASTQ/HG005_NA24631_son/BGISEQ500_PCRfree_NA24631_CL100076244_L01_read_1_4basequality.fq"
"/data/lush-dev/liuzhaoxi/data/FASTQ/HG005_NA24631_son/BGISEQ500_PCRfree_NA24631_CL100076244_L01_read_1_4basequality.fq.gz"
)

# 循环调用compress.sh脚本
for file in "${files[@]}"; do
    ./decompress.sh "$file"
done