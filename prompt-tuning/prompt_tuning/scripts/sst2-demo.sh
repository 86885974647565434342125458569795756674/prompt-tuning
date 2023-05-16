#!/usr/bin/env bash

#MODEL_DIR=${1:-${MODEL_DIR}}
#TFDS_DATA_DIR=${2:-${TFDS_DATA_DIR}}

MODEL_DIR="/home/c/prompt-tuning/workspace/model/"
TFDS_DATA_DIR="/home/c/prompt-tuning/workspace/data/"

if [ -z ${MODEL_DIR} ] || [ -z ${TFDS_DATA_DIR} ]; then
  echo "usage: ./sst2-demo.sh gs://your-bucket/path/to/model_dir gs://your-bucket/path/to/tfds/cache"
  exit 1
fi

T5X_DIR="`python3 -m prompt_tuning.scripts.find_module t5x`/.."
FLAXFORMER_DIR="`python3 -m prompt_tuning.scripts.find_module flaxformer`/.."
PROMPT_DIR="`python3 -m prompt_tuning.scripts.find_module prompt_tuning`/.."
echo "Searching for gin configs in:"
echo "- ${T5X_DIR}"
echo "- ${FLAXFORMER_DIR}"
echo "- ${PROMPT_DIR}"
echo "============================="

#
PRETRAINED_MODEL="gs://t5-data/pretrained_models/t5x/t5_1_1_lm100k_small/checkpoint_1100000"

#
#python3 -m t5x.train \
#  --gin_search_paths="${T5X_DIR},${FLAXFORMER_DIR},${PROMPT_DIR}" \
#  --gin_file="prompt_tuning/configs/models/t5_1_1_small_prompt.gin" \
#  --gin_file="prompt_tuning/configs/prompts/from_class_labels.gin" \
#  --gin_file="prompt_tuning/configs/runs/prompt_finetune.gin" \
#  --gin.CLASS_LABELS="['positive', 'negative']" \
#  --gin.MODEL_DIR="'${MODEL_DIR}'" \
#  --gin.MIXTURE_OR_TASK_NAME="'taskless_glue_sst2_v200_examples'" \
#  --gin.MIXTURE_OR_TASK_MODULE="'prompt_tuning.data.glue'" \
#  --gin.TASK_FEATURE_LENGTHS="{'inputs': 512, 'targets': 8}" \
#  --gin.INITIAL_CHECKPOINT_PATH="'${PRETRAINED_MODEL}'" \
#  --gin.TRAIN_STEPS="1_150_000" \
#  --gin.USE_CACHED_TASKS="False" \
#  --tfds_data_dir=${TFDS_DATA_DIR}

echo  "python3 -m t5x.train"
echo  --gin_search_paths="${T5X_DIR},${FLAXFORMER_DIR},${PROMPT_DIR}"
echo  --gin_file="prompt_tuning/configs/models/t5_1_1_small_prompt.gin"
echo  --gin_file="prompt_tuning/configs/prompts/from_class_labels.gin"
echo  --gin_file="prompt_tuning/configs/runs/prompt_finetune.gin"
echo  --gin.CLASS_LABELS="['positive', 'negative']"
echo  --gin.MODEL_DIR="'${MODEL_DIR}'"
echo  --gin.MIXTURE_OR_TASK_NAME="'taskless_glue_sst2_v200_examples'"
echo  --gin.MIXTURE_OR_TASK_MODULE="'prompt_tuning.data.glue'"
echo  --gin.TASK_FEATURE_LENGTHS="{'inputs': 512, 'targets': 8}"
echo  --gin.INITIAL_CHECKPOINT_PATH="'${PRETRAINED_MODEL}'"
echo  --gin.TRAIN_STEPS="1_150_000"
echo  --gin.USE_CACHED_TASKS="False"
echo  --tfds_data_dir=${TFDS_DATA_DIR}