# Custom RunPod ComfyUI Worker
# Start from the latest base image available on Docker Hub
FROM runpod/worker-comfyui:5.4.1-base

# Install custom nodes using comfy-node-install (RunPod's custom CLI)
RUN comfy-node-install comfyui-kjnodes comfyui-ic-light

# Download SDXL models using comfy model download with proper parameters
RUN comfy model download --url https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors --relative-path models/checkpoints --filename sd_xl_base_1.0.safetensors
RUN comfy model download --url https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors --relative-path models/checkpoints --filename sd_xl_refiner_1.0.safetensors

# Add custom nodes via snapshot
# 1. Create a snapshot in ComfyUI Manager: Manager > Snapshot Manager > Save snapshot
# 2. Copy the snapshot.json file to this directory
# 3. Uncomment the line below:
# COPY your_snapshot.json /app/

# Install additional Python packages if needed
# RUN pip install your-custom-package

# Set working directory
WORKDIR /workspace

# The base image already handles the rest!
