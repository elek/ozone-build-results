#!/usr/bin/env bash
set -e
./ogh archive `pwd`
git add .
git commit --author "Github Actions <ci@github.com>" -m "periodic update"
git push origin
