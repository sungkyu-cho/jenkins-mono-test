@echo off
echo 백엔드 빌드 스크립트
echo ===================

cd backend

echo.
echo 1. Java 환경 확인...
java -version
if %errorlevel% neq 0 (
    echo Java가 설치되지 않았습니다!
    exit /b 1
)

echo.
echo 2. Gradle Wrapper 확인...
if not exist "gradlew.bat" (
    echo Gradle Wrapper가 없습니다!
    exit /b 1
)

echo.
echo 3. Gradle 버전 확인...
call gradlew.bat --version
if %errorlevel% neq 0 (
    echo Gradle 실행 실패!
    exit /b 1
)

echo.
echo 4. 빌드 실행...
set GRADLE_USER_HOME=%CD%
call gradlew.bat clean build
if %errorlevel% neq 0 (
    echo 빌드 실패!
    exit /b 1
)

echo.
echo 5. 테스트 실행...
call gradlew.bat test
if %errorlevel% neq 0 (
    echo 테스트 실패!
    exit /b 1
)

echo.
echo 백엔드 빌드 완료!
cd .. 