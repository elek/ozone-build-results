#!/usr/bin/env bash
./ogh archive `pwd`
./ogh builds > builds.txt
git add .
git commit -m "periodic update"
git push origin
