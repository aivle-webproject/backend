#!/bin/bash
set -e

APP_DIR=/home/ec2-user/app
JAR="$APP_DIR/build/libs/demo-0.0.1-SNAPSHOT.jar"
LOG_DIR=/home/ec2-user/log
PID_FILE=/home/ec2-user/app/app.pid

mkdir -p "$LOG_DIR"

# (선택) 기존 프로세스 있으면 종료
if [ -f "$PID_FILE" ] && kill -0 "$(cat $PID_FILE)" 2>/dev/null; then
  kill "$(cat $PID_FILE)" || true
  sleep 3
fi

# 백그라운드로 실행 (중요!)
nohup java -jar "$JAR" > "$LOG_DIR/app.log" 2>&1 &
echo $! > "$PID_FILE"

echo "✅ Application started"
exit 0
