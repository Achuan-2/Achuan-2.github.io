---
title: Matlab reshape 按列扫描、按列填充——容易踩坑
date: '2023-11-12 22:47:50'
updated: '2023-11-12 22:47:52'
excerpt: Matlab 的 reshape 会先将输入数据按列扫描变为一维列向量，输出数据则是根据列向量逐列填充。在转换数据时如果不注意这一点很容易踩坑！
tags:
  - Matlab
categories:
  - 技术博客
permalink: >-
  post/matlab-reshape-scan-and-fill-in-columns-easy-to-step-on-the-pit-18flah.html
comments: true
toc: true
abbrlink: e4891e75
---



> Matlab 的 reshape 会先将输入数据按列扫描变为一维列向量，输出数据则是根据列向量逐列填充。在转换数据时如果不注意这一点很容易踩坑！

## 官方文档

```matlab
 reshape - 重构数组
    此 MATLAB 函数 使用大小向量 sz 重构 A 以定义 size(B)。例如，reshape(A,[2,3]) 将
    A 重构为一个 2×3 矩阵。sz 必须至少包含 2 个元素，prod(sz) 必须与 numel(A) 相同。

    B = reshape(A,sz)
    B = reshape(A,sz1,...,szN)

    输入参数
        A - 输入数组
            向量 | 矩阵 | 多维数组
        sz - 输出大小
            由整数组成的行向量
        sz1,...,szN - 每个维度的大小
            两个或以上的整数 | []（可选）

    输出参数
        B - 重构的数组
            向量 | 矩阵 | 多维数组 | 元胞数组
```

> [MATLAB 官方文档：reshape](https://ww2.mathworks.cn/help/matlab/ref/reshape.html)

## 使用笔记

第一次使用reshape的时候，没注意到它是按列获取数据的，再进行重构矩阵的，掉入坑中

```matlab
>> A = 1:6

A =

     1     2     3     4     5     6  

>> reshape(A,2,3)

ans =

     1     3     5
     2     4     6
```

如果要把1d数组变为2d数组，并且希望它是按行进行重构数组的，就需要把转化后的行和列进行调换，再把reshape后的数组进行转置

```matlab
>> B = reshape(A,3,2)'

ans =

     1     2     3
     4     5     6
```

如果是想要把2d数组变为1d数组，并且希望是按行提取数据的，就需要先把矩阵转置，再用reshape

```matlab
>> B

B =

     1     2     3
     4     5     6

>> reshape(B,1,[])

ans =

     1     4     2     5     3     6

>> reshape(B',1,[])

ans =

     1     2     3     4     5     6

```

​

## Ref

* [MATLAB 官方文档：reshape](https://ww2.mathworks.cn/help/matlab/ref/reshape.html)
* [Reshape函数顺序解析-Matlab - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/344941033)

  ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311122247705.png)​
