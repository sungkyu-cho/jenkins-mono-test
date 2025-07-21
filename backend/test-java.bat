@echo off
echo Java 환경 테스트
echo =================

echo.
echo 1. Java 버전 확인...
java -version

echo.
echo 2. Java 컴파일 테스트...
javac TestJava.java
if %errorlevel% equ 0 (
    echo 컴파일 성공!
    echo.
    echo 3. Java 실행 테스트...
    java TestJava
) else (
    echo 컴파일 실패!
)

echo.
echo 4. Gradle Wrapper 테스트...
if exist gradlew.bat (
    echo Gradle Wrapper 배치 파일 존재
    gradlew.bat --version
) else (
    echo Gradle Wrapper 배치 파일 없음
)

echo.
echo 테스트 완료!
pause 