---
title: Matlab 如何正确把图像转为uint8
date: '2023-11-05 16:33:16'
updated: '2023-11-05 16:46:14'
excerpt: >-
  虽然官方函数有`im2uint8`，然而这个函数只适用于double类型范围在0~1的数组。需要先把数据归一化到0~1，再用im2uint8，才能把原图的灰度值从[0，1]映射到[0,255]
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
---



虽然官方函数有`im2uint8`​，然而这个函数只适用于double类型范围在0~1的数组。

如果矩阵数据图像是double类型（0\~1之间）可直接im2uint8，这样不仅完成数据类型转换，而且将0\~1之间映射为了0\~255之间的数据。但是如果图像矩阵数据是double类型的0\~255，直接im2uint8转换的话，matlab会将大于1的数据都转换为255，0\~1之间的数据才会映射到0\~255之间整型的数据

```matlab
>> im = [1,2,3;4,5,6]

im =

     1     2     3
     4     5     6
>> im2uint8(im)

ans =

  2×3 uint8 matrix

   255   255   255
   255   255   255

```

需要先把数据归一化到0\~1，再用im2uint8，才能把原图的灰度值从[0，1]映射到[0,255]

1. ​`mat2gray`​​ 将数据归一化到0\~1
2. ​`im2uint8`​将归一化后的0\~1，映射为[0,255]

```matlab
>> im2uint8(mat2gray(double(im)))

ans =

  2×3 uint8 matrix

     0    51   102
   153   204   255
```

## 总结

虽然官方函数有`im2uint8`​，然而这个函数只适用于double类型范围在0~1的数组。需要先把数据归一化到0\~1，再用im2uint8，才能把原图的灰度值从[0，1]映射到[0,255]

‍

## Ref

* [对数变换中，im2uint8(mat2gray(g))怎样理解？ – MATLAB中文论坛 (ilovematlab.cn)](https://www.ilovematlab.cn/thread-306187-1-1.html?_dsign=c5f24f59)
* [MATLAB mat2gray - MathWorks 中国](https://ww2.mathworks.cn/help/images/ref/mat2gray.html?requestedDomain=cn)
* [MATLAB im2uint8 - MathWorks 中国](https://ww2.mathworks.cn/help/images/ref/im2uint8.html?requestedDomain=cn)

‍
