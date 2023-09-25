---
title: 【Github】cdn jsdelivr加速使用方法
date: '2021-10-09 16:53:31'
updated: '2023-09-25 15:17:58'
excerpt: 如果图床选用GitHub，建议不要cdn加速，图片链接直接用原本链接，起码能保证图片不失效。
tags:
  - Github
  - 图床
categories:
  - 技术博客
comments: true
toc: true
---

# 【Github】cdn jsdelivr加速使用方法

> 前排
>
> * 2022 年 4 月 28 日遭到 DNS 污染，自此大陆无法正常访问 jsDelivr，导致大批网站工作失常。jsDelivr 进出大陆的始末详见 [【杂谈】jsDelivr域名遭到DNS污染](https://luotianyi.vc/6295.html)。
> * 2023 年 9 月 25日发现已可以使用，但是不再推荐使用jsdelivr用来加速图床，如果图床选用GitHub，建议不要cdn加速，图片链接直接用原本链接，起码能保证图片不失效。

## 基本使用方法

​`https://cdn.jsdelivr.net/gh/你的用户名/你的仓库名@branch/文件路径`​

```plaintext
// 加载任何Github发布、提交或分支
https://cdn.jsdelivr.net/gh/user/repo@version/file

// 加载 jQuery v3.2.1
https://cdn.jsdelivr.net/gh/jquery/jquery@3.2.1/dist/jquery.min.js

// 指定仓库的分支
https://cdn.jsdelivr.net/gh/Achuan-2/PicBed@pic

// 使用版本范围而不是特定版本
https://cdn.jsdelivr.net/gh/jquery/jquery@3.2/dist/jquery.min.js   https://cdn.jsdelivr.net/gh/jquery/jquery@3/dist/jquery.min.js
 
// 完全省略该版本以获取最新版本
https://cdn.jsdelivr.net/gh/jquery/jquery/dist/jquery.min.js
 
// 将“.min”添加到任何JS/CSS文件中以获取缩小版本，如果不存在，将为会自动生成
https://cdn.jsdelivr.net/gh/jquery/jquery@3.2.1/src/core.min.js
 
// 在末尾添加 / 以获取资源目录列表
https://cdn.jsdelivr.net/gh/jquery/jquery/
```

## 注意：

* **jsDelivr 不支持加载超过 20M 的资源**
* jsDelivr 只要加载过一次后，就会永久缓存，就算源码、原图片**被删除，还是能加载**！(好处是不怕丢，坏处是删不掉 😳）
* 版本号不是必需的，是为了区分新旧资源，如果不使用版本号，将会直接引用最新资源

## 补充：

> ‍
>
> CDN 是一组分布在多个不同地方的 WEB 服务器，可以更加有效的向用户提供资源，会根据距离的远近来选择 。使用户能就近的获取请求数据，解决网络拥堵，提高访问速度，解决由于网络带宽小，用户访问量大，网点分布不均等原因导致的访问速度慢的问题。
>
> **cdn 请求分发原理**
>
> ![image.png](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202309251517459.png)
>
> （1）用户向浏览器提供需要访问的域名；
>
> （2）浏览器调用域名解析库对域名进行解析，由于 CDN 对域名解析过程进行了调整，所以解析函数库一般得到的是该域名对应的 CNAME 记录，为了得到实际的 IP 地址，浏览器需要再次对获得的 CNAME 域名进行解析以得到实际的 IP 地址；在此过程中，使用的全局负载均衡 DNS 解析。如根据地理位置信息解析对应的 IP 地址，使得用户能就近访问；
>
> （3）此次解析得到 CDN 缓存服务器的 IP 地址，浏览器在得到实际的 ip 地址之后，向缓存服务器发出访问请求；
>
> （4）缓存服务器根据浏览器提供的要访问的域名，通过 Cache 内部专用 DNS 解析得到此域名的实际 IP 地址，再由缓存服务器向此实际 IP 地址提交访问请求；
>
> （5）缓存服务器从实际 IP 地址得到内容以后，一方面**在本地进行保存**，以备以后使用，二方面把获取的数据放回给客户端，完成数据服务过程；
>
> （6）客户端得到由缓存服务器返回的数据以后显示出来并完成整个浏览的数据请求过程。

‍
