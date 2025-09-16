#!/bin/bash

# Deploy script for custom RunPod ComfyUI worker
# This builds and pushes your image to Docker Hub

set -e  # Exit on any error

# Configuration
DOCKER_USERNAME="genieremote"
IMAGE_NAME="comfyui-custom"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo "🚀 Building and deploying custom RunPod ComfyUI worker..."
echo "Image: ${FULL_IMAGE_NAME}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if user is logged into Docker Hub
if ! docker info | grep -q "Username"; then
    echo "⚠️  You might not be logged into Docker Hub."
    echo "Run: docker login"
    echo "Then try again."
    echo ""
fi

# Build the image
echo "📦 Building Docker image..."
docker build -t "${FULL_IMAGE_NAME}" --platform linux/amd64 .

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

echo "✅ Build successful!"
echo ""

# Push to Docker Hub
echo "🔄 Pushing to Docker Hub..."
docker push "${FULL_IMAGE_NAME}"

if [ $? -eq 0 ]; then
    echo "✅ Deploy successful!"
    echo ""
    echo "🎉 Your custom ComfyUI worker is now available at:"
    echo "   ${FULL_IMAGE_NAME}"
    echo ""
    echo "📋 To use in RunPod:"
    echo "   1. Go to RunPod dashboard"
    echo "   2. Create new serverless endpoint"
    echo "   3. Use image: ${FULL_IMAGE_NAME}"
    echo "   4. Set GPU type (recommend RTX 4090 or A100)"
    echo "   5. Deploy!"
else
    echo "❌ Push failed! Make sure you're logged into Docker Hub."
    echo "Run: docker login"
    exit 1
fi
