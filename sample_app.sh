#!/bin/bash

# 创建临时目录来存储网站文件
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# 复制网站目录和脚本到临时目录
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# 创建 Dockerfile
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# 构建 Docker 容器
cd tempdir
docker build -t sampleapp .

# 启动容器并验证
docker run -t -d -p 5050:5050 --name samplerunning sampleapp

# 显示所有正在运行的Docker容器
docker ps -a
