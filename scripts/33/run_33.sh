#!/bin/bash
./scripts/stop_worker.sh


# CodeLlama
# ./scripts/run_33_codellama.sh
# # CodeLlama-7b-Python-hf
## GPU 0, port 22014
## CodeLlama-7b-Instruct-hf
## GPU 1, port 22015


# # internlm2
# ./scripts/run_33_internlm2.sh
# # internlm2-chat-7b
# # GPU 2, port: 22011
# # internlm2-chat-20b
# # GPU 2, port: 22012

# Baichuan
# ./scripts/run_33_baicuan.sh
# Baichuan2-7B-Chat
# GPU 3, port: 22004
# Baichuan2-13B-Chat
# GPU 3, port: 2200


# # Qwen
./scripts/run_33_qwen.sh
# # Qwen-1_8B-Chat
# # GPU 3,
# # Qwen-7B-Chat
# # GPU 4
# # Qwen-14B-Chat
# # GPU 4
# # Qwen-72B-Chat
# # GPU 6,7

# # ChatGLM
# ./scripts/run_33_chatglm.sh
# # chatglm3-6b
# # GPU 5, port: 22005
# # chatglm3-6b-32k
# # GPU 5, port: 22006



# Yi-34B-200K
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --host 192.168.80.34 --port 22003 --worker http://192.168.80.34:22003 --controller-address http://192.168.80.34:22001   --max-gpu-memory '80Gib' > ./logs/worker.log 2>&1 &

# # # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=6,7 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.80.34:22001 \
#     --host 192.168.80.34 --port 22005  \
#     --worker-address http://192.168.80.34:22005 \
#     --model-path /platform_tech/models/Yi-34B-200K \
#     --model-name "Yi-34B-200K" \
#     --num-gpus 2 \
#     --gpu_memory_utilization 0.95 \
#     --max-model-len 200000 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker.log 2>&1 &





