# Frontend - Vue.js + Vite

이 디렉토리는 Vue.js 3와 Vite를 사용한 프론트엔드 애플리케이션을 포함합니다.

## 기술 스택

- **Vue.js 3** - Composition API 기반 프론트엔드 프레임워크
- **Vite** - 빠른 빌드 도구
- **Vue Router** - 클라이언트 사이드 라우팅
- **Pinia** - 상태 관리
- **Axios** - HTTP 클라이언트
- **ESLint** - 코드 품질 관리

## 개발 환경 설정

### 1. 의존성 설치
```bash
npm install
```

### 2. 개발 서버 실행
```bash
npm run dev
```
- URL: http://localhost:3000
- Hot Module Replacement (HMR) 지원

### 3. 빌드
```bash
npm run build
```
- 프로덕션용 빌드 생성
- `dist/` 디렉토리에 출력

### 4. 테스트
```bash
npm run test
```
- Vitest를 사용한 단위 테스트

### 5. 린트 검사
```bash
npm run lint
```
- ESLint를 사용한 코드 품질 검사

## 프로젝트 구조

```
frontend/
├── src/
│   ├── components/     # 재사용 가능한 컴포넌트
│   ├── views/         # 페이지 컴포넌트
│   ├── router/        # 라우터 설정
│   ├── stores/        # Pinia 상태 관리
│   ├── assets/        # 정적 자산
│   ├── App.vue        # 메인 앱 컴포넌트
│   └── main.js        # 앱 진입점
├── public/            # 정적 파일
├── index.html         # HTML 템플릿
├── vite.config.js     # Vite 설정
├── package.json       # 의존성 관리
└── nginx.conf         # Nginx 설정
```

## 주요 기능

### 1. 라우팅
- 홈 페이지 (`/`)
- 소개 페이지 (`/about`)
- API 테스트 페이지 (`/api-test`)

### 2. API 통신
- 백엔드 API와의 통신
- 헬스체크 엔드포인트
- 사용자 관리 API
- 데이터베이스 테스트 API

### 3. 반응형 디자인
- 모바일 친화적 UI
- CSS Grid 및 Flexbox 활용
- 모던한 디자인 시스템

## Docker 배포

### 1. 개발 환경
```bash
# 프론트엔드만 실행
docker-compose up frontend
```

### 2. 프로덕션 환경
```bash
# 전체 서비스 실행
docker-compose up -d
```

## 환경 변수

- `VITE_API_BASE_URL` - API 기본 URL (기본값: http://localhost:8080)

## 개발 팁

### 1. 컴포넌트 개발
```vue
<template>
  <div class="component">
    <!-- 템플릿 내용 -->
  </div>
</template>

<script setup>
// Composition API 사용
import { ref, reactive } from 'vue'

const data = ref([])
const loading = reactive({})
</script>

<style scoped>
/* 컴포넌트 스타일 */
</style>
```

### 2. API 호출
```javascript
import axios from 'axios'

const api = axios.create({
  baseURL: '/api'
})

// GET 요청
const getData = async () => {
  try {
    const response = await api.get('/users')
    return response.data
  } catch (error) {
    console.error('API 호출 실패:', error)
  }
}
```

### 3. 상태 관리
```javascript
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    users: [],
    loading: false
  }),
  actions: {
    async fetchUsers() {
      this.loading = true
      try {
        const response = await api.get('/users')
        this.users = response.data
      } finally {
        this.loading = false
      }
    }
  }
})
```

## 성능 최적화

### 1. 코드 스플리팅
- 라우트별 코드 스플리팅
- 컴포넌트 지연 로딩

### 2. 이미지 최적화
- WebP 형식 사용
- 적절한 이미지 크기

### 3. 캐싱
- 정적 자산 캐싱
- API 응답 캐싱

## 테스트 전략

### 1. 단위 테스트
- 컴포넌트 테스트
- 유틸리티 함수 테스트

### 2. 통합 테스트
- API 통신 테스트
- 라우팅 테스트

### 3. E2E 테스트
- 사용자 시나리오 테스트

## 배포 체크리스트

- [ ] 빌드 성공 확인
- [ ] 테스트 통과 확인
- [ ] 린트 검사 통과
- [ ] 환경 변수 설정
- [ ] API 엔드포인트 연결 확인
- [ ] 반응형 디자인 확인
- [ ] 성능 최적화 확인 