#!/bin/bash
SERVER_NAME=spring-study
CONTAINER_NAME=springboot
CID=$(docker ps | grep "$CONTAINER_NAME" | awk '{print $1}')

function build(){
		docker build -t $SERVER_NAME .
}

function run(){
	build
	if [ -n "$CID" ]; then
	    echo "$CONTAINER_NAME，CID=$CID,删除docker容器 ..."
			docker stop $CONTAINER_NAME
			docker rm $CONTAINER_NAME
			docker run --name $CONTAINER_NAME  -d -p 8000:8000 $SERVER_NAME
		echo "$CONTAINER_NAME"
	else
	    echo "$CONTAINER_NAME，docker run创建容器..."
			docker run --name $CONTAINER_NAME  -d -p 8000:8000 $SERVER_NAME
		echo "$CONTAINER_NAME"
	fi

}

run
