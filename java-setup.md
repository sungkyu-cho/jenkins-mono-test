# Java 버전 변경 가이드

## Windows에서 Java 버전 변경

### 1. 현재 Java 버전 확인
```cmd
java -version
echo %JAVA_HOME%
```

### 2. Java 17 설치

#### **Adoptium OpenJDK 17 (권장)**
1. [Adoptium 다운로드 페이지](https://adoptium.net/temurin/releases/?version=17) 방문
2. Windows x64 MSI Installer 다운로드
3. 설치 시 "Add to PATH" 옵션 체크
4. 설치 경로 확인 (보통 `C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x-hotspot`)

#### **Oracle JDK 17**
1. [Oracle JDK 다운로드](https://www.oracle.com/java/technologies/downloads/#java17)
2. Windows x64 Installer 다운로드
3. 설치 후 환경 변수 설정

### 3. 환경 변수 설정

#### **시스템 환경 변수 설정**
1. Windows 키 + R → `sysdm.cpl` 입력
2. 고급 탭 → 환경 변수
3. 시스템 변수에서 다음 설정:

```
JAVA_HOME = C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x-hotspot
PATH += %JAVA_HOME%\bin
```

#### **또는 명령 프롬프트에서 임시 설정**
```cmd
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.x.x.x-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
```

### 4. 설치 확인
```cmd
java -version
javac -version
echo %JAVA_HOME%
```

### 5. Gradle Wrapper JAR 다운로드
Java 17 설치 후 Gradle Wrapper JAR 파일이 필요합니다:

1. [Gradle Wrapper JAR](https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar) 다운로드
2. `backend/gradle/wrapper/gradle-wrapper.jar` 위치에 저장

### 6. 빌드 테스트
```cmd
cd backend
gradlew.bat clean build
```

## 문제 해결

### Java가 인식되지 않는 경우
1. 환경 변수 재설정
2. 명령 프롬프트 재시작
3. 시스템 재부팅

### 여러 Java 버전이 설치된 경우
1. `where java` 명령으로 설치된 Java 위치 확인
2. PATH에서 우선순위 조정
3. JAVA_HOME 환경 변수 확인

### Gradle 오류
1. Gradle Wrapper JAR 파일 존재 확인
2. Java 버전 호환성 확인 (Java 17 필요)
3. 네트워크 연결 확인 