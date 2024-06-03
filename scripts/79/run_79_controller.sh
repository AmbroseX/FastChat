#!/bin/bash
./scripts/stop_controller.sh

# 启动controller
nohup python3 -m fastchat.serve.controller \
    --host 0.0.0.0 --port 23001 \
    > ./logs/controller.log 2>&1 &


# 启动openai_api_server
nohup python3 -m fastchat.serve.openai_api_server \
    --controller-address http://192.168.190.79:23001  \
    --host 192.168.190.79 --port 29000 \
    --api-keys "123456" \
    --log-level debug \
    > ./logs/openai_api_server.log 2>&1 &

