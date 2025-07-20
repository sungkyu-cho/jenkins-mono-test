# Database - MariaDB

이 디렉토리는 MariaDB 10.11 데이터베이스 설정을 포함합니다.

## 기술 스택

- **MariaDB 10.11** - 오픈소스 관계형 데이터베이스
- **Docker** - 컨테이너화
- **Docker Compose** - 서비스 오케스트레이션

## 데이터베이스 설정

### 1. 환경 변수
```bash
MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=jenkins_mono
MYSQL_USER=jenkins_user
MYSQL_PASSWORD=jenkins_pass
```

### 2. 포트 설정
- 기본 포트: 3306
- 호스트 포트: 3306

## 개발 환경 설정

### 1. Docker를 사용한 실행
```bash
# 데이터베이스만 실행
docker-compose up database

# 또는 전체 서비스 실행
docker-compose up -d
```

### 2. 데이터베이스 연결 확인
```bash
# 컨테이너 접속
docker exec -it jenkins-mono-database mysql -u root -p

# 연결 테스트
mysql -h localhost -P 3306 -u root -ppassword jenkins_mono
```

### 3. 데이터베이스 초기화
```bash
# 초기화 스크립트 실행
docker exec -i jenkins-mono-database mysql -u root -ppassword jenkins_mono < init.sql
```

## 프로젝트 구조

```
database/
├── Dockerfile          # MariaDB Docker 이미지 설정
├── docker-compose.yml  # 데이터베이스 전용 Docker Compose
├── init.sql           # 초기화 SQL 스크립트
└── README.md          # 이 파일
```

## 데이터베이스 스키마

### 1. 사용자 테이블 (users)
```sql
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role ENUM('ADMIN', 'USER') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2. 인덱스
```sql
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
```

### 3. 샘플 데이터
```sql
INSERT INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@jenkinsmono.com', '$2a$10$rDmFN6ZqJdcQjKvXjJqKvO', '관리자', 'ADMIN'),
('user1', 'user1@jenkinsmono.com', '$2a$10$rDmFN6ZqJdcQjKvXjJqKvO', '사용자1', 'USER'),
('user2', 'user2@jenkinsmono.com', '$2a$10$rDmFN6ZqJdcQjKvXjJqKvO', '사용자2', 'USER');
```

## Docker 설정

### 1. Dockerfile
```dockerfile
FROM mariadb:10.11

ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_DATABASE=jenkins_mono
ENV MYSQL_USER=jenkins_user
ENV MYSQL_PASSWORD=jenkins_pass

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD mysqladmin ping -h localhost -u root -p$MYSQL_ROOT_PASSWORD || exit 1
```

### 2. Docker Compose
```yaml
version: '3.8'

services:
  database:
    build: .
    container_name: jenkins-mono-database
    restart: unless-stopped
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: jenkins_mono
      MYSQL_USER: jenkins_user
      MYSQL_PASSWORD: jenkins_pass
    volumes:
      - mariadb_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    networks:
      - jenkins-mono-network

volumes:
  mariadb_data:

networks:
  jenkins-mono-network:
    driver: bridge
```

## 데이터베이스 관리

### 1. 백업
```bash
# 전체 데이터베이스 백업
docker exec jenkins-mono-database mysqldump -u root -ppassword jenkins_mono > backup.sql

# 특정 테이블 백업
docker exec jenkins-mono-database mysqldump -u root -ppassword jenkins_mono users > users_backup.sql
```

### 2. 복원
```bash
# 백업에서 복원
docker exec -i jenkins-mono-database mysql -u root -ppassword jenkins_mono < backup.sql
```

### 3. 데이터 확인
```bash
# 테이블 구조 확인
docker exec -it jenkins-mono-database mysql -u root -ppassword jenkins_mono -e "DESCRIBE users;"

# 데이터 확인
docker exec -it jenkins-mono-database mysql -u root -ppassword jenkins_mono -e "SELECT * FROM users;"
```

## 성능 최적화

### 1. MariaDB 설정 최적화
```ini
[mysqld]
# 메모리 설정
innodb_buffer_pool_size = 256M
innodb_log_file_size = 64M
innodb_log_buffer_size = 16M

# 연결 설정
max_connections = 100
max_connect_errors = 1000

# 쿼리 캐시
query_cache_type = 1
query_cache_size = 32M
```

### 2. 인덱스 최적화
- 자주 조회되는 컬럼에 인덱스 생성
- 복합 인덱스 활용
- 불필요한 인덱스 제거

### 3. 쿼리 최적화
- EXPLAIN을 사용한 쿼리 분석
- N+1 문제 방지
- 적절한 JOIN 사용

## 보안 설정

### 1. 사용자 권한 관리
```sql
-- 읽기 전용 사용자 생성
CREATE USER 'readonly'@'%' IDENTIFIED BY 'password';
GRANT SELECT ON jenkins_mono.* TO 'readonly'@'%';

-- 애플리케이션 사용자 생성
CREATE USER 'app_user'@'%' IDENTIFIED BY 'app_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON jenkins_mono.* TO 'app_user'@'%';
```

### 2. 네트워크 보안
- 방화벽 설정
- VPN 사용
- SSL/TLS 암호화

### 3. 데이터 암호화
- 테이블스페이스 암호화
- 컬럼 레벨 암호화
- 백업 파일 암호화

## 모니터링

### 1. 성능 모니터링
```sql
-- 현재 연결 상태 확인
SHOW PROCESSLIST;

-- 테이블 크기 확인
SELECT 
    table_name,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.tables 
WHERE table_schema = 'jenkins_mono';
```

### 2. 로그 모니터링
```bash
# MariaDB 로그 확인
docker logs jenkins-mono-database

# 슬로우 쿼리 로그 확인
docker exec -it jenkins-mono-database tail -f /var/log/mysql/slow.log
```

## 트러블슈팅

### 1. 연결 문제
```bash
# 포트 확인
netstat -tulpn | grep 3306

# 컨테이너 상태 확인
docker ps | grep database

# 로그 확인
docker logs jenkins-mono-database
```

### 2. 성능 문제
```sql
-- 슬로우 쿼리 확인
SHOW VARIABLES LIKE 'slow_query_log';
SHOW VARIABLES LIKE 'long_query_time';

-- 인덱스 사용 현황 확인
SHOW INDEX FROM users;
```

### 3. 데이터 손실 방지
- 정기적인 백업
- 복제 설정
- 자동 복구 스크립트

## 배포 체크리스트

- [ ] 데이터베이스 컨테이너 실행 확인
- [ ] 초기화 스크립트 실행 확인
- [ ] 연결 테스트 완료
- [ ] 샘플 데이터 삽입 확인
- [ ] 백업 스크립트 설정
- [ ] 모니터링 설정 완료
- [ ] 보안 설정 확인
- [ ] 성능 최적화 완료 