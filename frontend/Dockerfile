# 빌드 스테이지
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# 런타임 스테이지
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
