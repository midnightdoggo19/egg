#!/bin/bash
set -e

time $1

for (( i = 0; i <= $(< /etc/egg.conf); i++ ))
do
	printf '\a'
	sleep 0.1
done
