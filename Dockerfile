# Stage 1: Build stage
FROM node:20 AS build

# Set working directory
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./ 

# Install dependencies
RUN npm install

# Copy seluruh kode aplikasi
COPY . .

# Build aplikasi NestJS
RUN npm run build

# Stage 2: Production stage
FROM node:20-slim AS production

# Set working directory
WORKDIR /app

# Copy hanya build dari stage sebelumnya
COPY --from=build /app/dist ./dist

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies untuk production
RUN npm install --only=production

# Expose port yang digunakan aplikasi (default NestJS di port 3000)
EXPOSE 3000

# Jalankan aplikasi
CMD ["npm", "run", "start:prod"]
