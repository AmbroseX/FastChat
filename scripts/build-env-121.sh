#安装环境 fastchat118
# nvcr.io/nvidia/cuda:12.1.0-devel-ubuntu22.04
# conda create -n FastChat4 python=3.10
# conda activate FastChat4

pip install -U pip
# cudatoolkit
conda install https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/linux-64/cudatoolkit-11.8.0-h4ba93d1_13.conda
# cudnn
conda install https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/linux-64/cudnn-8.9.7.29-hcdd5f01_2.conda
# flash-attn版本高于2.1.1
# https://pytorch.org/get-started/previous-versions/

# 自带的是torch 2.1.2, xformers==0.0.23.post1
pip install vllm==0.4.2 --cache-dir=~/.cache/pip

# xformers版本地址: https://github.com/facebookresearch/xformers/tags
pip install torch==2.3.0 torchvision==0.18.0 torchaudio==2.3.0 xformers==0.0.26.post1 --index-url https://download.pytorch.org/whl/cu121

# https://github.com/huggingface/transformers/tags
pip install "transformers==4.40.2" tiktoken einops transformers_stream_generator==0.0.5
pip install accelerate autoawq
# pydantic高版本弃用了dumps_kwargs
pip install fastapi uvicorn httpx shortuuid pydantic
pip install -e "."