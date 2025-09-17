# Custom RunPod ComfyUI Worker
# Start from the latest base image available on Docker Hub
FROM runpod/worker-comfyui:5.4.1-base

# Install custom nodes using comfy-node-install (RunPod's custom CLI)
# RUN comfy-node-install comfyui-kjnodes comfyui-ic-light

# Download WanVideo 2.2 models using comfy model download
# Diffusion models (main T2V models) - these are large ~14B parameter models
# RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp16.safetensors --relative-path models/diffusion_models --filename wan2.2_t2v_high_noise_14B_fp16.safetensors
# RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp16.safetensors --relative-path models/diffusion_models --filename wan2.2_t2v_low_noise_14B_fp16.safetensors

# # VAE model for WanVideo
# RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors --relative-path models/vae --filename Wan2_1_VAE_bf16.safetensors

# # Text encoder for WanVideo
# RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/text_encoders --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors

# # LoRA model for distillation
# RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors --relative-path models/loras --filename Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors

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
