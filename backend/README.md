# Backend - Spring Boot

이 디렉토리는 Spring Boot 3.x와 Java 17을 사용한 백엔드 애플리케이션을 포함합니다.

## 기술 스택

- **Spring Boot 3.1.5** - Java 기반 웹 프레임워크
- **Java 17** - 최신 LTS 버전
- **Spring Data JPA** - 데이터 접근 계층
- **Spring Security** - 보안 및 인증
- **MariaDB** - 관계형 데이터베이스
- **Gradle** - 빌드 도구
- **Lombok** - 보일러플레이트 코드 감소

## 개발 환경 설정

### 1. 필수 요구사항
- Java 17 이상
- Gradle 7.x 이상
- MariaDB 10.11 이상

### 2. 개발 서버 실행
```bash
./gradlew bootRun
```
- URL: http://localhost:8080
- Actuator: http://localhost:8080/actuator

### 3. 빌드
```bash
./gradlew build
```
- JAR 파일 생성: `build/libs/app.jar`

### 4. 테스트
```bash
./gradlew test
```
- JUnit 5를 사용한 단위 테스트

### 5. 애플리케이션 실행
```bash
java -jar build/libs/app.jar
```

## 프로젝트 구조

```
backend/
├── src/
│   ├── main/
│   │   ├── java/com/jenkinsmono/
│   │   │   ├── controller/    # REST API 컨트롤러
│   │   │   ├── model/         # 엔티티 모델
│   │   │   ├── repository/    # 데이터 접근 계층
│   │   │   ├── service/       # 비즈니스 로직
│   │   │   ├── config/        # 설정 클래스
│   │   │   └── BackendApplication.java
│   │   └── resources/
│   │       └── application.yml
│   └── test/
│       └── java/com/jenkinsmono/
├── build.gradle
└── gradle/
```

## API 엔드포인트

### 1. 헬스체크
- `GET /api/health` - 서비스 상태 확인

### 2. 사용자 관리
- `GET /api/users` - 사용자 목록 조회
- `GET /api/users/{id}` - 특정 사용자 조회
- `POST /api/users` - 사용자 생성
- `PUT /api/users/{id}` - 사용자 수정
- `DELETE /api/users/{id}` - 사용자 삭제
- `GET /api/users/count` - 사용자 수 조회

### 3. 테스트 엔드포인트
- `GET /api/test/database` - 데이터베이스 연결 테스트
- `GET /api/test/jpa` - JPA 동작 테스트

### 4. Actuator 엔드포인트
- `GET /actuator/health` - 헬스체크
- `GET /actuator/info` - 애플리케이션 정보
- `GET /actuator/metrics` - 메트릭 정보

## 데이터베이스 설정

### 1. MariaDB 연결
```yaml
spring:
  datasource:
    url: jdbc:mariadb://localhost:3306/jenkins_mono
    username: root
    password: password
    driver-class-name: org.mariadb.jdbc.Driver
```

### 2. JPA 설정
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MariaDBDialect
```

## 보안 설정

### 1. CORS 설정
- 모든 오리진 허용 (개발 환경)
- API 엔드포인트에 대한 CORS 헤더 설정

### 2. Spring Security
- 기본 인증 사용
- API 엔드포인트 접근 허용
- CSRF 비활성화 (API 서버)

## Docker 배포

### 1. Docker 이미지 빌드
```bash
docker build -t jenkins-mono-backend .
```

### 2. 컨테이너 실행
```bash
docker run -p 8080:8080 jenkins-mono-backend
```

### 3. Docker Compose 사용
```bash
docker-compose up backend
```

## 환경별 설정

### 1. 개발 환경 (dev)
```yaml
spring:
  profiles:
    active: dev
  jpa:
    show-sql: true
```

### 2. 프로덕션 환경 (prod)
```yaml
spring:
  profiles:
    active: prod
  jpa:
    show-sql: false
```

## 모니터링 및 로깅

### 1. Actuator 엔드포인트
- 헬스체크: `/actuator/health`
- 메트릭: `/actuator/metrics`
- 환경 정보: `/actuator/env`

### 2. 로깅 설정
```yaml
logging:
  level:
    com.jenkinsmono: DEBUG
    org.springframework.security: DEBUG
    org.hibernate.SQL: DEBUG
```

## 테스트 전략

### 1. 단위 테스트
- 컨트롤러 테스트
- 서비스 테스트
- 리포지토리 테스트

### 2. 통합 테스트
- API 엔드포인트 테스트
- 데이터베이스 통합 테스트

### 3. 테스트 실행
```bash
# 전체 테스트
./gradlew test

# 특정 테스트 클래스
./gradlew test --tests UserControllerTest

# 테스트 리포트 생성
./gradlew test jacocoTestReport
```

## 성능 최적화

### 1. 데이터베이스 최적화
- 인덱스 생성
- 쿼리 최적화
- 연결 풀 설정

### 2. 애플리케이션 최적화
- JVM 힙 크기 조정
- GC 설정 최적화
- 캐싱 전략

### 3. 모니터링
- Micrometer 메트릭 수집
- Prometheus 연동
- Grafana 대시보드

## 배포 체크리스트

- [ ] 빌드 성공 확인
- [ ] 테스트 통과 확인
- [ ] 데이터베이스 연결 확인
- [ ] API 엔드포인트 동작 확인
- [ ] 보안 설정 확인
- [ ] 로깅 설정 확인
- [ ] 모니터링 설정 확인
- [ ] 성능 테스트 완료 