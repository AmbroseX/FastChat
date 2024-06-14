#!/bin/bash
pip config set global.progress_bar off
mkdir -p ./logs
mkdir -p ./model_logs

# 启动controller
python3 ./fastchat/serve/controller.py \
    --host ${FASTCHAT_CONTROLLER_ADDRESS} \
    --port ${FASTCHAT_CONTROLLER_PORT} \
    --log-level ${FASTCHAT_LOG_LEVEL}  | tee ./logs/controller.log &