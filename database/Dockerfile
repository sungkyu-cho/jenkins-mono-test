FROM mariadb:10.11

# 환경 변수 설정
ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_DATABASE=jenkins_mono
ENV MYSQL_USER=jenkins_user
ENV MYSQL_PASSWORD=jenkins_pass

# 초기화 스크립트 복사
COPY init.sql /docker-entrypoint-initdb.d/

# 포트 노출
EXPOSE 3306

# 헬스체크 추가
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD mysqladmin ping -h localhost -u root -p$MYSQL_ROOT_PASSWORD || exit 1 