
all:
	./build-and-test.sh

macos:
	./build-and-test.mac.sh

check:
	echo "check is done by all"

distcheck: 
	echo "chek/dist is done by all"
