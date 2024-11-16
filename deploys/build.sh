#!/bin/zsh
if [ "$1" != "production" ] && [ "$1" != "development" ]
then
  echo "Flavor incorrect"
  exit
fi
if [ -e ".fvmrc" ]; then
  FVM_VERSION=$(perl -ne 'print $1 if /"flutter": "([^"]+)"/' .fvmrc)
else
  FVM_VERSION=$(perl -ne 'print $1 if /"flutterSdkVersion": "([^"]+)"/' .fvm/fvm_config.json)
fi
fvm use "$FVM_VERSION"
# copy file env
sh deploys/copy_env.sh $1

# generate code
sh pub.sh
# bump version code
sh deploys/version.sh $1
# ios update repo
cd ios
pod install
pod repo update
cd ..

if [ $1 = "production" ]
then
target="lib/main.dart"
else
target="lib/main.dart"
fi
# build ios for update version app
fvm flutter build ipa --obfuscate --split-debug-info="build/ios" --release -t $target --export-options-plist="deploys/configs/$1/ExportOptions.plist" --flavor $1 --no-pub
#  build android for update version
fvm flutter build appbundle --obfuscate --split-debug-info="build/app/outputs/bundle" --release -t $target --flavor $1 --no-pub
fvm flutter build apk --obfuscate --split-debug-info="build/app/outputs/apk" --release -t $target --flavor $1 --no-pub