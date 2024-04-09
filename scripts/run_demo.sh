./scripts/stop_worker.sh

export name=20240404_qinshu_step1_qwen1_5_1.8b
OUTPUT=/platform_tech/xiongrongkang/checkpoint/${name}
export NODE_RANK=0
export NUM_GPUS=1

echo "load Model: worker_79_demo" > ./logs/worker_79_demo.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22079  \
    --worker-address http://192.168.190.79:22079 \
    --model-path /platform_tech/xiongrongkang/checkpoint/20240405_xinwen_qwen1_5_1.8b/checkpoint-2800/  \
    --model-name "demo_model" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.85 \
    --max-model-len 8192 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_demo.log 2>&1 &