#!/bin/sh

test `git rev-parse --symbolic-full-name --abbrev-ref HEAD` = "master" && scp index.html ett.ethnoll.se:www/adam/
