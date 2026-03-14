#!/bin/bash

time $1

for i in {0..5}
do
	printf '\a'
	sleep 0.1
done
