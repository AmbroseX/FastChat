#安装环境 fastchat118
# nvcr.io/nvidia/cuda:12.1.0-devel-ubuntu22.04
# conda create -n FastChat2 python=3.10
# conda activate FastChat2

pip install -U pip
# cudatoolkit
conda install https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/linux-64/cudatoolkit-11.8.0-h4ba93d1_13.conda
# cudnn
conda install https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/linux-64/cudnn-8.9.7.29-hcdd5f01_2.conda
# flash-attn版本高于2.1.1
# https://pytorch.org/get-started/previous-versions/

# 自带的是torch 2.1.2, xformers==0.0.23.post1
pip install https://github.com/vllm-project/vllm/releases/download/v0.3.3/vllm-0.3.3+cu118-cp310-cp310-manylinux1_x86_64.whl --cache-dir=~/.cache/pip

# xformers版本地址: https://github.com/facebookresearch/xformers/tags
pip install torch==2.1.1 torchvision==0.16.1 torchaudio==2.1.1 xformers==0.0.23 --index-url https://download.pytorch.org/whl/cu118

# https://github.com/huggingface/transformers/tags
pip install "transformers==4.39.1" tiktoken einops transformers_stream_generator==0.0.5
pip install accelerate autoawq
# pydantic高版本弃用了dumps_kwargs
pip install fastapi uvicorn httpx shortuuid pydantic==1.10.11
pip install -e "."