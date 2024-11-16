#!/bin/zsh
# $1 is "development" or "production"
sh deploys/build.sh $1
API_URL="http://18.140.43.74:8081"
TELEGRAM_CHAT_ID="-4205563605"
TELEGRAM_TOKEN="7340820658:AAEOff9QpS5Bz9VRJnyi214Qz9kZSWNtS4s"

if [ $1 = "development" ]
then
cd android
bundle exec fastlane deployDevelopment
cd ..
sh deploys/send_file_telegram.sh $API_URL $TELEGRAM_CHAT_ID $TELEGRAM_TOKEN "build/app/outputs/flutter-apk/app-development-release.apk" $1
else
cd android
bundle exec fastlane deployProduction
cd ..
sh deploys/send_file_telegram.sh $API_URL $TELEGRAM_CHAT_ID $TELEGRAM_TOKEN "build/app/outputs/flutter-apk/app-production-release.apk" $1
fi
sh deploys/git_commit.sh
git push