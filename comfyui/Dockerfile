FROM nvidia/cuda:11.8.0-base-ubuntu22.04 as runtime


SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set working directory and environment variables
ENV SHELL=/bin/bash
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Set up system
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends git wget curl bash libgl1 software-properties-common openssh-server nginx rsync && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install python3.10-dev python3.10-venv -y --no-install-recommends && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
    rm /usr/bin/python3 && \
    ln -s /usr/bin/python3.10 /usr/bin/python3 && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py

RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install ComfyUI and ComfyUI Manager
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd /ComfyUI && \
    pip install -r requirements.txt && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager && \
    cd custom_nodes/ComfyUI-Manager && \
    pip install -r requirements.txt

RUN mkdir /comfy-models
RUN wget https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-dev-fp8.safetensors -O /comfy-models/flux1-dev-fp8.safetensors && \
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors -O /comfy-models/t5xxl_fp8_e4m3fn.safetensors && \
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors -O /comfy-models/clip_l.safetensors && \
    wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -O /comfy-models/ae.safetensors

COPY pre_start.sh /pre_start.sh