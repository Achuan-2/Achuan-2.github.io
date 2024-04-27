---
title: Matlab 如何用二维mask给三维矩阵批量赋值
date: '2023-11-05 00:34:33'
updated: '2023-11-05 17:00:31'
excerpt: >-
  这篇博客介绍了如何将二维的ROI mask转化为有颜色的ROI
  mask。提供了两种解决方案。第一种是已知ROI的整体位置信息，可以直接利用逻辑矩阵的位置信息给三维矩阵赋值，实现批量填充颜色。第二种是只知道每个点的坐标位置，可以通过循环或者sub2ind函数将坐标转化为线性索引，然后进行批量赋值。此外，如果希望填充整个ROI区域而不是轮廓，可以使用poly2mask函数将ROI轮廓转化为ROI
  mask。
tags:
  - Matlab
categories:
  - 其他笔记
permalink: >-
  post/how-does-matlab-give-the-rgb-image-specified-area-and-assign-the-color-in-batches-i1rsr.html
comments: true
toc: true
abbrlink: 2de03d23
---



## 需求

我通过细胞分割，得到二维的 roi mask，需要转化为有颜色的 roi mask，即需要把一个个 roi 所在的位置加上随机颜色，有颜色就代表生成的图片会是 RGB 三通道，就需要用二维矩阵的位置信息给三维矩阵赋值。

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311051152061.png)​​

## 解决方案

### 已知 roi 的整体位置信息

二维矩阵通过传入逻辑矩阵，就可以赋值给对应的位置，例如：

```matlab
>> a == 3

ans =

  3×3 logical 数组

   0   0   1
   1   1   1
   0   1   0


>> a(a == 3) =0

a =

     1     2     0
     0     0     0
     4     0     4

```

对于 RGB 图像这样的三维矩阵而言，同样可以。

```matlab
color_mask = zeros([size(mask), 3], 'single');

% 获取指定roi的位置，其所在位置在mask中的取值会是逻辑1
roi_position = (mask == 1);
% 把二维的逻辑矩阵变为三维的逻辑矩阵，即在第三维复制三层
roi_3D = repmat(roi_position,1,1,3);

% 这样就可以获取到RGB图像上所有指定的位置上的值了
color_mask(roi_3D)
```

如果是要批量同时给三个通道加上 RGB 三个颜色，可以将 1×3 的 RGB 颜色复制 n 个，n=roi 像素数目，就可以实现批量给三个通道赋值！

```matlab
% 这样就可以直接给RGB图像进行批量赋颜色了
color_mask(roi_3D) = repmat(rand(1,3)*255,sum(roi_position,'all'),1); 
```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050245716.png "给空RGB的指定roi区域涂上随机颜色")​

如果是只给一个通道赋值或某两个赋值，用二维roi mask 就可以，不需要转化为 3d mask，见下面的简单示例：

```matlab
% 创建示例二维矩阵 masks 和三维矩阵 three
masks = [1, 2, 1; 2, 2, 1; 1, 1, 2];
HSV = cat(3, [1, 2, 3; 4, 5, 6; 7, 8, 9], [10, 11, 12; 13, 14, 15; 16, 17, 18], [19, 20, 21; 22, 23, 24; 25, 26, 27]);

% 获取 masks 中值为 2 的位置
mask_indices = masks == 2;

HSV(:,:,1) = HSV(:,:,1) .* ~mask_indices + 0.3 * mask_indices; % 第二层赋值为0.3
HSV(:,:,2) = HSV(:,:,2) .* ~mask_indices + 0.4 * mask_indices; % 第二层赋值为0.4
```

> ​`HSV(:,:,1) .* ~mask_indices` ​的作用是 roi 区域变为 0，然后再加 `0.3 * mask_indices`​，就可以实现单通道的批量赋值

### 只知道每个点坐标位置

手动圈选 roi，我只能得到单个 stoke 中每个点的坐标信息，该如何变为 roi 的 outline，在 RGB 图像上绘制颜色呢？

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050242439.png "手动圈选的ROI只有每个点的坐标信息")​​

也可以参考上面的做法，先是通过循环根据每个点的坐标信息给空二维 mask 填入 1，这样得到一个 roi 位置矩阵后，将其转化维三维矩阵，即可通过索引赋值实现需求。

另外一个不用循环的做法是利用 sub2ind 函数，批量把一系列坐标变为线性索引，从而实现批量赋值

```matlab
outline = zeros(size(mask), 'single');
linearIndices = sub2ind(size(outline), round(stroke(:, 2)),round(stroke(:, 1)));
outline(linearIndices) = 1;
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050139194.png "使用sub2ind可以把坐标批量变为线性索引，从而实现批量赋值")​

之所以要用sub2ind，而不是直接 `outline(round(stroke(:, 2)),round(stroke(:, 1)))`​，是因为matlab 索引传入列表的时候会认为你要提取子矩阵，而不是对应索引的的几个点

```matlab
>> a = rand(3,3)

a =

    0.5752    0.3532    0.0430
    0.0598    0.8212    0.1690
    0.2348    0.0154    0.6491

>> b = a([1,2],[2,2]) # 返回的值并不是以为的(1,2),(2,2)两个点，而是得到第一行到第二行的第二列，由于第二个维度输入了两个2，重复返回第二列的值，于是得到四个点

b =

    0.3532    0.3532
    0.8212    0.8212
```

如果希望填充的是 roi 的整个区域，而不是 roi 轮廓，可以使用 poly2mask，可以直接把 roi 轮廓变为 mask

```matlab
img_size = size(mask);
roi_mask = poly2mask(stroke(:,1), stroke(:,2),img_size(1),img_size(2));
```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050113082.png "poly2mask，可以直接把roi轮廓变为roi")​

## 总结

这篇博客介绍了如何将二维的 ROI mask 转化为有颜色的 ROI mask。提供了两种解决方案。第一种是已知 ROI 的整体位置信息，可以直接利用逻辑矩阵的位置信息给三维矩阵赋值，实现批量填充颜色。第二种是只知道每个点的坐标位置，可以通过循环或者 sub2ind 函数将坐标转化为线性索引，然后进行批量赋值。此外，如果希望填充整个 ROI 区域而不是轮廓，可以使用 poly2mask 函数将 ROI 轮廓转化为 ROI mask。

‍

‍

## Ref

* [【Matlab】如何提取矩阵中特定位置的元素？_matlab sub2ind 提取矩阵中每一行的特定元素-CSDN博客](https://blog.csdn.net/YaoYee_21/article/details/110248515)

‍

‍

‍
