# Custom RunPod ComfyUI Worker Setup

This project demonstrates how to customize the RunPod ComfyUI worker without forking the repository.

## Why No Fork is Needed

Docker's layering system allows you to build on top of existing images:
- **Base Layer**: RunPod's pre-built ComfyUI worker image
- **Your Layer**: Your custom models, nodes, and configurations
- **Result**: A new image that combines both, deployed independently

## Quick Start

### 1. Prepare Your Customizations

#### Add Custom Models
Edit the `Dockerfile` and uncomment/modify the wget commands:
```dockerfile
RUN wget -O models/checkpoints/your_model.safetensors https://your-model-url/your_model.safetensors
```

#### Add Custom Nodes
1. Open ComfyUI locally
2. Install your desired custom nodes
3. Go to "Manager > Snapshot Manager"
4. Click "Save snapshot"
5. Find the `*_snapshot.json` file in `ComfyUI/custom_nodes/ComfyUI-Manager/snapshots/`
6. Copy it to this directory
7. Uncomment and update the COPY line in Dockerfile:
```dockerfile
COPY your_snapshot.json /app/
```

### 2. Build Your Custom Image

```bash
# Build the image (replace with your Docker Hub username)
docker build -t yourusername/comfyui-custom:latest --platform linux/amd64 .

# Push to Docker Hub
docker push yourusername/comfyui-custom:latest
```

### 3. Deploy on RunPod

1. Go to RunPod dashboard
2. Create a new serverless endpoint
3. Use your custom image: `yourusername/comfyui-custom:latest`
4. Configure GPU and other settings as needed

## Available Base Images

- `runpod/worker-comfyui:latest-base` - Clean ComfyUI without models
- `runpod/worker-comfyui:latest-sdxl` - Includes SDXL models
- `runpod/worker-comfyui:latest-sd3` - Includes SD3 models

## Advanced Customization

### Multiple Model Types
```dockerfile
FROM runpod/worker-comfyui:latest-base

# Add multiple models
RUN wget -O models/checkpoints/model1.safetensors https://url1/model1.safetensors
RUN wget -O models/checkpoints/model2.safetensors https://url2/model2.safetensors
RUN wget -O models/loras/lora1.safetensors https://url3/lora1.safetensors
```

### Custom Python Packages
```dockerfile
# Install additional dependencies
RUN pip install transformers accelerate
```

### Environment Variables
```dockerfile
# Set custom environment variables
ENV CUSTOM_VAR=value
```

## Troubleshooting

- **Build fails**: Ensure you're using `--platform linux/amd64` for RunPod compatibility
- **Models not found**: Check that wget URLs are correct and accessible
- **Custom nodes missing**: Verify snapshot file is copied correctly and path is right

## Benefits of This Approach

1. **No Repository Maintenance**: You don't need to keep a fork in sync
2. **Clean Separation**: Your customizations are separate from the base code
3. **Easy Updates**: Pull new base images when RunPod updates them
4. **Flexible Deployment**: Use different base images for different use cases
