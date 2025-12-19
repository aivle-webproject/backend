#!/bin/bash

pkill -f "java -jar" || true
sleep 2

set -e

APP_DIR="/home/ubuntu/app"
LOG_DIR="$APP_DIR/logs"
RUN_DIR="$APP_DIR/run"

mkdir -p "$LOG_DIR" "$RUN_DIR"
cd "$APP_DIR"

# 가장 최신 jar 실행
JAR=$(find "$APP_DIR" -name "*.jar" | sort | tail -n 1)

if [ -z "$JAR" ]; then
  echo "❌ No jar file found"
  exit 1
fi

LOG_FILE="$LOG_DIR/app_$(date +%Y%m%d_%H%M%S).log"

JAVA_OPTS="-Duser.timezone=Asia/Seoul"
APP_OPTS="--spring.profiles.active=prod"

nohup java $JAVA_OPTS -jar "$JAR" $APP_OPTS > "$LOG_FILE" 2>&1 &

echo $! > "$RUN_DIR/app.pid"

echo "✅ Application started. PID=$(cat $RUN_DIR/app.pid)"
