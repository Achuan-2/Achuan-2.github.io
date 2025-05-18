---
title: Matlab bug丨2023b app designer 的组件propery设置为空白如何解决
date: '2025-05-18 01:01:23'
updated: '2025-05-18 09:58:56'
categories:
  - 编程笔记
permalink: >-
  /post/matlab-buggun-how-to-solve-the-problem-of-setting-the-component-property-of-the-2023b-app-designer-to-blank-wlnge.html
comments: true
toc: true
---





![image](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/image-20250518095557-srdf09i.png)

前往`C:\Users\Achuan-2\AppData\Roaming\MathWorks\MATLAB\R2023b`​

删除下面文件

- inspectorProxyViewMapCache_zh_CN.mat
- inspectorProxyViewMapCache_en_US-zh_CN.mat

重启Matlab之后解决
