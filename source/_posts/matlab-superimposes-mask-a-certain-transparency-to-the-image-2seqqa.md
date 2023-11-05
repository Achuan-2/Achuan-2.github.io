---
title: Matlab 把 mask 一定透明度叠加到图像上
date: '2023-11-05 10:42:56'
updated: '2023-11-05 10:42:58'
excerpt: 如何使用Matlab在图片上叠加上roi mask
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
---



## 方法一：直接把mask写入im

先把im转化为hsv图像，然后mask 只加载在saturation通道，saturation越低，透明度越低

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

在Figure上显示底下的图片，然后hold on在画一张，利用imshow的handles可以设置AlphaData，只设置roi区域有一定透明度，空白区域AlphaData设置为0。从而实现对比度叠加

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

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311050235471.png "使用imshow绘制两层，调整顶层mask透明度，实现图片叠加")​

‍

‍

> ⚠使用imshow的CData更改图像，scale不会改变……所以是需要让两张图片的最大灰度值相差不大的，比如都设置成255. 如果一个最大灰度值是255，一个最大灰度值只是1，就会导致图片过曝惨白一片。

‍
