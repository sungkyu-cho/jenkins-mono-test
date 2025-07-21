# JDK 22 사용 설정 가이드

## 현재 상황
- SDKMAN을 통해 JDK 22가 설치되어 있음
- Spring Boot 3.x는 Java 17 이상을 지원하므로 JDK 22 사용 가능

## 설정 방법

### 1. 환경 변수 설정
```bash
export JAVA_HOME=~/.sdkman/candidates/java/current
export PATH=$JAVA_HOME/bin:$PATH
```

### 2. Java 버전 확인
```bash
java -version
javac -version
echo $JAVA_HOME
```

### 3. Gradle Wrapper JAR 파일 다운로드
Gradle Wrapper JAR 파일이 필요합니다. 다음 중 하나의 방법을 사용하세요:

#### 방법 1: 브라우저에서 다운로드
1. https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar 방문
2. 파일을 `backend/gradle/wrapper/gradle-wrapper.jar` 위치에 저장

#### 방법 2: PowerShell 사용
```powershell
Invoke-WebRequest -Uri "https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar" -OutFile "backend/gradle/wrapper/gradle-wrapper.jar"
```

#### 방법 3: Git Bash에서 curl 사용
```bash
curl -L -o backend/gradle/wrapper/gradle-wrapper.jar https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar
```

### 4. 빌드 테스트
```bash
cd backend
export JAVA_HOME=~/.sdkman/candidates/java/current
export PATH=$JAVA_HOME/bin:$PATH
./gradlew --version
./gradlew clean build
```

## 문제 해결

### Java 버전 문제
- JDK 22는 Spring Boot 3.x와 호환됩니다
- build.gradle에서 sourceCompatibility를 '22'로 설정했습니다

### Gradle Wrapper 문제
- gradle-wrapper.jar 파일이 0바이트인 경우 다시 다운로드
- 파일 권한 확인

### 빌드 오류
- Java 환경 변수 확인
- Gradle 버전 호환성 확인
- 의존성 다운로드 확인

## 확인 사항
- [ ] JAVA_HOME이 올바르게 설정됨
- [ ] Java 22가 인식됨
- [ ] gradle-wrapper.jar 파일이 존재함
- [ ] 빌드가 성공함 