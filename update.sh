#!/usr/bin/env bash
./ogh archive `pwd`
git commit -m "periodic update"
git push origin
