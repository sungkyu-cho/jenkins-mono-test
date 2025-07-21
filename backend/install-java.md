# Java 17 설치 가이드

## Windows에서 Java 17 설치

### 1. OpenJDK 17 다운로드
- [Adoptium](https://adoptium.net/) 또는 [Oracle](https://www.oracle.com/java/technologies/downloads/#java17)에서 Java 17 다운로드
- Windows x64 Installer 선택

### 2. 설치 과정
1. 다운로드한 설치 파일 실행
2. 설치 경로 확인 (기본: `C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x-hotspot`)
3. "Add to PATH" 옵션 체크
4. 설치 완료

### 3. 환경 변수 설정
시스템 환경 변수에서 다음을 설정:

```
JAVA_HOME = C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x-hotspot
PATH += %JAVA_HOME%\bin
```

### 4. 설치 확인
명령 프롬프트에서:
```cmd
java -version
javac -version
echo %JAVA_HOME%
```

### 5. Gradle Wrapper JAR 다운로드
Gradle Wrapper JAR 파일을 수동으로 다운로드해야 합니다:

1. [Gradle Wrapper JAR](https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar) 다운로드
2. `backend/gradle/wrapper/gradle-wrapper.jar` 위치에 저장

### 6. 권한 설정
Windows에서 실행 권한 설정:
```cmd
cd backend
gradlew.bat --version
```

### 7. 빌드 테스트
```cmd
cd backend
gradlew.bat clean build
```

## 문제 해결

### Java가 인식되지 않는 경우
1. 환경 변수 재설정
2. 명령 프롬프트 재시작
3. 시스템 재부팅

### Gradle Wrapper 오류
1. `gradle-wrapper.jar` 파일 존재 확인
2. 파일 권한 확인
3. 네트워크 연결 확인

### 빌드 오류
1. Java 버전 확인 (Java 17 필요)
2. Gradle 버전 확인
3. 의존성 다운로드 확인 