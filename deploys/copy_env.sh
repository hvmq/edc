#!/bin/bash
if [ "$1" == "production" ]; then
  cp -rf .env.prod .env
else
  cp -rf .env.dev .env
fi