#!/bin/bash
# This script is used to decompress FASTQ files using fastqZipCpp.

set -e
set -u
set -o pipefail

# 定义基础路径和工具路径
SHIJIASHUAI_BASE="/data/lush-dev/shijiashuai"
FASTQZIP_DIR="${SHIJIASHUAI_BASE}/release/fastqzip"
TIME_TOOL="${SHIJIASHUAI_BASE}/tools/time/time-1.9/time"
OUTPUT_DIR="${FASTQZIP_DIR}/test/out_decompress/"
REFERENCE_FASTA="${SHIJIASHUAI_BASE}/data/index/hg19/hg19.fasta"

# 生成时间戳
TimeStamp=$(date +%m%d%H%M%S)

# 定义输入文件路径
ZIP_FILE="${1:-/data1/test_data/fastq/GIAB_Data/WGS/pcr_free/MGISEQ_2000/HG001_NA12878/NA12878_1/MGISEQ2000_PCR-free_NA12878_1_V100003043_L01_1.fq}"

# 检查输入文件是否存在
if [ ! -f "${ZIP_FILE}" ]; then
    echo "Error: ZIP file ${ZIP_FILE} does not exist."
    exit 1
fi

# 确保输出目录存在
if [ ! -d "${OUTPUT_DIR}" ]; then
    echo "Creating output directory ${OUTPUT_DIR}."
    mkdir -p "${OUTPUT_DIR}"
fi

# 执行解压缩命令
"${TIME_TOOL}" -o "${OUTPUT_DIR}/time_${TimeStamp}.log" -v \
 "${FASTQZIP_DIR}/fastqZip" decompress \
 -f "${ZIP_FILE}" \
 -r "${REFERENCE_FASTA}" \
 -t 24 \
 --output "${OUTPUT_DIR}" \
 -g \
 &> "${OUTPUT_DIR}/decompress_${TimeStamp}.log"
