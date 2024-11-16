#!/bin/bash
set -e
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
git commit -m "[ci skip] Build version $version" pubspec.yaml