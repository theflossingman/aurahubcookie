# Docker Setup Guide for Aura Hub

## Prerequisites
1. Install Docker Desktop from https://www.docker.com/products/docker-desktop
2. Start Docker Desktop after installation
3. Verify Docker is working by running: `docker --version`

## Docker Workflow Commands

### Build and Run with Docker Compose (Recommended)
```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down

# Rebuild and restart
docker-compose up -d --build
```

### Individual Docker Commands
```bash
# Build the image
docker build -t aura-os .

# Run the container
docker run -p 3067:3067 --name aura-os -v ./data:/app/data -v ./uploads:/app/uploads aura-os

# View logs
docker logs -f aura-os

# Stop and remove container
docker stop aura-os && docker rm aura-os
```

### NPM Scripts (Already configured in package.json)
```bash
# Build Docker image
npm run docker:build

# Run Docker container
npm run docker:run

# Use Docker Compose
npm run docker:compose

# Stop Docker Compose
npm run docker:stop

# View Docker Compose logs
npm run docker:logs

# Clean up Docker system
npm run docker:clean
```

## Accessing the Application

Once running, access your Aura Hub at:
- Local: http://localhost:3067
- Network: http://YOUR_IP_ADDRESS:3067

## Data Persistence

The Docker setup includes persistent volumes:
- `./data` - Application data (aura, coins, posts, etc.)
- `./uploads` - User uploaded files (shorts videos)

## Troubleshooting

### Port Already in Use
```bash
# Check what's using port 3067
netstat -ano | findstr :3067

# Stop the service or change the port in docker-compose.yml
```

### Permission Issues
```bash
# On Windows, make sure Docker Desktop is running with proper permissions
# Restart Docker Desktop if needed
```

### Build Issues
```bash
# Clean build
docker-compose down
docker system prune -f
docker-compose up -d --build
```

### Container Won't Start
```bash
# Check logs
docker-compose logs aura-os

# Check container status
docker-compose ps
```

## Health Checks

The container includes health checks that monitor:
- Application responsiveness
- API endpoint availability
- Container uptime

Health status can be checked with:
```bash
docker-compose ps
```

## Environment Variables

The Docker container uses these environment variables:
- `NODE_ENV=production` - Production mode
- `PORT=3067` - Application port

## Security Notes

- The container runs as a non-root user (`node`)
- Only necessary ports are exposed
- Volume mounts are restricted to data directories
- Health checks ensure service availability
