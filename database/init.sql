-- Jenkins Mono Repository Database 초기화 스크립트

-- 데이터베이스 생성 (이미 Docker 환경변수로 생성됨)
-- CREATE DATABASE IF NOT EXISTS jenkins_mono;

-- 사용자 테이블 생성
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role ENUM('ADMIN', 'USER') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 샘플 데이터 삽입
INSERT INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@jenkinsmono.com', '$2a$10$rDmFN6ZqJdcQjKvXjJqKvO', '관리자', 'ADMIN'),
('user1', 'user1@jenkinsmono.com', '$2a$10$rDmFN6ZqJdcQjKvXjJqKvO', '사용자1', 'USER'),
('user2', 'user2@jenkinsmono.com', '$2a$10$rDmFN6ZqJdcQjKvXjJqKvO', '사용자2', 'USER');

-- 인덱스 생성
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email); 