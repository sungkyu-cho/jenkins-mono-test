<template>
  <div class="api-test">
    <h1>API 테스트</h1>
    
    <div class="test-section">
      <h2>백엔드 API 연결 테스트</h2>
      <p>Spring Boot 백엔드 API와의 연결을 테스트합니다.</p>
      
      <div class="test-buttons">
        <button 
          @click="testHealth" 
          :disabled="loading.health"
          class="btn btn-primary"
        >
          {{ loading.health ? '테스트 중...' : 'Health Check' }}
        </button>
        
        <button 
          @click="testUsers" 
          :disabled="loading.users"
          class="btn btn-secondary"
        >
          {{ loading.users ? '테스트 중...' : 'Users API' }}
        </button>
        
        <button 
          @click="testDatabase" 
          :disabled="loading.database"
          class="btn btn-info"
        >
          {{ loading.database ? '테스트 중...' : 'Database Test' }}
        </button>
      </div>
      
      <div class="results">
        <div v-if="results.length > 0" class="results-list">
          <div 
            v-for="(result, index) in results" 
            :key="index"
            :class="['result-item', result.status]"
          >
            <div class="result-header">
              <span class="result-title">{{ result.title }}</span>
              <span class="result-time">{{ result.time }}</span>
            </div>
            <div class="result-content">
              <pre>{{ result.data }}</pre>
            </div>
          </div>
        </div>
        
        <div v-else class="no-results">
          <p>테스트를 실행하여 결과를 확인하세요.</p>
        </div>
      </div>
    </div>
    
    <div class="api-info">
      <h2>API 엔드포인트</h2>
      <div class="endpoints">
        <div class="endpoint">
          <h3>Health Check</h3>
          <code>GET /api/health</code>
          <p>백엔드 서비스 상태 확인</p>
        </div>
        
        <div class="endpoint">
          <h3>Users API</h3>
          <code>GET /api/users</code>
          <p>사용자 목록 조회</p>
        </div>
        
        <div class="endpoint">
          <h3>Database Test</h3>
          <code>GET /api/test/database</code>
          <p>데이터베이스 연결 테스트</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import axios from 'axios'

const loading = reactive({
  health: false,
  users: false,
  database: false
})

const results = ref([])

const addResult = (title, data, status = 'success') => {
  results.value.unshift({
    title,
    data: JSON.stringify(data, null, 2),
    status,
    time: new Date().toLocaleTimeString()
  })
}

const testHealth = async () => {
  loading.health = true
  try {
    const response = await axios.get('/api/health')
    addResult('Health Check', response.data, 'success')
  } catch (error) {
    addResult('Health Check', {
      error: error.message,
      status: error.response?.status || 'Network Error'
    }, 'error')
  } finally {
    loading.health = false
  }
}

const testUsers = async () => {
  loading.users = true
  try {
    const response = await axios.get('/api/users')
    addResult('Users API', response.data, 'success')
  } catch (error) {
    addResult('Users API', {
      error: error.message,
      status: error.response?.status || 'Network Error'
    }, 'error')
  } finally {
    loading.users = false
  }
}

const testDatabase = async () => {
  loading.database = true
  try {
    const response = await axios.get('/api/test/database')
    addResult('Database Test', response.data, 'success')
  } catch (error) {
    addResult('Database Test', {
      error: error.message,
      status: error.response?.status || 'Network Error'
    }, 'error')
  } finally {
    loading.database = false
  }
}
</script>

<style scoped>
.api-test {
  max-width: 1000px;
  margin: 0 auto;
}

.api-test h1 {
  text-align: center;
  color: #667eea;
  margin-bottom: 2rem;
}

.test-section {
  background: white;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  margin-bottom: 2rem;
}

.test-section h2 {
  color: #333;
  margin-bottom: 1rem;
}

.test-buttons {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.btn {
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-primary {
  background: #667eea;
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background: #5a6fd8;
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover:not(:disabled) {
  background: #5a6268;
}

.btn-info {
  background: #17a2b8;
  color: white;
}

.btn-info:hover:not(:disabled) {
  background: #138496;
}

.results {
  margin-top: 2rem;
}

.results-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.result-item {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 1rem;
  border-left: 4px solid #28a745;
}

.result-item.error {
  border-left-color: #dc3545;
}

.result-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.result-title {
  font-weight: 600;
  color: #333;
}

.result-time {
  font-size: 0.9rem;
  color: #666;
}

.result-content pre {
  background: #2d3748;
  color: #e2e8f0;
  padding: 1rem;
  border-radius: 6px;
  overflow-x: auto;
  font-size: 0.9rem;
  line-height: 1.4;
}

.no-results {
  text-align: center;
  color: #666;
  padding: 2rem;
}

.api-info {
  background: white;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.api-info h2 {
  color: #333;
  margin-bottom: 1.5rem;
}

.endpoints {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.endpoint {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.endpoint h3 {
  color: #667eea;
  margin-bottom: 0.5rem;
}

.endpoint code {
  background: #2d3748;
  color: #e2e8f0;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-size: 0.9rem;
  display: block;
  margin: 0.5rem 0;
}

.endpoint p {
  margin: 0.5rem 0 0 0;
  color: #666;
  font-size: 0.9rem;
}
</style> 