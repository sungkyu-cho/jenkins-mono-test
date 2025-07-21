@echo off
echo Gradle Wrapper 테스트
echo ===================

echo.
echo 1. 환경 변수 설정...
set GRADLE_USER_HOME=C:\gradle-home
echo GRADLE_USER_HOME: %GRADLE_USER_HOME%

echo.
echo 2. 디렉토리 생성...
if not exist "C:\gradle-home" mkdir "C:\gradle-home"
if not exist "C:\gradle-home\wrapper" mkdir "C:\gradle-home\wrapper"
if not exist "C:\gradle-home\wrapper\dists" mkdir "C:\gradle-home\wrapper\dists"

echo.
echo 3. Java 버전 확인...
java -version

echo.
echo 4. Gradle Wrapper 버전 확인...
gradlew.bat --version

echo.
echo 5. 빌드 테스트...
gradlew.bat clean build

echo.
echo 테스트 완료! 