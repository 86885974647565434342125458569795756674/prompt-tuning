# prompt-tuning

[google-research/prompt-tuning: Original Implementation of Prompt Tuning from Lester, et al, 2021 (github.com)](https://github.com/google-research/prompt-tuning)

JAX的主要出发点就是将numpy的以上优势与硬件加速结合。一个为实现了GPU加速的Numpy。

有一个依附于jax的库，flax，专门为实现神经网络而生。

# docker

bash t5x/contrib/gpu/docker/build.sh t5x:230505

bash t5x/contrib/gpu/docker/interactive_pull_and_launch.sh 489298/t5x:latest /data/yuyan/prompt-tuning/tfds_data_dir/ /data/yuyan/prompt-tuning/workspace/

pip install t5

python download_the_pile.py

在tfds_piple.py加:

from tensorflow_datasets.core.utils import gcs_utils                                               
gcs_utils._is_gcs_disabled = True  

在download_the_pile.py修改:

ds=tfds.load('ThePile',try_gcs=False) 

mkdir /workspace/model-dir

MODEL_DIR="/t5x_home/workspace/model-dir/"
TFDS_DATA_DIR="/t5x_home/datasets/"

gs://t5-data/pretrained_models/t5x/t5_1_1_lm100k_small/checkpoint_1100000

# linux pycharm

git config --global http.proxy http://172.18.216.39:7890                             

git config --global https.proxy http://172.18.216.39:7890               

pip install -e . --proxy=172.18.216.39:7890

ModuleNotFoundError: No module named 'distutils.cmd'

sudo apt-get install python3.6-distutils

ERROR: No matching distribution found for jax>=0.3.1

sudo apt-get install python3.8

export proxy=http://172.18.216.39:7890
export http_proxy=$proxy
export https_proxy=$proxy
export ftp_proxy=$proxy

bash sst2-demo.sh

ImportError: cannot import name 'optim' from 'flax' 

python -m pip uninstall flax -y

python -m pip install flax==0.5.3

'import prompt_tuning.data.glue' in your gin file

import prompt_tuning.data.glue in prompt_tuning/configs/models/t5_1_1_prompt.gin

Change all flax.core.pop in venv/lib/python3.8/site-packages/t5x/train_state.py to flax.core.FrozenDict.pop

python3 -m t5x.train --gin_search_paths="/home/c/prompt-tuning/prompt-tuning/venv/lib/python3.8/site-packages/t5x/..,/home/c/prompt-tuning/prompt-tuning/venv/lib/python3.8/site-packages/flaxformer/..,/home/c/prompt-tuning/prompt-tuning/prompt_tuning/.."
--gin_file="prompt_tuning/configs/models/t5_1_1_small_prompt.gin"
--gin_file="prompt_tuning/configs/prompts/from_class_labels.gin"
--gin_file="prompt_tuning/configs/runs/prompt_finetune.gin"
--gin.CLASS_LABELS="['positive', 'negative']"
--gin.MODEL_DIR="'/home/c/prompt-tuning/workspace/model/'"
--gin.MIXTURE_OR_TASK_NAME="'taskless_glue_sst2_v200_examples'"
--gin.MIXTURE_OR_TASK_MODULE="'prompt_tuning.data.glue'"
--gin.TASK_FEATURE_LENGTHS="{'inputs': 512, 'targets': 8}"
--gin.INITIAL_CHECKPOINT_PATH="'gs://t5-data/pretrained_models/t5x/t5_1_1_lm100k_small/checkpoint_1100000'"
--gin.TRAIN_STEPS="1_150_000"
--gin.USE_CACHED_TASKS="False"
--tfds_data_dir=/home/c/prompt-tuning/workspace/data/

# 网络

ACTIVATION_DTYPE = 'bfloat16'
ACTIVATION_PARTITIONING_DIMS = 1
SCALE = 1.0

PROMPT_LENGTH = 100

NUM_HEADS = 6
NUM_ENCODER_LAYERS = 8
NUM_DECODER_LAYERS = 8
HEAD_DIM = 64
EMBED_DIM = 512
MLP_DIM = 1024

DROPOUT_RATE = 0.1
USE_CACHED_TASKS = False
BATCH_SIZE = 128

配置文件顺序：

prompt_tuning/configs/architectures/t5_1_1_flaxformer.gin: t5_architecture.EncoderLayer, t5_architecture.Decoder

prompt_tuning/configs/architectures/prompt_encoder_t5_1_1_flaxformer.gin: ARCHITECTURE = @prompt_layers.PromptEncoderDecoder(), encoder_factory = @prompt_layers.PromptEncoder, decoder_factory = @t5_architecture.Decoder

prompt_tuning/configs/models/t5_1_1_prompt.gin: OPTIMIZER = @optim.MultiOptimizer(), MODEL = @models.EncoderDecoderModel()

prompt_tuning/configs/models/sizes/small.gin：NUM_ENCODER_LAYERS

prompt_tuning/configs/prompts/from_class_labels.gin: PROMPT = @train_prompts.Prompt

t5x/configs/runs/finetune.gin: model = %MODEL, trainer_cls = @trainer.Trainer，EVAL_PERIOD，warmup_steps

prompt_tuning/configs/runs/prompt_finetune.gin：period



train_script.train:
  model = %MODEL  # imported from separate gin file
  trainer_cls = @trainer.Trainer



trainer.Trainer:
  num_microbatches = None
  learning_rate_fn = @utils.create_learning_rate_scheduler()



MODEL = @models.EncoderDecoderModel()
models.EncoderDecoderModel:
  module = %ARCHITECTURE  # provided by t5_flaxformer
  optimizer_def = %OPTIMIZER



ARCHITECTURE = @prompt_layers.PromptEncoderDecoder()



prompt_layers.PromptEncoderDecoder:

  encoder_factory = @prompt_layers.PromptEncoder

  decoder_factory = @t5_architecture.Decoder

  shared_token_embedder_factory = @embedding.Embed
  dtype = %ACTIVATION_DTYPE

  encoder_mask_factory = @prompt_masks.create_prompt_encoder_mask
  add_fake_prompt_factory = @prompt_masks.add_fake_prompt



prompt_layers.PromptEncoder:

  prompt_factory = %PROMPT
  layer_factory = @t5_architecture.EncoderLayer



PROMPT = @train_prompts.Prompt

train_prompts.Prompt.prompt = @prompts.Prompt()



t5_architecture.EncoderDecoder:
  encoder_factory = @t5_architecture.Encoder
  decoder_factory = @t5_architecture.Decoder
  shared_token_embedder_factory = @embedding.Embed
  dtype = %ACTIVATION_DTYPE



t5_architecture.Encoder:
  layer_factory = @t5_architecture.EncoderLayer



t5_architecture.Decoder:
  layer_factory = @t5_architecture.DecoderLayer

 



