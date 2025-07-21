@echo off
echo Docker 빌드 스크립트
echo ====================

set DOCKER_IMAGE_FRONTEND=jenkins-mono-frontend
set DOCKER_IMAGE_BACKEND=jenkins-mono-backend
set DOCKER_IMAGE_DATABASE=jenkins-mono-database
set DOCKER_TAG=%BUILD_NUMBER%

echo.
echo 1. 데이터베이스 이미지 빌드...
cd database
docker build -t %DOCKER_IMAGE_DATABASE%:%DOCKER_TAG% .
if %errorlevel% neq 0 (
    echo 데이터베이스 이미지 빌드 실패!
    exit /b 1
)
cd ..

echo.
echo 2. 프론트엔드 Dockerfile 생성...
cd frontend
echo FROM node:18-alpine as build > Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY package*.json ./ >> Dockerfile
echo RUN npm ci --only=production >> Dockerfile
echo COPY . . >> Dockerfile
echo RUN npm run build >> Dockerfile
echo. >> Dockerfile
echo FROM nginx:alpine >> Dockerfile
echo COPY --from=build /app/dist /usr/share/nginx/html >> Dockerfile
echo COPY nginx.conf /etc/nginx/nginx.conf >> Dockerfile
echo EXPOSE 80 >> Dockerfile
echo CMD ["nginx", "-g", "daemon off;"] >> Dockerfile

echo.
echo 3. 프론트엔드 이미지 빌드...
docker build -t %DOCKER_IMAGE_FRONTEND%:%DOCKER_TAG% .
if %errorlevel% neq 0 (
    echo 프론트엔드 이미지 빌드 실패!
    exit /b 1
)
cd ..

echo.
echo 4. 백엔드 Dockerfile 생성...
cd backend
echo FROM openjdk:22-jdk-slim > Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY build/libs/app.jar app.jar >> Dockerfile
echo EXPOSE 8080 >> Dockerfile
echo CMD ["java", "-jar", "app.jar"] >> Dockerfile

echo.
echo 5. 백엔드 이미지 빌드...
docker build -t %DOCKER_IMAGE_BACKEND%:%DOCKER_TAG% .
if %errorlevel% neq 0 (
    echo 백엔드 이미지 빌드 실패!
    exit /b 1
)
cd ..

echo.
echo Docker 빌드 완료!
echo 생성된 이미지:
echo - %DOCKER_IMAGE_DATABASE%:%DOCKER_TAG%
echo - %DOCKER_IMAGE_FRONTEND%:%DOCKER_TAG%
echo - %DOCKER_IMAGE_BACKEND%:%DOCKER_TAG% 