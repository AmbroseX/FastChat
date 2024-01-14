#!/bin/bash

# 定义要查找和终止的进程名称
process_names=("./fastchat/serve/controller.py" \ 
    "./fastchat/serve/model_worker.py" \
    "./fastchat/serve/openai_api_server.py" \
    "./fastchat/serve/gradio_web_server.py" \
    "./fastchat/serve/vllm_worker.py")

# 遍历每个进程名称
for name in "${process_names[@]}"; do
    echo "正在查找和终止所有相关的 $name 进程..."

    # 使用 pgrep 查找所有匹配的进程 ID
    pids=$(pgrep -f $name)

    # 检查是否找到了进程 ID
    if [ -z "$pids" ]; then
        echo "没有找到与 $name 相关的进程。"
    else
        # 遍历并终止每个找到的进程
        for pid in $pids; do
            echo "终止进程 $pid (属于 $name)"
            kill $pid
        done
    fi
done

echo "所有指定进程已处理完毕。"