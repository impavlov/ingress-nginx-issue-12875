#while curl -s -X POST -H "Content-Type: application/x-git-upload-pack-request" -d @10M http://localhost:8080/upload > /dev/null
#while curl -s -X PATCH -H "Content-Type: application/octet-stream" -d @10M http://localhost:8080/upload > /dev/null
while curl -s -d @10M "http://localhost:8080/upload" > /dev/null
do 
	printf "."
done
printf "f\n"
