#!/bin/bash

# 기존 Spring Boot 종료 (프로세스 kill은 쓰기 권한 불필요)
pkill -f "java -jar" || true
sleep 2

set -e

APP_DIR="/home/ubuntu/app"
cd "$APP_DIR"

# 최신 jar 찾기 (읽기만)
JAR=$(find "$APP_DIR" -name "*.jar" | sort | tail -n 1)

if [ -z "$JAR" ]; then
  echo "❌ No jar file found"
  exit 1
fi

# Spring Boot 실행 (nohup.out은 현재 디렉토리에 생성됨)
nohup java -jar "$JAR" &

echo "✅ Application started"
