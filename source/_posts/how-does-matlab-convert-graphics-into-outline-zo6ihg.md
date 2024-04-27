---
title: Matlab 如何将图形转化为轮廓
date: '2023-11-12 19:04:18'
updated: '2023-11-12 19:04:20'
excerpt: Matlab 自带 bwboundaries 函数，能够解析图形，返回图片上所有图形的轮廓
tags:
  - Matlab
categories:
  - 其他笔记
permalink: post/how-does-matlab-convert-graphics-into-outline-zo6ihg.html
comments: true
toc: true
abbrlink: 10c2a2a8
---



Matlab 自带 bwboundaries 函数，能够解析图形，返回图片上所有图形的轮廓

## 代码

```matlab
function outline = mask_to_outline(mask)
    % mask_to_outline : convert roi mask to outline mask
    arguments (Input)
        mask (:,:) double
    end
    arguments (Output)
        outline (:,:) logical
    end
    B = bwboundaries(mask==1, 'holes'); % 获取不连通区域的边界

    % 初始化一个空矩阵来存储所有轮廓点
    numBoundaries = length(B);
    totalPoints = 0;
    for k = 1:numBoundaries
        totalPoints = totalPoints + size(B{k}, 1);
    end
    allBoundaries = zeros(totalPoints, 2);

    % 遍历每个不连通区域的边界
    currentIndex = 1;
    for k = 1:numBoundaries
        boundary = B{k};
        % 将当前区域的轮廓点添加到allBoundaries矩阵中
        boundarySize = size(boundary, 1);
        allBoundaries(currentIndex:currentIndex+boundarySize-1, :) = boundary;
        currentIndex = currentIndex + boundarySize;
    end
  
    % 将轮廓坐标转换为outline mask
    outline = zeros(size(mask));
    linearIndices = sub2ind(size(outline),allBoundaries(:, 1), allBoundaries(:, 2));
    outline(linearIndices) = 1;
end
```

> ℹ 这里展示的代码会把所有孔洞的轮廓都返回，如果只想要求闭合轮廓则是 `bwboundaries(I, 'noholes');`​

## 结果展示

原来的 mask 图

​​![fudan](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311121904150.png)​​

得到的outline图

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311121904669.png)​

## Ref

* [【精选】MatLab求取多个闭合区域的轮廓、面积和bbox_matlab boundingbox-CSDN博客](https://blog.csdn.net/qq_31347869/article/details/102881985)
