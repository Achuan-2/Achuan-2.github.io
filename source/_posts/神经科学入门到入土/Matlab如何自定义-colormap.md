---
title: Matlab 如何自定义colormap
date: '2025-04-28 15:47:57'
updated: '2025-04-28 16:08:18'
excerpt: |-
  之前分享过matlab自定义lut来显示显微图片的文章
  这次分享下matlab如何自定义colormap、如何单独展示colormap以及最后分享自己的colormap github地址。
categories:
  - 神经科学入门到入土
permalink: /post/how-to-customize-colormap-in-matlab-z2krip8.html
comments: true
toc: true
---



之前分享过matlab自定义lut来显示显微图片的文章（[matlab自定义lut，用于展示显微图片，得到colorbar](https://mp.weixin.qq.com/s/ked921GhAoH4KSyFVRCz5w)）

这次分享下matlab如何自定义colormap、如何单独展示colormap以及最后分享自己的colormap github地址。

## Matlab 如何自定义colormap

确定好最低值到最大值要使用的颜色，比如这里设置最低值使用青色，最大值使用橙色，中间值使用白色。

```matlab
colors = [13,135,169;...
    255,255,255;...
    239,139,14] ./ 255;
```

进行插值

```matlab
% Use linear interpolation to create the colormap
x = linspace(0, 1, size(colors, 1)); % 原来的数量
n = 256; 
xi = linspace(0, 1, n); % 插值的数量
cm = interp1(x, colors, xi, 'linear');
```

绘制这个colormap

```matlab
f=figure;
f.Position(3)=30;
f.Position(4)= 450;
n=256;
imagesc((n:-1:1)');
set(gca, 'YTick', [], 'XTick', []);

colormap(cm);
```

![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151253-onen53w.png)​

全部代码

```matlab
colors = [13,135,169;...
    255,255,255;...
    239,139,14] ./ 255;
% Use linear interpolation to create the colormap
x = linspace(0, 1, size(colors, 1)); % 原来的数量
n = 256; 
xi = linspace(0, 1, n); % 插值的数量
cm = interp1(x, colors, xi, 'linear');

f=figure;
f.Position(3)=30;
f.Position(4)= 450;
n=256;
imagesc((n:-1:1)');
set(gca, 'YTick', [], 'XTick', []);

colormap(cm);
```

‍

其他例子

- 最亮为绿色，最暗为黑色的colormap

  ```matlab
  colors = [0 ,0,0;0,255,0;] ./ 255;
  % Use linear interpolation to create the colormap
  x = linspace(0, 1, size(colors, 1)); % 原来的数量
  n = 256; 
  xi = linspace(0, 1, n); % 插值的数量
  cm = interp1(x, colors, xi, 'linear');

  f=figure;
  f.Position(3)=30;
  f.Position(4)= 450;
  n=256;
  imagesc((n:-1:1)');
  set(gca, 'YTick', [], 'XTick', []);

  colormap(cm);
  ```

  ![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151442-8s8r2b4.png)​
- 最亮为红色，最暗为蓝色的colormap

  深色版本

  ```matlab
  colors = [0,0,255;...
      255,255,255;...
      255,0,0] ./ 255;

  % Use linear interpolation to create the colormap
  x = linspace(0, 1, size(colors, 1)); % 原来的数量
  n = 256; 
  xi = linspace(0, 1, n); % 插值的数量
  cm = interp1(x, colors, xi, 'linear');

  f=figure;
  f.Position(3)=30;
  f.Position(4)= 450;
  n=256;
  imagesc((n:-1:1)');
  set(gca, 'YTick', [], 'XTick', []);

  colormap(cm);
  ```

  ![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151526-oup7pvv.png)​

  淡色版本

  ```matlab
  colors = [130,130,255;...
      255,255,255;...
      255,133,133] ./ 255;

  % Use linear interpolation to create the colormap
  x = linspace(0, 1, size(colors, 1)); % 原来的数量
  n = 256; 
  xi = linspace(0, 1, n); % 插值的数量
  cm = interp1(x, colors, xi, 'linear');

  f=figure;
  f.Position(3)=30;
  f.Position(4)= 450;
  n=256;
  imagesc((n:-1:1)');
  set(gca, 'YTick', [], 'XTick', []);

  colormap(cm);
  ```

  ![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151459-yu39hzr.png)​
- 最亮为黄色，中间为绿色，最暗为黑色

  ```matlab
  colors = [0,0,0;...
      0,255,0;...
      255,255,0] ./ 255;

  % Use linear interpolation to create the colormap
  x = linspace(0, 1, size(colors, 1)); % 原来的数量
  n = 256; 
  xi = linspace(0, 1, n); % 插值的数量
  cm = interp1(x, colors, xi, 'linear');

  f=figure;
  f.Position(3)=30;
  f.Position(4)= 450;
  n=256;
  imagesc((n:-1:1)');
  set(gca, 'YTick', [], 'XTick', []);

  colormap(cm);
  ```

  ![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428152834-f4vjsx0.png)​

‍

## Matlab 如何单独绘制colormap

绘制单个，竖着

```matlab
f=figure;
f.Position(3)=30;
f.Position(4)= 450;
n=256;
imagesc((n:-1:1)');
set(gca, 'YTick', [], 'XTick', []);

colormap(jet);

```

![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151553-rnzmtj7.png)​

横着

```matlab
f=figure;
f.Position(3)=450;
f.Position(4)= 60;
n=256;
imagesc(1:n);
set(gca, 'YTick', [], 'XTick', []);

colormap(jet);

```

![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151919-z9wvpbj.png)​

绘制多个colormap

```matlab
cmapNames = {"parula","turbo","hsv","hot","cool","spring","summer","autumn","winter"};
numCmaps = length(cmapNames);
n = 256; % 固定颜色条长度

% 创建新图形窗口
allCmapFig = figure('Name', 'All Colormaps Preview', ...
    'NumberTitle', 'off', ...
    'Position', [200, 50, 300, 900]); % 调整窗口大小和位置
    
% 计算子图布局
rows = numCmaps;
cols = 1;

for i = 1:numCmaps
    % 创建子图
    ax = subplot(rows, cols, i, 'Parent', allCmapFig);
    
    % 生成颜色映射表
    cmapName = cmapNames{i};
    
    % 显示横着的颜色条
    imagesc(ax, 1:n);
    colormap(ax, cmapName);
    set(ax, 'YTick', [], 'XTick', []);
    ylabel(ax, cmapName, 'FontSize', 12,"Rotation",0,"HorizontalAlignment","right",'VerticalAlignment','middle');
end


```

![colormap](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/colormap-20250428151716-xmexoin.png)​

‍

## 我用的自定义Colormap

在Github上开源了自己用的colormap，

reppo地址：[Achuan-2/mycolormap](https://github.com/Achuan-2/mycolormap/tree/main)

会随着使用慢慢增加实用的colormap

### 预览

内置了预览功能

```matlab
mycolormap.preview
```

![PixPin_2025-04-01_15-34-51](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-01_15-34-51-20250401153454-i889qco.png)

目前全部的colormap

![image](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/image-20250428154653-rdyjp48.png)

### 使用

```matlab
f=figure;


% 创建示例数据
data = peaks(150); % 示例数据，可替换为你的数据

% 绘制图像
imagesc(data);
colormap(mycolormap.bwr); % 应用自定义 colormap
colorbar; % 显示颜色条

```

![image](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/image-20250428154737-4wborde.png)
