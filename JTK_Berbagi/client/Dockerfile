FROM node:20-alpine

WORKDIR /app

# Install dependencies, gunakan file cache jika tidak ada perubahan dependency
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps

# Copy seluruh source code
COPY . .

# Build production app
RUN npm run build

# Untuk dev: expose port dan start dev server
EXPOSE 3000
CMD ["npm", "start"]
