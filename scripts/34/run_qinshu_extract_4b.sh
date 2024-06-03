./scripts/stop_worker.sh

export NODE_RANK=2
export NUM_GPUS=1

echo "load Model: worker_34_qinshu_extract" > ./logs/worker_34_qinshu_extract.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22081  \
    --worker-address http://192.168.72.34:22081 \
    --model-path /platform_tech/xiongrongkang/checkpoint/qinshu_extract_all_v4_qwen1_5_4b \
    --model-name "qinshu_extract" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.5 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_34_qinshu_extract.log 2>&1 &