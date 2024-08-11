---
title: Matlab 深度学习丨基于ResNet的新冠肺炎X光胸片检测
date: '2024-08-11 23:00:00'
updated: '2024-08-11 23:00:02'
excerpt: |-
  本笔记改编自《深度学习经典案例解析：基于MATLAB》一书中的内容，使用ResNet网络来对X光胸片进行检测，判断是否有肺炎。

  不过老实说，这个数据集数量太少。并且我自己也无法通过肉眼分辨X光胸片到底有没有肺炎。

  所以本笔记更多的是介绍Matlab 如何调用ResNet、如何做数据增强等知识点。
tags:
  - Matlab
categories:
  - 深度学习
permalink: >-
  /post/matlab-deep-learning-gun-new-coronary-pneumonia-x-ray-chest-test-based-on-resnet-z1ibtf8.html
comments: true
toc: true
---



## 总结

本笔记改编自《深度学习经典案例解析：基于MATLAB》一书中的内容，使用ResNet网络来对X光胸片进行检测，判断是否有肺炎。

不过老实说，这个数据集数量太少。并且我自己也无法通过肉眼分辨X光胸片到底有没有肺炎。

所以本笔记更多的是介绍Matlab 如何调用ResNet、如何做数据增强等知识点。

## 背景

### 数据集

在新冠肺炎诊断过程中，除了病毒核酸检测外，X射线的胸正位图像也是其中一个重要环节。

在本节中，我们将使用开源胸片数据集，训练一个ResNet网络，用以分类一张胸片是属于健康人，还是属于新冠肺炎患者，以期帮助医生更准确地做出判断。所使用的图像数据集由Adrian Rosebrock博士发布，可以直接从网址（[https://www.pyimagesearch.com/2020/03/16/detecting-covid-19-in-x-ray-images-with-keras-tensorflow-and-deep-learning/](https://www.pyimagesearch.com/2020/03/16/detecting-covid-19-in-x-ray-images-with-keras-tensorflow-and-deep-learning/)）下载。其中包含25张健康人胸片和25张新冠肺炎患者胸片，原作者还提供了Python的Keras库和VGG16网络的代码，本文只用了其中的数据集，ResNet网络程序由MATLAB实现。

### ResNet网络简介

ResNet是深度残差网络（Residual Network）的简称，由微软的何凯明等人于2015年提出，一举夺得当年ImageNet大规模视觉识别竞赛图像分类和物体识别的冠军。其核心思想是在每2个网络层之间加入一个残差连接，缓解深层网络中的梯度消失问题，使得训练数百甚至数千层成为可能。

​![image](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/image-20240803184018-1xfdt57.png)​

在图像处理领域，一般认为神经网络更深的网络层能够提取出更加“高级”的图像特征。为了实现先进的性能，网络往往都需要数十甚至数百层，此时，梯度消失和梯度爆炸问题成为训练深层网络的一大障碍，可能导致网络无法收敛。通过在常规网络中引入残差连接，极大地缓解了网络梯度消失的问题。除此之外，残差连接还具有实现简单、计算开销小、对原有网络结构影响小等优点。因此，无论在图像处理领域，还是在自然语言处理领域，现有的很多最先进的深度神经网络都将残差连接作为一种常用技巧。

## 实战笔记

### 加载数据集

通过资源管理器查看数据集

​![Clip_2024-08-03_18-50-51](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-08-03_18-50-51-20240803185101-4pmue85.png)​

​![Clip_2024-08-03_18-51-25](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-08-03_18-51-25-20240803185127-yxucltu.png)​

加载数据集

```matlab
% 加载图像数据
dataset_path = 'dataset';

imds = imageDatastore(dataset_path,...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');
total_split = countEachLabel(imds);
total_split 
```

||Label|Count|
| :-: | :------: | :-----: |
|1|covid|25|
|2|normal|25|

查看数据集

```matlab
% 随机显示数据集中的部分图像
numPreviewImages = 4; % 每类预览多少张
imdsPreview = splitEachLabel(imds, numPreviewImages, 'randomize');
figure
tiledlayout('flow');

for i = 1:numel(imdsPreview.Labels)
    nexttile
    I = readimage(imdsPreview,i);
    imshow(I)
    title(imdsPreview.Labels(i),fontsize = 8)
end
```

​![figure_0.png](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/figure_0-20240803184911-kesbqul.png)​

### 分割测试集和训练集

```matlab
% 分割测试集和训练集
[img_ds_Train,img_ds_Test] = splitEachLabel(imds,0.7,"randomized");
```

### 加载预训练好的网络

```matlab
% 确定训练数据中新冠图片标签类别数量：2类
numClasses = numel(categories(img_ds_Train.Labels));

% 加载ResNet50网络（注：该网络需要提前下载，当输入下面命令时按要求下载即可）

net = imagePretrainedNetwork("resnet50",NumClasses=numClasses); % 将全连接层的分类数设置为与新数据中的分类数相同。

analyzeNetwork(net)
```

​![Clip_2024-08-03_18-58-03](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-08-03_18-58-03-20240803185811-yqhush0.png)​

根据新数据设定新的全连接层的参数，

```matlab
net = setLearnRateFactor(net,"fc1000/Weights",10);
net = setLearnRateFactor(net,"fc1000/Bias",10);

```

### 数据增强

数据增强，目的是增加数据，增加模型鲁棒性

```matlab
% 数据增强的参数
augmenter = imageDataAugmenter(...
    'RandRotation',[-5 5],...
    'RandXReflection',1,...
    'RandYReflection',1,...
    'RandXShear',[-0.05 0.05],...
    'RandYShear',[-0.05 0.05]);

% 将批量训练图像的大小调整为与输入层的大小相同
aug_img_ds_train = augmentedImageDatastore([224 224],img_ds_Train,'DataAugmentation',augmenter,'ColorPreprocessing','gray2rgb');

% 将批量测试图像的大小调整为与输入层的大小相同
aug_img_ds_test = augmentedImageDatastore([224 224], img_ds_Test,'ColorPreprocessing','gray2rgb');
```

### 对网络进行训练

```matlab
% 对训练参数进行设置
options = trainingOptions("adam", ...
    MiniBatchSize=8, ...
    MaxEpochs=30, ...
    Metrics="accuracy", ...
    InitialLearnRate=1e-4, ...
    LearnRateDropFactor=0.01, ...
    LearnRateDropPeriod=5, ...
    Shuffle="every-epoch", ...
    Verbose=false, ...
    Plots="training-progress");



% 用训练图像对网络进行训练
netTransfer = trainnet(aug_img_ds_train,net,"crossentropy",options);
```

​![Clip_2024-08-03_19-10-15](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-08-03_19-10-15-20240803191017-6jbxcbi.png)​

### 进行测试并查看结果

```matlab
classNames = categories(imds.Labels)
scores = minibatchpredict(netTransfer,aug_img_ds_test);
YPred = scores2label(scores,classNames);


% 对训练好的网络采用验证数据集进行验证

idx = randperm(numel(aug_img_ds_test.Files),10);
imgs = read(aug_img_ds_test);
figure
tiledlayout("flow");
for i = 1:10
    nexttile
    I = imgs{idx(i),1}{1};
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end
```

​![Clip_2024-08-03_19-26-02](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-08-03_19-26-02-20240803192604-a9e5y8s.png)​

计算分类准确率

```matlab
YTest = img_ds_Test.Labels;
accuracy = mean(YPred == YTest)
```

> ​`accuracy = 0.9286`​

创建并显示混淆矩阵

```matlab
figure
confusionchart(YTest,YPred)
```

​![image](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/image-20240803192545-hpj1afv.png)​

## 知识点

* matlab如何调用预训练的ResNet网络

  * 官方提供了三个型号的resnet：`"resnet18"`​、`"resnet50"`​、`"resnet101"`​
  * Matlab 2024a起，推荐使用imagePretrainedNetwork来加载预训练模型，可以直接指定输出分类数目，更方便迁移学习

    ```matlab
    net = imagePretrainedNetwork("resnet50",NumClasses=numClasses);
    ```
* matlab如何做数据增强

  * augmentedImageDatastore

    ```matlab
    % 数据增强的参数
    augmenter = imageDataAugmenter(...
        'RandRotation',[-5 5],...
        'RandXReflection',1,...
        'RandYReflection',1,...
        'RandXShear',[-0.05 0.05],...
        'RandYShear',[-0.05 0.05]);

    % 将批量训练图像的大小调整为与输入层的大小相同
    aug_img_ds_train = augmentedImageDatastore([224 224],img_ds_Train,'DataAugmentation',augmenter,'ColorPreprocessing','gray2rgb');

    % 将批量测试图像的大小调整为与输入层的大小相同
    aug_img_ds_test = augmentedImageDatastore([224 224], img_ds_Test,'ColorPreprocessing','gray2rgb');
    ```
