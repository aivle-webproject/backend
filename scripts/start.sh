#!/bin/bash

# 기존 Spring Boot 프로세스 종료
pkill -f "java -jar" || true
sleep 2

set -e

APP_DIR="/home/ubuntu/app"
LOG_DIR="$APP_DIR/logs"
RUN_DIR="$APP_DIR/run"

mkdir -p "$LOG_DIR" "$RUN_DIR"
cd "$APP_DIR"

# 가장 최신 jar 찾기
JAR=$(find "$APP_DIR" -name "*.jar" | sort | tail -n 1)

if [ -z "$JAR" ]; then
  echo "❌ No jar file found"
  exit 1
fi

LOG_FILE="$LOG_DIR/app_$(date +%Y%m%d_%H%M%S).log"

# Spring Boot 실행
nohup java -jar "$JAR" > "$LOG_FILE" 2>&1 &

echo $! > "$RUN_DIR/app.pid"

echo "✅ Application started. PID=$(cat $RUN_DIR/app.pid)"
