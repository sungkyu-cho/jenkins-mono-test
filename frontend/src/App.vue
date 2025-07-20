<template>
  <div id="app">
    <nav class="navbar">
      <div class="nav-brand">
        <h1>Jenkins Mono Repository</h1>
      </div>
      <div class="nav-links">
        <router-link to="/">홈</router-link>
        <router-link to="/about">소개</router-link>
        <router-link to="/api-test">API 테스트</router-link>
      </div>
    </nav>
    
    <main class="main-content">
      <router-view />
    </main>
    
    <footer class="footer">
      <p>&copy; 2024 Jenkins Mono Repository</p>
    </footer>
  </div>
</template>

<script setup>
// Vue 3 Composition API 사용
</script>

<style scoped>
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.nav-brand h1 {
  margin: 0;
  font-size: 1.5rem;
  font-weight: 600;
}

.nav-links {
  display: flex;
  gap: 2rem;
}

.nav-links a {
  color: white;
  text-decoration: none;
  font-weight: 500;
  transition: opacity 0.3s ease;
}

.nav-links a:hover {
  opacity: 0.8;
}

.main-content {
  flex: 1;
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.footer {
  background: #f8f9fa;
  padding: 1rem 2rem;
  text-align: center;
  border-top: 1px solid #e9ecef;
}
</style> 