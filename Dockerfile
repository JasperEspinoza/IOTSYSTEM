# Use lightweight Node.js base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy application package files
COPY package*.json ./

# Copy all source files
COPY . .

# Expose server port (default 3000 or custom via env)
ENV PORT=3000
EXPOSE 3000

# Start server
CMD ["node", "server.js"]
