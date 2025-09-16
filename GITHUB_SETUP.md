# GitHub Actions Setup for Docker Hub

## 1. Create Docker Hub Access Token

1. Go to [Docker Hub](https://hub.docker.com/)
2. Click your profile → Account Settings → Security
3. Click "New Access Token"
4. Name it: `github-actions-instareal`
5. Copy the token (you won't see it again!)

## 2. Add Secret to GitHub Repository

1. Go to your GitHub repository
2. Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `DOCKER_PASSWORD`
5. Value: Paste your Docker Hub access token
6. Click "Add secret"

## 3. How the Workflow Works

The GitHub Action will automatically:

- **On pushes to `main`**: Build and push with `latest` tag
- **On pushes to `develop`**: Build and push with `develop` tag  
- **On version tags** (e.g., `v1.0.0`): Build and push with version tags
- **On pull requests**: Build only (no push) to test

## 4. Usage

### Automatic builds:
```bash
# This will trigger a build and push to genieremote/comfyui-custom:latest
git add .
git commit -m "Update ComfyUI configuration"
git push origin main
```

### Version releases:
```bash
# This will create genieremote/comfyui-custom:v1.0.0 and genieremote/comfyui-custom:1.0
git tag v1.0.0
git push origin v1.0.0
```

## 5. Monitor Builds

- Go to your repo → Actions tab
- Watch the build progress
- Check for any errors in the logs

## 6. Clean Up Local Scripts

Once GitHub Actions is working, you can:
- Keep `build.sh` for local development/testing
- Remove or archive `deploy.sh` (no longer needed)
- Update your workflow to use GitHub Actions instead
