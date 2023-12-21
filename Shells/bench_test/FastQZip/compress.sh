#!/bin/bash
set -e
set -u
set -o pipefail

# 定义基础路径和工具路径
SHIJIASHUAI_BASE="/data/lush-dev/shijiashuai"
FASTQZIP_DIR="${SHIJIASHUAI_BASE}/release/fastqzip"
TIME_TOOL="${SHIJIASHUAI_BASE}/tools/time/time-1.9/time"

# 检查必要的文件和目录是否存在
if [ ! -d "${SHIJIASHUAI_BASE}" ] || [ ! -d "${FASTQZIP_DIR}" ] || [ ! -f "${TIME_TOOL}" ]; then
    echo "Required directories or files not found!"
    exit 1
fi

# 生成时间戳
TimeStamp=$(date +%m%d%H%M%S)

# 定义输入和输出路径
INPUT_FASTQ="${1:-default_fastq_path}"
OUTPUT_DIR="/workspace/shell/bench_test/FastZip/test/out_compress"
REFERENCE_FASTA="${SHIJIASHUAI_BASE}/data/index/hg19/hg19.fasta"

# 检查输入和输出路径是否存在，如果输出目录不存在则创建
if [ ! -f "${INPUT_FASTQ}" ] || [ ! -f "${REFERENCE_FASTA}" ]; then
    echo "Input file or reference fasta not found!"
    exit 1
fi

if [ ! -d "${OUTPUT_DIR}" ]; then
    echo "Creating output directory ${OUTPUT_DIR}."
    mkdir -p "${OUTPUT_DIR}"
fi

# 执行压缩命令
"${TIME_TOOL}" -o "${OUTPUT_DIR}/time_${TimeStamp}.log" -v \
 "${FASTQZIP_DIR}/fastqZip" compress \
 -f "${INPUT_FASTQ}" \
 -r "${REFERENCE_FASTA}" \
 -t 24 \
 --best \
 --output "${OUTPUT_DIR}/out_${TimeStamp}.fastqzip" \
 &> "${OUTPUT_DIR}/compress_${TimeStamp}.log"

# 可选参数，根据需要启用
#  --validate \
#  --no_sort_reads \
#  --line_number 500000 \
#  --chunk_stats . \
#  --global_stats .\
#  --global_stats ./global_stats.csv \
#  --chunk_stats ./chunk_stats.csv \
