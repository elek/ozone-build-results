#!/usr/bin/env bash
./ogh archive `pwd`
./ogh report `pwd`
find * -size '+100M' | xargs rm -v
git add .
git config user.email "ci@github.com"
git config user.name "Github Actions"
git commit --author "Github Actions <ci@github.com>" -m "periodic update"
git push origin
