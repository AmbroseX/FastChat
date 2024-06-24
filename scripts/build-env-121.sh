#安装环境 fastchat121
# pytorch/pytorch:2.3.0-cuda12.1-cudnn8-devel
# conda create -n FastChat python=3.10
# conda activate FastChat

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install -U pip
export CUDA_HOME=~/miniconda3/envs/cuda-12.1.1
# cudatoolkit
# conda install https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/linux-64/cudatoolkit-11.8.0-h4ba93d1_13.conda
# cudnn
# conda install https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/linux-64/cudnn-8.9.7.29-hcdd5f01_2.conda
# flash-attn版本高于2.1.1
# https://pytorch.org/get-started/previous-versions/

# xformers版本地址: https://github.com/facebookresearch/xformers/tags
pip install torch==2.3.0 torchvision==0.18.0 torchaudio==2.3.0 --index-url https://download.pytorch.org/whl/cu121

# https://github.com/huggingface/transformers/tags
pip install -e "."
pip install "transformers==4.40.1" tiktoken einops transformers_stream_generator==0.0.5
pip install accelerate autoawq peft sentencepiece protobuf 
# pydantic高版本弃用了dumps_kwargs
pip install fastapi uvicorn httpx shortuuid
pip install "fastrlock>=0.5"

pip install vllm==0.4.2 --cache-dir=~/.cache/pip
pip install sglang==0.1.16