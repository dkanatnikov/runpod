#!/bin/bash

export PYTHONUNBUFFERED=1
source /venv/bin/activate
rsync -au --remove-source-files /ComfyUI/ /workspace/ComfyUI/
ln -s /comfy-models/flux1-dev-fp8.safetensors /workspace/ComfyUI/models/unet/flux1-dev-fp8.safetensors
ln -s /comfy-models/t5xxl_fp8_e4m3fn.safetensors /workspace/ComfyUI/models/clip/t5xxl_fp8_e4m3fn.safetensors
ln -s /comfy-models/clip_l.safetensors /workspace/ComfyUI/models/clip/clip_l.safetensors
ln -s /comfy-models/ae.safetensors /workspace/ComfyUI/models/vae/ae.safetensors

cd /workspace/ComfyUI
python main.py --listen --port 3000 &