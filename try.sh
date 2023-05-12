#!/bin/bash

bash build.sh prompt-tuning:latest

exit

while [ $? -ne 0 ];  
do  
	bash build.sh prompt-tuning:latest
done

echo "success"
