@echo off
echo 프론트엔드 빌드 스크립트
echo ======================

cd frontend

echo.
echo 1. 의존성 설치...
call npm install
if %errorlevel% neq 0 (
    echo npm install 실패!
    exit /b 1
)

echo.
echo 2. 린트 검사...
call npm run lint
if %errorlevel% neq 0 (
    echo 린트 검사에 경고가 있지만 계속 진행합니다...
)

echo.
echo 3. 테스트 실행...
call npm run test
if %errorlevel% neq 0 (
    echo 테스트 실패!
    exit /b 1
)

echo.
echo 4. 빌드 실행...
call npm run build
if %errorlevel% neq 0 (
    echo 빌드 실패!
    exit /b 1
)

echo.
echo 프론트엔드 빌드 완료!
cd .. 