#!/bin/bash

`/usr/bin/df -T -all | /usr/bin/awk '$4!="-"{sumG+=$4/1024/1024}END{print sumG}'`
