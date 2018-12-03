#!/bin/bash

i=1

while true; do	
	#calculate length of sysbench test
	maxprime=$(shuf -i 5000-20000 -n 1)
	echo "Starting round $i of testing (max prime of $maxprime)"
	
	#print current date and time
	date
	
	#print temperature before test
	echo -n "Temperature (pre test $i):"
	vcgencmd measure_temp

	#run test
	sysbench --num-threads=4 --validate=on --test=cpu --cpu-max-prime=$maxprime run
	
	#time in seconds to sleep before next round of testing (15s-5m)
	sleeptime=$(shuf -i 15-300 -n 1)
	
	#print temperature after test
	echo -n "Temperature (post test $i):"
	vcgencmd measure_temp
	
	#sleep
	echo "Sleeping for $sleeptime seconds"
	sleep $sleeptime

	#increment round
	i=$((i + 1))
done

