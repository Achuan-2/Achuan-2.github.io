#!/bin/bash

# 文件拷贝 修改成自己的目录
waitCopyFile = echo y | cp -R E:/solo/static-site* E:/Github/Achuan-2.github.io
echo "开始上传"

# 修改成自己的目录
cd E:/Github/Achuan-2.github.io
## 添加所有文件
git add --all

echo "请输入提交描述文字如果没有默认: 更新文章"
read describe
if [ ! -n "$describe" ]
then
describe="更新文章"
fi
echo $describe

## commit 代码
git commit -m $describe

## 拉取代码
git pull

## 提交代码
git push origin master 

