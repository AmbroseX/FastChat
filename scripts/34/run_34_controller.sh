#!/bin/bash
# ./scripts/stop_worker.sh
./scripts/stop_controller.sh

# 启动controller
nohup python3 -m fastchat.serve.controller \
    --host 0.0.0.0 --port 22001 \
    > /platform_tech/logs/controller.log 2>&1 &


# 启动openai_api_server
nohup python3 -m fastchat.serve.openai_api_server \
    --host 192.168.72.34 --port 28000 \
    --controller-address http://192.168.72.34:22001  \
    --api-keys "123456" \
    --log-level debug \
    > /platform_tech/logs/openai_api_server.log 2>&1 &


# nohup python3 -m fastchat.serve.gradio_web_server \
#     --host 192.168.72.34 --port 8001 \
#     --controller-url http://192.168.72.34:22001 \
#     --concurrency-count 150 \
#     > ./logs/gradio_web_server.log 2>&1 &

