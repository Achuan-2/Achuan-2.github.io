---
title: 使用 Vercel 自动部署 hexo 博客
date: '2023-09-27 14:56:12'
updated: '2023-09-27 15:11:13'
excerpt: Github 博客的repo提交commit修改后，Vercel自动部署生成静态文件，无需手动执行构建，避免了繁琐的手动部署过程；
tags:
  - hexo
categories:
  - 技术博客
comments: true
toc: true
---

# 使用 Vercel 自动部署 hexo 博客

使用 Vercel 自动部署 hexo 博客的好处

* 可以直接在云端的Github Repo添加修改文件；
* Github 博客的repo提交commit修改后，Vercel自动部署生成静态文件，无需手动执行构建，避免了繁琐的手动部署过程；

注意：

* 博客打开的文件实际上用的是vercel上的html域名配置，和之前手动部署生成的hexo静态文件就没关系了。

## vercel 部署

地址：[New Project – Vercel](https://vercel.com/new)

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202309271511638.png)​

## 购买域名

* 地址：[万网](https://wanwang.aliyun.com/?)
* 购买域名：购买了achuan-2.top域名
* 添加解析：[域名控制台](https://dns.console.aliyun.com/) 。可选择用CNAME或A记录，解析域名和www+域名。

  * 解析vercel

    * A记录地址：`76.223.126.88`​
    * CNAME 记录地址：`cname-china.vercel-dns.com`​
* 一般用CNAME就好

  ​![Snipaste_2022-10-27_19-08-14](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202309271511512.png)​

## Vercel hexo APP添加自定义域名

* 地址：[Project Settings – Dashboard – Vercel](https://vercel.com/achuan-2/hexo/settings/domains)
* 输入域名：achuan-2.top
* 结果

  ​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202309271511049.png)​​

## github.io设置CNAME

CNAME就是域名改为另一个域名的文件

hexo repo的 `source`​目录新建 `CNAME`​，填入

```plaintext
achuan-2.top
```

‍
