---
title: Matlab 深度学习丨使用深度学习对网络摄像头图像进行分类
date: '2024-07-14 17:26:32'
updated: '2024-07-15 10:00:02'
excerpt: >-
  好久没有更Matlab和深度学习的笔记了，这次搬运一波Matlab深度学习的官方示例，使用 GoogleNet 来实时对相机采集的图片进行分类
  立一个flag，以后一周更一篇Matlab和深度学习的笔记。
tags:
  - Matlab
categories:
  - 深度学习
permalink: >-
  /post/matlab-deep-learning-gun-use-deep-learning-to-classify-network-camera-images-kbghh.html
comments: true
toc: true
---



> 好久没有更Matlab和深度学习的笔记了，这次搬运一波Matlab深度学习的官方示例，使用 GoogleNet 来实时对相机采集的图片进行分类 立一个flag，以后一周更一篇Matlab和深度学习的笔记。

## 资料

* 使用深度学习对网络摄像头图像进行分类：[https://ww2.mathworks.cn/help/deeplearning/ug/classify-images-from-webcam-using-deep-learning.html](https://ww2.mathworks.cn/help/deeplearning/ug/classify-images-from-webcam-using-deep-learning.html)

## 总结

* 使用webcam调用相机/网络摄像头进行拍摄获取图片
* 使用 GoogleNet 来对相机得到的图片进行分类
* 为了能够实时调用模型进行分类，使用循环不断获取相机的实时画面

  * 使用`h = figure;while ishandle(h)`​可以通过关闭figure来结束循环，这个Tips可以学习下

## 使用深度学习对网络摄像头图像进行分类

此示例说明如何使用预训练的深度卷积神经网络 GoogLeNet 实时对来自网络摄像头的图像进行分类。

使用 MATLAB®、普通的网络摄像头和深度神经网络来识别周围环境中的对象。此示例使用 GoogLeNet，它是预训练的深度卷积神经网络（CNN 或 ConvNet），已基于超过一百万个图像进行训练，可以将图像分为 1000 个对象类别（例如键盘、咖啡杯、铅笔和多种动物）。您可以下载 GoogLeNet 并使用 MATLAB 实时连续处理相机图像。

GoogLeNet 已基于大量图像学习了丰富的特征表示。它以图像作为输入，然后输出图像中对象的标签以及每个对象类别的概率。您可以用周围的物品进行试验，以了解 GoogLeNet 对图像进行分类的准确程度。要了解有关网络对象分类的详细信息，可以实时显示排名前五的类的分数，而不是只显示最终的类决策。

### 加载相机和预训练网络

连接到相机并加载预训练的 GoogLeNet 网络。您可以在此步骤使用任何预训练网络。该示例需要 MATLAB Support Package for USB Webcams，以及 Deep Learning Toolbox™ Model *for GoogLeNet Network*。如果没有安装所需的支持包，软件会提供下载链接。

```matlab
camera = webcam;
net = googlenet;
```

如果要再次运行该示例，请先运行命令 `clear camera`​，其中 `camera`​ 是与网络摄像头的连接。否则将出现错误，因为您不能创建与同一网络摄像头的另一连接。

### 对相机快照进行分类

要对图像进行分类，必须将其大小调整为网络的输入大小。获取网络的图像输入层的 `InputSize`​ 属性的前两个元素。图像输入层是网络的第一层。

```matlab
inputSize = net.Layers(1).InputSize(1:2)
```

```matlab
inputSize =

   224   224

```

显示来自相机的图像以及预测的标签及其概率。在调用 `classify`​ 之前，必须将图像大小调整为网络的输入大小。

```matlab
figure
im = snapshot(camera);
image(im)
im = imresize(im,inputSize);
[label,score] = classify(net,im);
title({char(label),num2str(max(score),2)});
```

​![](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/ClassifyImagesFromWebcamUsingDeepLearningExample_01-20240714172409-8yhwec3.png)​

### 连续对相机图像进行分类

要连续对相机图像进行分类，请将前面的步骤放入一个循环。在图窗打开时运行该循环。要停止实时预测，只需关闭图窗。在每次迭代结束时使用 `drawnow`​ 更新图窗。

```matlab
h = figure;

while ishandle(h)
    im = snapshot(camera);
    image(im)
    im = imresize(im,inputSize);
    [label,score] = classify(net,im);
    title({char(label), num2str(max(score),2)});
    drawnow
end
```

### 显示排名靠前的预测值

预测出的类可能快速更改。因此，将排名靠前的预测值显示在一起会有所帮助。您可以通过绘制预测分数靠前的类来显示排名前五的预测值及其概率。

对相机的快照进行分类。显示来自相机的图像以及预测的标签及其概率。使用 `classify`​ 函数的 `score`​ 输出显示排名前五的预测值的概率直方图。

创建图窗窗口。首先，调整窗口大小以使宽度增加一倍，并创建两个子图。

```matlab
h = figure;
h.Position(3) = 2*h.Position(3);
ax1 = subplot(1,2,1);
ax2 = subplot(1,2,2);
```

在左侧子图中，将图像和分类显示在一起。

```matlab
im = snapshot(camera);
image(ax1,im)
im = imresize(im,inputSize);
[label,score] = classify(net,im);
title(ax1,{char(label),num2str(max(score),2)});
```

通过选择分数最高的类来选择排名前五的预测值。

```matlab
[~,idx] = sort(score,'descend');
idx = idx(5:-1:1);
classes = net.Layers(end).Classes;
classNamesTop = string(classes(idx));
scoreTop = score(idx);
```

将排名前五的预测值显示为直方图。

```matlab
barh(ax2,scoreTop)
xlim(ax2,[0 1])
title(ax2,'Top 5')
xlabel(ax2,'Probability')
yticklabels(ax2,classNamesTop)
ax2.YAxisLocation = 'right';
```

​![](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/ClassifyImagesFromWebcamUsingDeepLearningExample_02-20240714172409-2185cq5.png)​

### 连续分类图像并显示排名靠前的预测值

要连续对来自相机的图像进行分类并显示排名靠前的预测值，请将前面的步骤放入一个循环。在图窗打开时运行该循环。要停止实时预测，只需关闭图窗。在每次迭代结束时使用 `drawnow`​ 更新图窗。

创建图窗窗口。首先调整窗口大小以使宽度增加一倍，并创建两个子图。要防止坐标区大小改变，请将 `PositionConstraint`​ 属性设置为 `'innerposition'`​。

```matlab
h = figure;
h.Position(3) = 2*h.Position(3);
ax1 = subplot(1,2,1);
ax2 = subplot(1,2,2);
ax2.PositionConstraint = 'innerposition';
```

连续显示并分类图像，同时显示排名前五的预测值的直方图。

```matlab
while ishandle(h)
    % Display and classify the image
    im = snapshot(camera);
    image(ax1,im)
    im = imresize(im,inputSize);
    [label,score] = classify(net,im);
    title(ax1,{char(label),num2str(max(score),2)});

    % Select the top five predictions
    [~,idx] = sort(score,'descend');
    idx = idx(5:-1:1);
    scoreTop = score(idx);
    classNamesTop = string(classes(idx));

    % Plot the histogram
    barh(ax2,scoreTop)
    title(ax2,'Top 5')
    xlabel(ax2,'Probability')
    xlim(ax2,[0 1])
    yticklabels(ax2,classNamesTop)
    ax2.YAxisLocation = 'right';

    drawnow
end
```
