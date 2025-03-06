#!/usr/bin/env bash
timedatectl | grep "Local time" | awk '{print $4" "$5}' > $1
