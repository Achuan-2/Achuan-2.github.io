---
title: Matlab 如何给RGB图像指定区域批量赋值颜色
date: '2023-11-05 00:34:33'
updated: '2023-11-05 01:13:34'
excerpt: >-
  这篇博客介绍了如何将二维的ROI mask转化为有颜色的ROI
  mask。提供了两种解决方案。第一种是已知ROI的整体位置信息，可以直接利用逻辑矩阵的位置信息给三维矩阵赋值，实现批量填充颜色。第二种是只知道每个点的坐标位置，可以通过循环或者sub2ind函数将坐标转化为线性索引，然后进行批量赋值。此外，如果希望填充整个ROI区域而不是轮廓，可以使用poly2mask函数将ROI轮廓转化为ROI
  mask。
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
---



## 需求

我通过细胞分割，得到二维的 roi mask，需要转化为有颜色的 roi mask，即需要把一个个 roi 所在的位置加上随机颜色，有颜色就代表生成的图片会是 RGB 三通道，就需要用二维矩阵的位置信息给三维矩阵赋值。

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050139768.png)​​

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

对于 RGB 图像这样的三维矩阵而言，同样可以

```matlab
color_mask = zeros([size(mask), 3], 'single');

% 获取指定roi的位置，其所在位置在mask中的取值会是逻辑1
roi_position = (mask == 1);
% 把二维的逻辑矩阵变为三维的逻辑矩阵，即在第三维复制三层
roi_3D = repmat(roi_position,1,1,3);

% 这样就可以直接给RGB图像进行批量赋颜色了
color_mask(roi_3D) = repmat(rand(1,3)*255,sum(roi_position,'all'),1); 
```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050139457.png "给空RGB的指定roi区域涂上随机颜色")​

### 只知道每个点坐标位置

手动圈选 roi，我只能得到单个 stoke 中每个点的坐标信息，该如何变为 roi 的 outline，在 RGB 图像上绘制颜色呢？

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050139159.png "手动圈选的ROI只有每个点的坐标信息")​​

也可以参考上面的做法，先是通过循环根据每个点的坐标信息给空二维 mask 填入 1，这样得到一个 roi 位置矩阵后，将其转化维三维矩阵，即可通过索引赋值实现需求。

另外一个不用循环的做法是利用 sub2ind 函数，批量把一系列坐标变为线性索引，从而实现批量赋值

```matlab
outline = zeros(size(mask), 'single');
linearIndices = sub2ind(size(outline), round(stroke(:, 2)),round(stroke(:, 1)));
outline(linearIndices) = 1;
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050139194.png "使用sub2ind可以把坐标批量变为线性索引，从而实现批量赋值")​​

如果希望填充的是 roi 的整个区域，而不是 roi 轮廓，可以使用 poly2mask，可以直接把 roi 轮廓变为 mask

```matlab
img_size = size(mask);
roi_mask = poly2mask(stroke(:,1), stroke(:,2),img_size(1),img_size(2));
```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050113082.png "poly2mask，可以直接把roi轮廓变为roi")​

## 总结

这篇博客介绍了如何将二维的ROI mask转化为有颜色的ROI mask。提供了两种解决方案。第一种是已知ROI的整体位置信息，可以直接利用逻辑矩阵的位置信息给三维矩阵赋值，实现批量填充颜色。第二种是只知道每个点的坐标位置，可以通过循环或者sub2ind函数将坐标转化为线性索引，然后进行批量赋值。此外，如果希望填充整个ROI区域而不是轮廓，可以使用poly2mask函数将ROI轮廓转化为ROI mask。
