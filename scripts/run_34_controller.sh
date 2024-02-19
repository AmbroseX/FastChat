#!/bin/bash
./scripts/stop_worker.sh
./scripts/stop_controller.sh

# 启动controller
nohup python3 ./fastchat/serve/controller.py \
    --host 0.0.0.0 --port 22001 \
    > ./logs/controller.log 2>&1 &


# 启动openai_api_server
nohup python3 ./fastchat/serve/openai_api_server.py \
    --host 192.168.80.34 --port 28000 \
    --controller-address http://192.168.80.34:22001  \
    --api-keys "123456" \
    > ./logs/openai_api_server.log 2>&1 &


nohup python3 ./fastchat/serve/gradio_web_server.py \
    --host 192.168.80.34 --port 8001 \
    --controller-url http://192.168.80.34:22001 \
    --concurrency-count 150 \
    > ./logs/gradio_web_server.log 2>&1 &

