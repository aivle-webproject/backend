#!/bin/bash
set -e

APP_DIR=/home/ec2-user/app
JAR_NAME=demo-0.0.1-SNAPSHOT.jar
PID_FILE=$APP_DIR/app.pid

cd $APP_DIR

# 기존 프로세스 종료
if [ -f $PID_FILE ]; then
  PID=$(cat $PID_FILE)
  if ps -p $PID > /dev/null 2>&1; then
    kill $PID
    sleep 3
  fi
  rm -f $PID_FILE
fi

# 새 애플리케이션 실행 (절대 sudo 쓰지 말 것)
nohup java -jar build/libs/$JAR_NAME > app.log 2>&1 &

echo $! > $PID_FILE

echo "✅ Application started"
