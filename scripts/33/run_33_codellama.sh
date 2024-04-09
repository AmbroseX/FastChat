#!/bin/bash

# 定义要查找和终止的进程名称
process_names=(
    "CodeLlama-7b-Python-hf" \
    "CodeLlama-7b-Instruct-hf")

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
            kill -9 $pid
        done
    fi
done

echo "所有指定进程已处理完毕。"


echo "load Model: CodeLlama-7b-Python-hf" > ./logs/worker_CodeLlama-7b-Python-hf.log
nohup env CUDA_VISIBLE_DEVICES=0 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.80.33 --port 22014  \
    --worker-address http://192.168.80.33:22014 \
    --model-path /platform_tech/models/CodeLlama-7b-Python-hf \
    --model-name "CodeLlama-7b-Python-hf" \
    --num-gpus 1 \
    --tensor-parallel-size 1 \
    --gpu_memory_utilization 0.6 \
    --max-model-len 2048 \
    --worker-use-ray \
    --tokenizer-mode "auto" \
    --enforce-eager \
    --limit-worker-concurrency 10 \
    >> ./logs/worker_CodeLlama-7b-Python-hf.log 2>&1 &

echo "load Model: CodeLlama-7b-Instruct-hf" > ./logs/worker_CodeLlama-7b-Instruct-hf.log
nohup env CUDA_VISIBLE_DEVICES=1 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.80.33 --port 22015  \
    --worker-address http://192.168.80.33:22015 \
    --model-path /platform_tech/models/CodeLlama-7b-Instruct-hf \
    --model-name "CodeLlama-7b-Instruct-hf" \
    --num-gpus 1 \
    --tensor-parallel-size 1 \
    --gpu_memory_utilization 0.6 \
    --max-model-len 2048 \
    --worker-use-ray \
    --tokenizer-mode "auto" \
    --enforce-eager \
    --limit-worker-concurrency 10 \
    >> ./logs/worker_CodeLlama-7b-Instruct-hf.log 2>&1 &


# python -m fastchat.serve.model_worker --model-names "codellama-34b-instruct,gpt-3.5-turbo,gpt-3.5-turbo-16k,gpt-4,gpt-4-32k,text-davinci-003" --model-path codellama/CodeLlama-7b-Instruct-hf
# nohup env CUDA_VISIBLE_DEVICES=1 torchrun --nproc_per_node 1 ./llamacpp_mock_api.py \
#     --ckpt_dir /platform_tech/models/CodeLlama-7b-Python-hf/ \
#     --tokenizer_path /platform_tech/models/CodeLlama-7b-Python-hf/tokenizer.model \
#     --max_seq_len 1024 --max_batch_size 10\
#     > llamacpp_mock_api.log 2>&1 &