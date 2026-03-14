#!/bin/bash
set -e

time $@

for (( i = 0; i <= $(< /etc/egg.conf); i++ ))
do
	printf '\a'
	sleep 0.1
done
