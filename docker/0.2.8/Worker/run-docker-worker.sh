export version=0.2.8
export docker_name='qinshu-all-in-one'
sudo docker stop ${docker_name} && sudo docker rm ${docker_name}
# Controller地址
export FASTCHAT_CONTROLLER_ADDRESS='192.168.72.34'
export FASTCHAT_CONTROLLER_PORT=22001
export FASTCHAT_OPENAI_API_PORT=28000

# worker端口
export FASTCHAT_WORKER_ADDRESS='192.168.190.79'
export FASTCHAT_WORKER_PORT=24002
export FASTCHAT_WORKER_MODEL_NAMES=${docker_name}
# 模板名称
export FASTCHAT_CONV_TEMPLATE='qwen-7b-chat'
# log地址
export log_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}
export model_logs_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}

export model_path='/platform_tech/xiongrongkang/checkpoint/qinshu/qwen14b_mulu_0530_add_special_token_all_in_one_12000/test_model_1700'

sudo docker run --rm -d --security-opt seccomp:unconfined \
    -e CUDA_VISIBLE_DEVICES=2,3 \
    --gpus all -e NUM_GPUS=2 \
    --cpus="2" \
    -e FASTCHAT_API_KEYS='123456' \
    -e FASTCHAT_CONTROLLER_ADDRESS=${FASTCHAT_CONTROLLER_ADDRESS} \
    -e FASTCHAT_CONTROLLER_PORT=${FASTCHAT_CONTROLLER_PORT} \
    -e FASTCHAT_OPENAI_API_PORT=${FASTCHAT_OPENAI_API_PORT} \
    -p ${FASTCHAT_WORKER_PORT}:22002 \
    -e FASTCHAT_WORKER_MODEL_NAMES=${FASTCHAT_WORKER_MODEL_NAMES} \
    -e FASTCHAT_CONV_TEMPLATE=${FASTCHAT_CONV_TEMPLATE} \
    -e GPU_MEMORY_UTILIZATION=0.95 \
    -e MAX_MODEL_LEN=16384 \
    -e LIMIT_WORKER=20 \
    -e USE_WORKER='VLLM_WORKER' \
    -v /etc/localtime:/etc/localtime:ro \
    -v ${model_path}:/app/models \
    -v ${log_path}:/app/logs \
    -v ${model_logs_path}:/app/model_logs \
    --network="host" \
    --name ${docker_name} fastchat-worker:${version}