# 빌드 스테이지
FROM node:18 AS builder
WORKDIR /app

# package.json과 lock만 먼저 복사
COPY package*.json ./

# 여기서 Linux 기준으로 설치
RUN npm ci --legacy-peer-deps

# 나머지 소스 복사
COPY . .

# 빌드 실행
RUN npm run build

# 런타임 스테이지
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html