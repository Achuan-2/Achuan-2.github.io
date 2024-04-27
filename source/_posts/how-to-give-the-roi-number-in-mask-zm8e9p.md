---
title: Matlab 如何给 mask 里的 ROI 编号
date: '2023-11-14 10:32:26'
updated: '2023-11-14 16:13:11'
excerpt: Matlab 有内置函数bwlabel 可以给二值化图像，根据区域的连通性进行编号
tags:
  - Matlab
  - 编程
categories:
  - 其他笔记
permalink: /post/how-to-give-the-roi-number-in-mask-zm8e9p.html
comments: true
toc: true
abbrlink: 1ce9994b
---



Matlab 有内置函数[bwlabel](https://ww2.mathworks.cn/help/images/ref/bwlabel.html) 可以给二值化图像，根据区域的连通性进行编号

```matlab
% 创建二值图像
>> BW = logical ([1     1     1     0     0     0     0     0
               1     1     1     0     1     1     0     0
               1     1     1     0     1     1     0     0
               1     1     1     0     0     0     1     0
               1     1     1     0     0     0     1     0
               1     1     1     0     0     0     1     0
               1     1     1     0     0     1     1     0
               1     1     1     0     0     0     0     0]);

% 使用 4 连通对象创建标签矩阵
>> L = bwlabel(BW,4)

L =

     1     1     1     0     0     0     0     0
     1     1     1     0     2     2     0     0
     1     1     1     0     2     2     0     0
     1     1     1     0     0     0     3     0
     1     1     1     0     0     0     3     0
     1     1     1     0     0     0     3     0
     1     1     1     0     0     3     3     0
     1     1     1     0     0     0     0     0
```

* [对二维二值图像中的连通分量进行标注 - MATLAB bwlabel - MathWorks 中国](https://ww2.mathworks.cn/help/images/ref/bwlabel.html)
