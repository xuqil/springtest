#!/bin/bash
#操作/项目路径(Dockerfile存放的路径)
BASE_PATH=/www/wwwroot/springboot
# 源jar路径
SOURCE_PATH=target/
#docker 镜像/容器名字 这里都命名为这个
SERVER_NAME=spring-test
#jar
SPRING_NAME=springtest-0.0.1-SNAPSHOT
SRPINGTO_NAME=springtest
#容器id
CID=$(docker ps | grep "$SERVER_NAME" | awk '{print $1}')
#镜像id
IID=$(docker images | grep "$SERVER_NAME" | awk '{print $3}')

DATE=`date +%Y%m%d%H%M`

# 最新构建代码 移动到项目环境
function transfer(){
    echo "最新构建代码 $SOURCE_PATH$SPRING_NAME.jar 迁移至 $BASE_PATH ...."
        cp $SOURCE_PATH$SPRING_NAME.jar $BASE_PATH/$SRPINGTO_NAME.jar
    echo "迁移完成"
}

# 备份
function backup(){
	if [ -f "$BASE_PATH/$SRPINGTO_NAME.jar" ]; then
    	echo "$SPRING_NAME.jar 备份..."
        	cp $BASE_PATH/$SRPINGTO_NAME.jar $BASE_PATH/backup/$SRPINGTO_NAME.jar
        echo "备份 $SRPINGTO_NAME.jar 完成"
    else
    	echo "$BASE_PATH/$SRPINGTO_NAME.jar不存在，跳过备份"
    fi
}

# 构建docker镜像
function build(){
	if [ -n "$IID" ]; then
		echo "存在$SERVER_NAME镜像，IID=$IID"
	else
		echo "不存在$SERVER_NAME镜像，开始构建镜像"
#			cd $BASE_PATH
		docker build -t $SERVER_NAME .
	fi
}

# 运行docker容器
function run(){
	backup
	transfer
	build
	if [ -n "$CID" ]; then
		echo "存在$SERVER_NAME容器，CID=$CID,重启docker容器 ..."
			docker restart $SERVER_NAME
		echo "$SERVER_NAME容器重启完成"
	else
		echo "不存在$SERVER_NAME容器，docker run创建容器..."
			docker run --name $SERVER_NAME -v $BASE_PATH:$BASE_PATH  -d -p 8000:8000 $SERVER_NAME
		echo "$SERVER_NAME容器创建完成"
	fi
}

#入口
run
