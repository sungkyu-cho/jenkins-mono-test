# Jenkins 설정 가이드

이 디렉토리는 Jenkins CI/CD 파이프라인 설정을 포함합니다.

## Windows 환경 설정

### 1. 필수 요구사항
- **Java 22** (SDKMAN을 통해 설치)
- **Node.js** (npm 명령어 사용)
- **Docker Desktop** (Windows용)
- **Git** (Windows용)

### 2. 환경 변수 설정
Windows 시스템 환경 변수에서 다음을 설정:

```
JAVA_HOME = C:\Users\sgc55\.sdkman\candidates\java\current
PATH += %JAVA_HOME%\bin
```

### 3. 배치 스크립트
다음 배치 스크립트들이 포함되어 있습니다:
- `build-frontend.bat` - 프론트엔드 빌드
- `build-backend.bat` - 백엔드 빌드
- `build-docker.bat` - Docker 이미지 빌드
- `test-integration.bat` - 통합 테스트

## Jenkins 파이프라인 구성

### 1. Jenkins 설치 및 설정

1. **Jenkins 설치**
   ```cmd
   # Docker를 사용한 Jenkins 설치
   docker run -d \
     --name jenkins \
     -p 8080:8080 \
     -p 50000:50000 \
     -v jenkins_home:/var/jenkins_home \
     jenkins/jenkins:lts
   ```

2. **필수 플러그인 설치**
   - Pipeline
   - Git
   - Docker
   - Docker Pipeline
   - Blue Ocean

### 2. Jenkins 파이프라인 설정

1. **새로운 Pipeline Job 생성**
   - Jenkins 대시보드 → "새로운 Job" 클릭
   - "Pipeline" 선택
   - Job 이름: "jenkins-mono-pipeline"

2. **Pipeline 설정**
   - Definition: "Pipeline script from SCM"
   - SCM: Git
   - Repository URL: 프로젝트 Git 저장소 URL
   - Script Path: jenkins/Jenkinsfile (Windows용: jenkins/Jenkinsfile.windows)

3. **Windows 환경 설정**
   - Jenkins 노드가 Windows인 경우 Jenkinsfile.windows 사용
   - 환경 변수 설정:
     - JAVA_HOME: C:\Users\sgc55\.sdkman\candidates\java\current
     - PATH: %JAVA_HOME%\bin 추가

### 3. 파이프라인 단계

#### Stage 1: Checkout
- Git 저장소에서 코드 체크아웃

#### Stage 2: Frontend Build & Test
- Vue.js 애플리케이션 빌드
- ESLint 검사
- 단위 테스트 실행
- 프로덕션 빌드
- Windows: `bat` 명령어 사용

#### Stage 3: Backend Build & Test
- Spring Boot 애플리케이션 빌드
- 단위 테스트 실행
- JAR 파일 생성
- Windows: `gradlew.bat` 사용

#### Stage 4: Database Build
- MariaDB Docker 이미지 빌드

#### Stage 5: Frontend Docker Build
- 프론트엔드 Docker 이미지 빌드
- Nginx 기반 프로덕션 이미지

#### Stage 6: Backend Docker Build
- 백엔드 Docker 이미지 빌드
- OpenJDK 22 기반 이미지

#### Stage 7: Integration Test
- 전체 서비스 통합 테스트
- API 헬스체크

#### Stage 8: Deploy
- develop 브랜치: 스테이징 환경 배포
- main 브랜치: 프로덕션 환경 배포

### 4. 환경별 배포 설정

#### 스테이징 환경 (develop 브랜치)
```yaml
# docker-compose.staging.yml
version: '3.8'
services:
  frontend:
    image: jenkins-mono-frontend:${BUILD_NUMBER}
    ports:
      - "3000:80"
  backend:
    image: jenkins-mono-backend:${BUILD_NUMBER}
    ports:
      - "8080:8080"
  database:
    image: jenkins-mono-database:${BUILD_NUMBER}
    ports:
      - "3306:3306"
```

#### 프로덕션 환경 (main 브랜치)
```yaml
# docker-compose.prod.yml
version: '3.8'
services:
  frontend:
    image: jenkins-mono-frontend:${BUILD_NUMBER}
    ports:
      - "80:80"
      - "443:443"
  backend:
    image: jenkins-mono-backend:${BUILD_NUMBER}
    ports:
      - "8080:8080"
  database:
    image: jenkins-mono-database:${BUILD_NUMBER}
    ports:
      - "3306:3306"
```

### 5. Jenkins 웹훅 설정

GitHub/GitLab 웹훅을 설정하여 코드 푸시 시 자동 빌드:

1. **GitHub 웹훅 설정**
   - Repository Settings → Webhooks
   - Payload URL: `http://jenkins-server:8080/github-webhook/`
   - Content type: application/json
   - Events: Just the push event

2. **Jenkins 웹훅 설정**
   - Job 설정 → Build Triggers
   - "GitHub hook trigger for GITScm polling" 체크

### 6. 모니터링 및 알림

#### 빌드 알림 설정
- Slack 알림 플러그인 설치
- 빌드 성공/실패 시 Slack 채널로 알림

#### 모니터링 대시보드
- Blue Ocean 플러그인 사용
- 파이프라인 시각화 및 모니터링

### 7. 보안 설정

#### Jenkins 보안
- Jenkins 관리 → Configure Global Security
- LDAP 또는 GitHub OAuth 인증 설정
- Role-based Authorization Strategy 설정

#### Docker 보안
- Docker 데몬 보안 설정
- 이미지 스캔 도구 통합 (Trivy, Clair)

### 8. 백업 및 복구

#### Jenkins 데이터 백업
```cmd
# Jenkins 홈 디렉토리 백업
tar -czf jenkins_backup.tar.gz /var/jenkins_home
```

#### Docker 이미지 백업
```cmd
# 이미지 저장
docker save jenkins-mono-frontend:latest > frontend.tar
docker save jenkins-mono-backend:latest > backend.tar
docker save jenkins-mono-database:latest > database.tar
```

### 9. 트러블슈팅

#### 일반적인 문제 해결

1. **빌드 실패**
   - 로그 확인: Jenkins → Job → Console Output
   - Docker 이미지 정리: `docker system prune -f`

2. **포트 충돌**
   - 사용 중인 포트 확인: `netstat -tulpn`
   - 포트 변경 또는 프로세스 종료

3. **메모리 부족**
   - Docker 메모리 제한 설정
   - Jenkins JVM 힙 크기 조정

4. **Windows 특화 문제**
   - 경로 문제: 백슬래시(`\`) 사용
   - 권한 문제: 관리자 권한으로 실행
   - 환경 변수: 시스템 환경 변수 설정

### 10. 성능 최적화

#### 빌드 성능 향상
- Docker 레이어 캐싱 활용
- 병렬 빌드 설정
- 빌드 에이전트 확장

#### 리소스 최적화
- 불필요한 Docker 이미지 정리
- Jenkins 워크스페이스 정리
- 로그 로테이션 설정

## 로컬 테스트

### 1. 개별 스크립트 테스트
```cmd
# 프론트엔드 빌드 테스트
jenkins\build-frontend.bat

# 백엔드 빌드 테스트
jenkins\build-backend.bat

# Docker 빌드 테스트
jenkins\build-docker.bat

# 통합 테스트
jenkins\test-integration.bat
```

### 2. 전체 파이프라인 테스트
```cmd
# Jenkins 파이프라인 시뮬레이션
echo "=== Frontend Build ==="
jenkins\build-frontend.bat

echo "=== Backend Build ==="
jenkins\build-backend.bat

echo "=== Docker Build ==="
jenkins\build-docker.bat

echo "=== Integration Test ==="
jenkins\test-integration.bat
``` 