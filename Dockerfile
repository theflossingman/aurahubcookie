# Use Node.js 18 LTS as base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install dependencies for Sharp image processing
RUN apk add --no-cache \
    vips-dev \
    vips \
    pkgconfig \
    gcc \
    g++ \
    make \
    python3

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Create data directory for persistence
RUN mkdir -p /app/data/uploads/shorts

# Copy application files
COPY . .

# Create uploads directory with proper permissions
RUN mkdir -p /app/uploads/shorts && \
    chown -R node:node /app/data /app/uploads

# Switch to non-root user
USER node

# Expose port
EXPOSE 3067

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3067/api/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) })" || exit 1

# Start the application
CMD ["npm", "start"]
