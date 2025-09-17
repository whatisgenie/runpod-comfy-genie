# Custom RunPod ComfyUI Worker
# Start from the latest base image available on Docker Hub
FROM runpod/worker-comfyui:5.4.1-base

# Install custom nodes using comfy-node-install (RunPod's custom CLI)
# RUN comfy-node-install comfyui-kjnodes comfyui-ic-light
RUN pip install -U "huggingface_hub[cli]"

RUN hf auth login --token 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

RUN hf download Kijai/WanVideo_comfy Wan2_1_VAE_bf16.safetensors --local-dir models/vae

RUN hf download Kijai/WanVideo_comfy Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors --local-dir models/loras

RUN hf download Comfy-Org/Wan_2.1_ComfyUI_repackaged umt5_xxl_fp8_e4m3fn_scaled.safetensors --local-dir models/text_encoders

RUN hf download Comfy-Org/Wan_2.2_ComfyUI_Repackaged wan2.2_t2v_high_noise_14B_fp16.safetensors wan2.2_t2v_low_noise_14B_fp16.safetensors --local-dir models/diffusion_models

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
