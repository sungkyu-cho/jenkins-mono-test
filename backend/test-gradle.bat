@echo off
echo Gradle Wrapper 테스트
echo ===================

echo.
echo 1. 환경 변수 설정...
set GRADLE_USER_HOME=C:\gradle-home
echo GRADLE_USER_HOME: %GRADLE_USER_HOME%

echo.
echo 2. Java 버전 확인...
java -version

echo.
echo 3. Gradle Wrapper 버전 확인...
gradlew.bat --version

echo.
echo 4. 빌드 테스트...
gradlew.bat clean build

echo.
echo 테스트 완료! 