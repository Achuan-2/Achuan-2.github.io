---
title: 震惊！git支持直接查看word的内容修改了，可以用git来做论文版本管理了
date: '2025-03-05 16:16:12'
updated: '2025-03-05 17:21:58'
excerpt: >-
  我记得之前git是不方便版本控制word的，因为word本质上是压缩包，看不了diff内容（网上有教怎么使用git+pandoc来查看diff内容，但是不是很方便）


  今天在进一步学习git操作的时候（之前只会简单的commit和push，今天学习下branch，方便软件开发不知道能不能用的dev功能，不搞乱main分支）


  抱着试一试的心态，竟然发现vscode的git commit历史可以直接查看不同commit里word改动的纯文本内容！


  这下用git来版本控制论文不再是梦了！
categories:
  - 研究生的自我修养
permalink: >-
  /post/shock-git-supports-directly-viewing-word-content-modifications-and-you-can-use-git-for-paper-version-management-z1r4tac.html
comments: true
toc: true
---





​![0_B战封面制作](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/0_B%E6%88%98%E5%B0%81%E9%9D%A2%E5%88%B6%E4%BD%9C-20250305163244-wboyy7s.png)​

我记得之前git是不方便版本控制word的，因为word本质上是压缩包，看不了diff内容（网上有教怎么使用git+pandoc来查看diff内容，但是不是很方便）

今天在进一步学习git操作的时候（之前只会简单的commit和push，今天学习下branch，方便软件开发不知道能不能用的dev功能，不搞乱main分支）

抱着试一试的心态，竟然发现vscode的git commit历史可以直接查看不同commit里word改动的纯文本内容！

这下用git来版本控制论文不再是梦了！

> 暂时不知道是不是我安装了插件，还是git或者vscode自带的功能
>
> * 20250305 发现本地git就可以查看word修改内容
>
>   ​![PixPin_2025-03-05_17-21-45](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-05_17-21-45-20250305172152-dwzvz5s.png)​

**可以直接显示纯文本内容**

​![PixPin_2025-03-05_15-55-11](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-05_15-55-11-20250305155514-r7ymodp.png)​

​![PixPin_2025-03-05_15-54-55](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-05_15-54-55-20250305155456-6awcij1.png)​

**可以使用checkout(detached)来查看不同commit的word文件**

​![PixPin_2025-03-05_15-57-10](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-05_15-57-10-20250305155711-d0lknos.png)​

​![PixPin_2025-03-05_16-15-06](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-05_16-15-06-20250305161507-hqk83a6.png)​

**如果要word回退到某个commit中的版本，可以使用下面命令（暂时找不到GUI界面来操作）**

```bash
# 使用 git checkout 回退指定文件
# git checkout <commit-hash> -- <file-path>
git checkout c49e483c6fd150335c7d55d3f943d63f586067f6 -- git测试word版本管理.docx
```

不过checkout之后，直接复制粘贴之前的版本文件也不是不行（嘿嘿）
