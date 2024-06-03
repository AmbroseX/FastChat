# ./scripts/stop_worker.sh

export NODE_RANK=1,2
export NUM_GPUS=2
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu-all-in-one" > /platform_tech/logs/worker_qinshu-all-in-one.log
# '/platform_tech/readpaper-models/paper-gpt/20240428-llm-qwen-catalog-eval'
# /platform_tech/sunshuanglong/outputs/qwen14b_12000_mulu_0425/global_step12_merge
# /platform_tech/readpaper-models/paper-gpt/20240517-llm-qwen-catalog-eval-v2 \
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22085  \
    --worker-address http://192.168.72.34:22085 \
    --model-path  /platform_tech/xiongrongkang/checkpoint/qinshu/qwen14b_mulu_0530_add_special_token_all_in_one_12000/test_model_1700 \
    --model-name "qinshu-all-in-one" \
    --conv-template qwen-7b-chat \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.65 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> /platform_tech/logs/worker_qinshu-all-in-one.log 2>&1 &