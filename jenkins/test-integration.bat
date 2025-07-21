@echo off
echo 통합 테스트 스크립트
echo ===================

echo.
echo 1. 데이터베이스 컨테이너 시작...
docker-compose up -d database
if %errorlevel% neq 0 (
    echo 데이터베이스 시작 실패!
    exit /b 1
)

echo.
echo 2. 데이터베이스 준비 대기 (30초)...
timeout /t 30 /nobreak

echo.
echo 3. 백엔드 컨테이너 시작...
docker-compose up -d backend
if %errorlevel% neq 0 (
    echo 백엔드 시작 실패!
    docker-compose down
    exit /b 1
)

echo.
echo 4. 백엔드 준비 대기 (30초)...
timeout /t 30 /nobreak

echo.
echo 5. 헬스체크 테스트...
curl -f http://localhost:8080/api/health
if %errorlevel% neq 0 (
    echo 헬스체크 실패!
    docker-compose down
    exit /b 1
)

echo.
echo 6. API 테스트...
curl -f http://localhost:8080/api/users
if %errorlevel% neq 0 (
    echo API 테스트 실패!
    docker-compose down
    exit /b 1
)

echo.
echo 7. 컨테이너 정리...
docker-compose down

echo.
echo 통합 테스트 완료! 