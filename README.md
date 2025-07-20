# Jenkins Mono Repository

이 프로젝트는 Vue.js 프론트엔드, Spring Boot 백엔드, MariaDB 데이터베이스를 포함한 모노레포 구조입니다.

## 프로젝트 구조

```
jenkins-mono/
├── frontend/          # Vue.js + Vite 프론트엔드
├── backend/           # Spring Boot 백엔드
├── database/          # MariaDB Docker 설정
├── jenkins/           # Jenkins 파이프라인 설정
└── docker-compose.yml # 전체 서비스 오케스트레이션
```

## 기술 스택

- **Frontend**: Vue.js 3 + Vite
- **Backend**: Spring Boot 3.x + Java 17
- **Database**: MariaDB 10.11
- **CI/CD**: Jenkins
- **Container**: Docker & Docker Compose

## 빠른 시작

1. **전체 서비스 실행**
   ```bash
   docker-compose up -d
   ```

2. **개별 서비스 실행**
   ```bash
   # Frontend 개발 서버
   cd frontend && npm run dev
   
   # Backend 개발 서버
   cd backend && ./gradlew bootRun
   
   # Database
   docker-compose up database
   ```

## Jenkins 파이프라인

Jenkins 파이프라인은 다음 단계를 포함합니다:
1. 코드 체크아웃
2. 프론트엔드 빌드 및 테스트
3. 백엔드 빌드 및 테스트
4. Docker 이미지 빌드
5. 배포

## 개발 환경 설정

각 디렉토리의 README.md 파일을 참조하여 개별 설정 방법을 확인하세요. 