<template>
  <div class="home">
    <div class="hero">
      <h1>Jenkins Mono Repository</h1>
      <p>Vue.js + Spring Boot + MariaDB 모노레포 프로젝트</p>
    </div>
    
    <div class="features">
      <div class="feature-card">
        <h3>Frontend</h3>
        <p>Vue.js 3 + Vite를 사용한 모던 프론트엔드</p>
        <ul>
          <li>Vue 3 Composition API</li>
          <li>Vue Router</li>
          <li>Pinia 상태 관리</li>
          <li>Vite 빌드 도구</li>
        </ul>
      </div>
      
      <div class="feature-card">
        <h3>Backend</h3>
        <p>Spring Boot 3.x + Java 17 백엔드 API</p>
        <ul>
          <li>RESTful API</li>
          <li>Spring Security</li>
          <li>JPA/Hibernate</li>
          <li>Gradle 빌드</li>
        </ul>
      </div>
      
      <div class="feature-card">
        <h3>Database</h3>
        <p>MariaDB 10.11 데이터베이스</p>
        <ul>
          <li>Docker 컨테이너</li>
          <li>데이터 영속성</li>
          <li>백업 및 복구</li>
          <li>성능 최적화</li>
        </ul>
      </div>
    </div>
    
    <div class="cta">
      <h2>시작하기</h2>
      <p>프로젝트를 로컬에서 실행하거나 Jenkins를 통해 CI/CD 파이프라인을 구축하세요.</p>
      <div class="buttons">
        <button class="btn btn-primary" @click="runLocally">로컬 실행</button>
        <button class="btn btn-secondary" @click="viewJenkins">Jenkins 설정</button>
      </div>
    </div>
  </div>
</template>

<script setup>
const runLocally = () => {
  alert('로컬 실행 가이드를 확인하세요!')
}

const viewJenkins = () => {
  alert('Jenkins 파이프라인 설정을 확인하세요!')
}
</script>

<style scoped>
.home {
  text-align: center;
}

.hero {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 4rem 2rem;
  border-radius: 12px;
  margin-bottom: 3rem;
}

.hero h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.hero p {
  font-size: 1.2rem;
  opacity: 0.9;
}

.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
}

.feature-card {
  background: white;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  text-align: left;
}

.feature-card h3 {
  color: #667eea;
  margin-bottom: 1rem;
}

.feature-card ul {
  list-style: none;
  padding: 0;
}

.feature-card li {
  padding: 0.5rem 0;
  border-bottom: 1px solid #f0f0f0;
}

.feature-card li:last-child {
  border-bottom: none;
}

.cta {
  background: #f8f9fa;
  padding: 3rem 2rem;
  border-radius: 12px;
}

.cta h2 {
  margin-bottom: 1rem;
}

.buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-top: 2rem;
}

.btn {
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary {
  background: #667eea;
  color: white;
}

.btn-primary:hover {
  background: #5a6fd8;
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #5a6268;
}
</style> 