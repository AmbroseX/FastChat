#!/bin/bash

pip config --user set global.progress_bar off
# 启动 fastchat-controller 服务
# python3 -m fastchat.serve.controller\
#     --host 0.0.0.0 --port 21001 &

# 启动 fastchat-model-worker 服务
env CUDA_VISIBLE_DEVICES="${FASTCHAT_CUDA_DEVICE:0}" python3 -m fastchat.serve.model_worker \
    --model-names "${FASTCHAT_WOKRER_MODEL_NAMES:-vicuna-7b-v1.5}" \
    --model-path "${FASTCHAT_WORKER_MODEL_PATH:-lmsys/vicuna-7b-v1.5}" \
    --worker-address "http://localhost:21002" \
    --controller-address "http://${FASTCHAT_CONTROLLER_ADDRESS:localhost}:21001" \
    --host localhost --port 21002 &

# 启动 fastchat-api-server 服务
python3 -m fastchat.serve.openai_api_server \
    --host localhost --port 8000 \
    --controller-address http://${FASTCHAT_CONTROLLER_ADDRESS:localhost}:21001 \
    --api-keys "${FASTCHAT_API_KEYS:123456}" &

# 等待所有后台进程
wait