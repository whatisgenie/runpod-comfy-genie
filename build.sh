#!/bin/bash

# Build script for custom RunPod ComfyUI worker
# Make sure to replace 'yourusername' with your actual Docker Hub username

set -e  # Exit on any error

# Configuration
DOCKER_USERNAME="genieremote"
IMAGE_NAME="comfyui-custom"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo "🚀 Building custom RunPod ComfyUI worker..."
echo "Image: ${FULL_IMAGE_NAME}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Build the image
echo "📦 Building Docker image..."
docker build -t "${FULL_IMAGE_NAME}" --platform linux/amd64 .

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    echo "Next steps:"
    echo "1. Push to Docker Hub: docker push ${FULL_IMAGE_NAME}"
    echo "2. Or run locally: docker run -p 8000:8000 ${FULL_IMAGE_NAME}"
    echo "3. Use in RunPod: ${FULL_IMAGE_NAME}"
else
    echo "❌ Build failed!"
    exit 1
fi
