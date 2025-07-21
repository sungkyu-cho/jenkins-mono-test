@echo off
echo Java 17 설치 및 설정 스크립트
echo ================================

echo.
echo 1. 현재 Java 버전 확인...
java -version 2>nul
if %errorlevel% neq 0 (
    echo Java가 설치되지 않았습니다.
) else (
    echo Java가 설치되어 있습니다.
)

echo.
echo 2. Java 17 설치 안내...
echo.
echo 다음 단계를 따라 Java 17을 설치하세요:
echo.
echo 1) https://adoptium.net/temurin/releases/?version=17 방문
echo 2) Windows x64 MSI Installer 다운로드
echo 3) 설치 시 "Add to PATH" 옵션 체크
echo 4) 설치 완료 후 이 스크립트를 다시 실행
echo.
pause

echo.
echo 3. 환경 변수 설정 확인...
echo JAVA_HOME: %JAVA_HOME%
echo.

if "%JAVA_HOME%"=="" (
    echo JAVA_HOME이 설정되지 않았습니다.
    echo.
    echo 환경 변수 설정 방법:
    echo 1) Windows 키 + R → sysdm.cpl 입력
    echo 2) 고급 탭 → 환경 변수
    echo 3) 시스템 변수에 JAVA_HOME 추가:
    echo    JAVA_HOME = C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x-hotspot
    echo 4) PATH에 %JAVA_HOME%\bin 추가
    echo.
) else (
    echo JAVA_HOME이 설정되어 있습니다: %JAVA_HOME%
)

echo.
echo 4. Gradle Wrapper JAR 파일 확인...
if exist "backend\gradle\wrapper\gradle-wrapper.jar" (
    echo Gradle Wrapper JAR 파일이 존재합니다.
) else (
    echo Gradle Wrapper JAR 파일이 없습니다.
    echo.
    echo 다음 URL에서 다운로드하여 backend\gradle\wrapper\ 위치에 저장하세요:
    echo https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar
    echo.
)

echo.
echo 5. 빌드 테스트...
cd backend
if exist "gradlew.bat" (
    echo Gradle Wrapper가 존재합니다. 빌드를 시도합니다...
    gradlew.bat --version
    if %errorlevel% equ 0 (
        echo.
        echo 빌드 테스트를 실행합니다...
        gradlew.bat clean build
    ) else (
        echo Gradle 실행에 실패했습니다.
    )
) else (
    echo Gradle Wrapper가 없습니다.
)

echo.
echo 설치 완료!
pause 