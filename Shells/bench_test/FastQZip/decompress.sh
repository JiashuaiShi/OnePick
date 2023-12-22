#!/bin/bash
# This script is used to decompress FASTQZIP files using fastqZip.

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
timestamp=$(date +%m%d%H%M%S)

# 定义输入文件路径
ZIP_FILE="${1:-/workspace/shell/bench_test/FastZip/test/out_compress/out_1221063900.fastqzip}"

# 定义-g参数
G_OPTION="${2:--g}"

# 检查-g参数的有效性
if [[ "${G_OPTION}" != "-g" && -n "${G_OPTION}" ]]; then
    echo "Error: Invalid -g option ${G_OPTION}."
    exit 1
fi

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
"${TIME_TOOL}" -o "${OUTPUT_DIR}/time_${timestamp}.log" -v \
 "${FASTQZIP_DIR}/fastqZip" decompress \
 -f "${ZIP_FILE}" \
 -r "${REFERENCE_FASTA}" \
 -t 24 \
 --output "${OUTPUT_DIR}" \
 ${G_OPTION}
 &> "${OUTPUT_DIR}/decompress_${timestamp}.log"
