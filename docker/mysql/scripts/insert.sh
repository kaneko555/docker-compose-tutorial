#!/bin/bash
set -e

# 条件付きINSERT処理
COUNT=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -se "SELECT COUNT(*) FROM users;")

echo "Current user count: $COUNT"

if [ "$COUNT" -lt 10 ]; then
  echo "ダミーユーザーをINSERTします..."
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "
    INSERT INTO users (name) VALUES 
    ('User1'), ('User2'), ('User3'), ('User4'), ('User5');
  "
else
  echo "usersテーブルに既に10件以上データがあるため、INSERT処理をスキップします。"
fi
