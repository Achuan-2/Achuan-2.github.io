---
title: Matlab 把 ROI mask 以一定透明度叠加到黑白图像上
date: '2023-11-05 18:55:30'
updated: '2023-11-05 18:55:32'
excerpt: >-
  本文主要介绍了两种将遮罩图像叠加在原始图像上的方法。第一种方法是将遮罩信息直接写入原始图像的HSV通道中，通过调整饱和度来控制透明度。第二种方法是使用imshow函数在图像上显示遮罩区域，并设置透明度。这些方法可以有效实现图像叠加效果。
tags:
  - Matlab
categories:
  - 其他笔记
permalink: post/matlab-superimposes-mask-a-certain-transparency-to-the-image-2seqqa.html
comments: true
toc: true
abbrlink: 99fd534
---



## 方法一：直接把mask写入im

先把im转化为hsv图像，由于是黑白图，即把黑白图的灰度值赋给hsv的v通道。

然后mask 信息只加载在saturation通道，saturation越低，透明度越低。

```matlab
function converted_im = mask_overlay_im(im,mask)
    % 把mask叠加到图像上

    im = single(im);
    HSV = zeros([size(im), 3], 'single');

    if max(im(:)) > 1
        v = im / 255;
    else
        v= im;
    end

    HSV(:,:,3) = v; % value

    n_roi = max(mask(:));
    hues = linspace(0, 1, n_roi+1);
    hues = hues(randperm(n_roi));

    for n = 1:max(mask(:))
        mask_indices = (mask == n);
        HSV(mask_indices) = hues(n); % hue
        HSV(:,:,2) = HSV(:,:,2) .* ~mask_indices +  0.4*mask_indices; % saturation
    end

    converted_im = uint8(hsv2rgb(HSV) * 255);
end

```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311051042778.png "将图片转化为hsv后，将roi信息写入saturation通道，实现图片叠加")​

## 方法二：使用imshow

在Figure上显示底下的图片，然后hold on在画一张，利用imshow的handles可以设置AlphaData，只设置roi区域有一定透明度，空白区域AlphaData设置为0，从而实现图像叠加。

```matlab
% test mask overlay to image
colored_mask = mask_to_rgb(matlab_mask);
binary_mask = matlab_mask>0;


figure
imshow(im,[])
hold on 
alpha = 0.3;
h = imshow(colored_mask,[])
h.AlphaData=binary_mask*alpha;
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311051133051.png "使用imshow绘制两层，调整顶层mask透明度，实现图片叠加")​

> ⚠注意：使用imshow的CData更改图像，scale不会改变……所以是需要让两张图片的最大灰度值相差不大的，比如都设置成255. 如果一个最大灰度值是255，一个最大灰度值只是1，就会导致图片过曝惨白一片。

‍
