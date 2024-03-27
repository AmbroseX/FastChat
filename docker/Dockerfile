FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-runtime


RUN apt-get update -y && apt-get install -y python3.10 python3.10-distutils curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.10 get-pip.py
RUN pip3 install fschat
RUN pip3 install fschat[model_worker,webui] pydantic==1.10.13