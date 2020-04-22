#!/bin/bash

#clean watchman
echo "CLEAN WATCHMAN"
watchman watch-del-all

#remove packager cache
echo "REMOVE TEMP DIR CACHE"
rm -rf "$TMPDIR/metro-*"
rm -rf "$TMPDIR/haste-*"
rm -rf "$TMPDIR/react-*"

#remove iOS caches
echo "REMOVE iOS CACHE"
rm -rf ios/build 
cd ios
xcodebuild clean
cd ..

#remove iOS caches
echo "REMOVE PODS"
cd ios
rm -rf Pods
rm Podfile.lock
cd ..

#remove Android caches
echo "REMOVE ANDROID CACHE"
cd android
./gradlew clean
rm -rf ./app/build
cd .. 

#remove node_module dependencies
echo "REMOVE NODE_MODULES DEPENDENCIES"
rm -rf node_modules/

# clean yarn cache and reinstall dependencies
echo "CLEAN YARN CACHE AND ISNTALL DEPENDENCIES"
yarn cache clean --force
yarn install

# link dependencies
echo "LINK DEPENDENCIES"
react-native link
cd ios
pod install
cd ..

# start metro bundler
echo "START METRO BUDLER"
yarn start --reset-cache
