sudo docker run -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    --cpus="10" --memory="10g" -p 22001:22001 -p 28000:28000 \
    -e TZ=Asia/Shanghai \
    -e FASTCHAT_CONTROLLER_ADDRESS='0.0.0.0' \
    -e FASTCHAT_API_KEYS='123456' \
    -v /platform_tech/xiongrongkang/FastChat/logs:/app/logs \
    -v /platform_tech/xiongrongkang/FastChat/model_logs:/app/model_logs \
    --name fastchat-controller fastchat-controller:0.1