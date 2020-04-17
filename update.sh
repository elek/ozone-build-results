#!/usr/bin/env bash
./ogh archive `pwd`
git add .
git commit -m "periodic update"
git push origin
