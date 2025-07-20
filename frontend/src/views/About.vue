<template>
  <div class="about">
    <h1>프로젝트 소개</h1>
    
    <div class="content">
      <section class="section">
        <h2>개요</h2>
        <p>
          이 프로젝트는 Vue.js 프론트엔드, Spring Boot 백엔드, MariaDB 데이터베이스를 포함한 
          모노레포 구조의 웹 애플리케이션입니다. Jenkins를 통한 CI/CD 파이프라인을 구축하여 
          자동화된 빌드, 테스트, 배포가 가능합니다.
        </p>
      </section>
      
      <section class="section">
        <h2>기술 스택</h2>
        <div class="tech-stack">
          <div class="tech-category">
            <h3>Frontend</h3>
            <ul>
              <li>Vue.js 3 (Composition API)</li>
              <li>Vite (빌드 도구)</li>
              <li>Vue Router (라우팅)</li>
              <li>Pinia (상태 관리)</li>
              <li>Axios (HTTP 클라이언트)</li>
            </ul>
          </div>
          
          <div class="tech-category">
            <h3>Backend</h3>
            <ul>
              <li>Spring Boot 3.x</li>
              <li>Java 17</li>
              <li>Spring Security</li>
              <li>Spring Data JPA</li>
              <li>Gradle (빌드 도구)</li>
            </ul>
          </div>
          
          <div class="tech-category">
            <h3>Database</h3>
            <ul>
              <li>MariaDB 10.11</li>
              <li>Docker 컨테이너</li>
              <li>데이터 영속성</li>
            </ul>
          </div>
          
          <div class="tech-category">
            <h3>DevOps</h3>
            <ul>
              <li>Jenkins (CI/CD)</li>
              <li>Docker & Docker Compose</li>
              <li>자동화된 테스트</li>
              <li>자동 배포</li>
            </ul>
          </div>
        </div>
      </section>
      
      <section class="section">
        <h2>프로젝트 구조</h2>
        <pre class="structure">
jenkins-mono/
├── frontend/          # Vue.js + Vite 프론트엔드
│   ├── src/
│   ├── public/
│   └── package.json
├── backend/           # Spring Boot 백엔드
│   ├── src/
│   ├── build.gradle
│   └── gradle/
├── database/          # MariaDB Docker 설정
│   ├── Dockerfile
│   └── init.sql
├── jenkins/           # Jenkins 파이프라인 설정
│   └── Jenkinsfile
└── docker-compose.yml # 전체 서비스 오케스트레이션
        </pre>
      </section>
      
      <section class="section">
        <h2>CI/CD 파이프라인</h2>
        <div class="pipeline">
          <div class="pipeline-step">
            <h4>1. 코드 체크아웃</h4>
            <p>Git 저장소에서 최신 코드를 가져옵니다.</p>
          </div>
          <div class="pipeline-step">
            <h4>2. 프론트엔드 빌드</h4>
            <p>Vue.js 애플리케이션을 빌드하고 테스트합니다.</p>
          </div>
          <div class="pipeline-step">
            <h4>3. 백엔드 빌드</h4>
            <p>Spring Boot 애플리케이션을 빌드하고 테스트합니다.</p>
          </div>
          <div class="pipeline-step">
            <h4>4. Docker 이미지 빌드</h4>
            <p>각 서비스의 Docker 이미지를 빌드합니다.</p>
          </div>
          <div class="pipeline-step">
            <h4>5. 배포</h4>
            <p>테스트 환경 또는 프로덕션 환경에 배포합니다.</p>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>
// About 페이지 컴포넌트
</script>

<style scoped>
.about {
  max-width: 800px;
  margin: 0 auto;
}

.about h1 {
  text-align: center;
  color: #667eea;
  margin-bottom: 2rem;
}

.section {
  margin-bottom: 3rem;
}

.section h2 {
  color: #333;
  border-bottom: 2px solid #667eea;
  padding-bottom: 0.5rem;
  margin-bottom: 1rem;
}

.tech-stack {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.tech-category {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.tech-category h3 {
  color: #667eea;
  margin-bottom: 1rem;
}

.tech-category ul {
  list-style: none;
  padding: 0;
}

.tech-category li {
  padding: 0.25rem 0;
  border-bottom: 1px solid #e9ecef;
}

.tech-category li:last-child {
  border-bottom: none;
}

.structure {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  overflow-x: auto;
  font-family: 'Courier New', monospace;
  font-size: 0.9rem;
  line-height: 1.4;
}

.pipeline {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.pipeline-step {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #28a745;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.pipeline-step h4 {
  color: #28a745;
  margin-bottom: 0.5rem;
}

.pipeline-step p {
  margin: 0;
  color: #666;
}
</style> 