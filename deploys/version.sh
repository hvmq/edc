#!/bin/bash
set -e

# Find and increment the version number.
#if [ $1 = "production" ]
#then
## increment path and build number for production
#perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.($4+1)/e' pubspec.yaml
#else
# increment build number for development
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
#fi