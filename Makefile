ab:
	ab -n 1000 -c 10 http://192.168.1.100:10080/

ab8000:
	ab -n 1000 -c 10 http://192.168.1.100:8000/

test:
	curl 192.168.1.100:10080

test8000:
	curl 192.168.1.100:8000