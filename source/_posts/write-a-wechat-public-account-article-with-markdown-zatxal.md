---
title: 用Markdown写微信公众号文章
date: '2024-04-27 19:03:14'
updated: '2024-04-27 19:12:13'
excerpt: 折腾一下午魔改别人的编辑器，使其支持Markdown的图片title可以变为图注（为什么大家都这么喜欢用anchor text呢，叹气）
tags:
  - 微信公众号
  - 博客
  - 折腾
  - 编程
  - 前端
categories:
  - 其他笔记
permalink: /post/write-a-wechat-public-account-article-with-markdown-zatxal.html
comments: true
toc: true
abbrlink: 352a956b
---





现有的Markdown转公众号文章编辑器都挺完善的，有些还加了超链接转脚注功能，因为微信规定了订阅号是不能使用指向外链的超链接的，只能用链接微信文章。但是找来找去，感觉大部分的编辑器只支持Markdown图片的锚文本转图注，却不支持图片title可以转为图注，而后者是目前语雀、思源笔记添加图注使用的语法。

于是折腾一下午魔改别人的编辑器，使其支持Markdown的图片title可以变为图注（为什么大家都这么喜欢用anchor text呢，叹气），这样我思源笔记的内容就可以直接粘贴上去不需要修改，直接发公众号了。

还把两个repo都部署到Github Page了，就可以打开链接直接在线用了（主要方便我自己用哈哈哈）。

## 编辑器1

Github：[https://github.com/Achuan-2/markdown2wechat](https://github.com/Achuan-2/markdown2wechat)

在线使用：[https://achuan-2.github.io/markdown2wechat/](https://achuan-2.github.io/markdown2wechat/)

​![Clip_2024-04-27_19-04-07](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-04-27_19-04-07-20240427190409-3nqxluz.png)​

## 编辑器2

Github：[https://github.com/Achuan-2/wechat-mdeditor](https://github.com/Achuan-2/wechat-mdeditor)

在线使用：[https://achuan-2.github.io/wechat-mdeditor/](https://achuan-2.github.io/wechat-mdeditor/)

​![Clip_2024-04-27_19-05-58](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-04-27_19-05-58-20240427190601-23fa31i.png)​

‍
