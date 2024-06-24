export version=0.2.9
export docker_name='Qwen1.5-0.5B-Chat'
sudo docker stop ${docker_name} && sudo docker rm ${docker_name}
# sudo docker exec -it fastchat-all /bin/bash
export FASTCHAT_CONTROLLER_PORT=21011
export FASTCHAT_OPENAI_API_PORT=21012
export FASTCHAT_WORKER_PORT=21013
export FASTCHAT_WORKER_MODEL_NAMES=${docker_name}
# export model_path='/platform_tech/models/Qwen1.5-1.8B-Chat'
export model_path='/platform_tech/models/Qwen1.5-0.5B-Chat'
# 模板名称
export FASTCHAT_CONV_TEMPLATE='qwen-7b-chat'
export log_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}
export model_logs_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}

sudo docker run --rm -d --security-opt seccomp:unconfined \
    -e CUDA_VISIBLE_DEVICES=0,1 \
    --gpus all -e NUM_GPUS=2 \
    --cpus="2" \
    -e FASTCHAT_API_KEYS='123456' \
    -p ${FASTCHAT_CONTROLLER_PORT}:22001 \
    -p ${FASTCHAT_OPENAI_API_PORT}:28000 \
    -p ${FASTCHAT_WORKER_PORT}:22002 \
    -e FASTCHAT_WORKER_MODEL_NAMES=${FASTCHAT_WORKER_MODEL_NAMES} \
    -e FASTCHAT_CONV_TEMPLATE=${FASTCHAT_CONV_TEMPLATE} \
    -e GPU_MEMORY_UTILIZATION=0.85 \
    -e MAX_MODEL_LEN=32768 \
    -e LIMIT_WORKER=10 \
    -e USE_WORKER='VLLM_WORKER' \
    -e TZ=Asia/Shanghai \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/timezone:/etc/timezone:ro   \
    -v ${model_path}:/app/models \
    -v ${log_path}:/app/logs \
    -v ${model_logs_path}:/app/model_logs \
    --name ${docker_name} fastchat-all:${version}