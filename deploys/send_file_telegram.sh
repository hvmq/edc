#!/bin/bash

# Configuration
#API_URL="http://192.168.1.215/bot-telegram"
#TELEGRAM_CHAT_ID="-1002135420136"
#TELEGRAM_TOKEN="6737456323:AAG-PiY_8bdG_-ZGjLtO54sYWP6h1YbAVgo"
#FILE_PATH="./build/app/outputs/flutter-apk/app-staging-release.apk"
# input
API_URL="$1"
TELEGRAM_CHAT_ID="$2"
TELEGRAM_TOKEN="$3"
FILE_PATH="$4"
ENVIRONMENT="$5"
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
CAPTION="Build $ENVIRONMENT v$version"

# Upload file to Telegram
response=$(curl -s -w "%{http_code}" -o /dev/null -F caption="$CAPTION" -F chat_id="$TELEGRAM_CHAT_ID" -F document=@"$FILE_PATH" "$API_URL/bot$TELEGRAM_TOKEN/sendDocument")

# Check response
if [ "$response" -eq 200 ]; then
  echo "File uploaded successfully."
else
  echo "Failed to upload file. HTTP status code: $response"
fi
