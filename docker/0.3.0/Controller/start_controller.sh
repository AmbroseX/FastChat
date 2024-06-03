#!/bin/bash

pip config set global.progress_bar off
mkdir -p ./logs
mkdir -p ./model_logs
export OPENBLAS_NUM_THREADS=1
# 启动controller
nohup python3 ./fastchat/serve/controller.py \
    --host ${FASTCHAT_CONTROLLER_ADDRESS} \
    --port ${FASTCHAT_CONTROLLER_PORT} \
    --log-level ${FASTCHAT_LOG_LEVEL} | tee ./logs/controller.log &

# 启动openai_api_server
nohup python3 ./fastchat/serve/openai_api_server.py \
    --host ${FASTCHAT_CONTROLLER_ADDRESS} --port ${FASTCHAT_OPENAI_API_PORT} \
    --controller-address http://${FASTCHAT_CONTROLLER_ADDRESS}:${FASTCHAT_CONTROLLER_PORT}  \
    --log-level ${FASTCHAT_LOG_LEVEL} \
    --api-keys ${FASTCHAT_API_KEYS} | tee ./logs/openai_api_server.log &
wait