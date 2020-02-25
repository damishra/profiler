all: cpu_hog bandwidth_hog bandwidth_hog_burst memory_hog memory_hog_leak disk_hog

pre:
	mkdir resources/bin

cpu_hog: pre
	gcc resources/src/cpu_hog.c -o resources/bin/cpu_hog

bandwidth_hog_burst: pre
	gcc resources/src/bandwidth_hog_burst.c -o resources/bin/bandwidth_hog_burst

bandwidth_hog: pre
	gcc resources/src/bandwidth_hog.c -o resources/bin/bandwidth_hog

memory_hog: pre
	gcc resources/src/memory_hog.c -o resources/bin/memory_hog

disk_hog: pre
	gcc resources/src/disk_hog.c -o resources/bin/disk_hog

memory_hog_leak: pre
	gcc resources/src/memory_hog_leak.c -o resources/bin/memory_hog_leak

clean:
	rm -rf resources/bin
