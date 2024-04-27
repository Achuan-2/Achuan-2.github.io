---
title: Matlab 如何读取、查看、保存Tiff
date: '2023-12-20 11:17:44'
updated: '2023-12-20 17:40:26'
excerpt: 对Matlab 读取、查看、保存Tiff文件做一个系统的总结
tags:
  - 编程
  - Matlab
  - 图像处理
categories:
  - 其他笔记
permalink: /post/matlab-read-view-save-tiff-1pkevw.html
comments: true
toc: true
abbrlink: 1bbbaf40
---



> 总结：Tiff 是 tagged image file format 的缩写。在科研领域，常用于无损保存图片。
>
> 本文主要探讨如何使用 Matlab 读取、查看、保存 Tiff 图像，思考了 Matlab 如何把 metadata 写入 Tiff 图像，并写了一些自定义函数方便调用。

## 读取 Tiff

### Single Tiff

```matlab
img= imread(filepath); 
```

### Stacked Tiff

```matlab
img_stack = tiffreadVolume(filepath);
```

> tiffreadVolume 需要 Matlab 2020b 以上
>
> 如果用 imread 则需要用索引循环提取，不太方便。
>
> ```matlab
> tiff_file = 'input.tif';
> info = imfinfo(tiff_file);
> num_images = numel(info);
>
> % 创建一个三维数组来存储图像数据
> image_stack = zeros(info(1).Height, info(1).Width, num_images, 'uint16');
>
> % 逐个读取图像并存储在三维数组中
> for i = 1:num_images
>     image_stack(:, :, i) = imread(tiff_file, i);
> end
> ```

有些成像软件（比如多光子成像软件 Scanimage），会把多通道的图片合并在一个 tif 里，要读取单个通道的话可以用下面的自定义函数

```matlab
function varargout =  tiff_read_volume(filepath,nChannel)
    %tiff_read_volume - 读取Tiff图像的灰度值.
    %
    %   USAGE
    %       imgStack = tiff_read_volume(filepath);
    %       [imgCh1,imgCh2] = tiff_read_volume(filepath,2);
    %
    %   INPUT PARAMETERS
    %       filepath             -   图像文件的路径
    %       属性
    %         'nChannel'     -  默认为1
    %
    %   OUTPUT PARAMETERS
    %       imgStack         -   输出nChannel个图像
  
    % 设置默认参数
    arguments
        filepath string;
        nChannel double = 1;
    end

    % read info
    imgStack = tiffreadVolume(filepath);
  
    % 如果 Tif 只有一个通道，直接输出读的结果即可
    if nChannel == 1
        varargout{1} = imgStack;
        return
    end

    % 如果 Tif 有多个通道，则需要分割出各个通道图像
    varargout = cell(1,nChannel);
    for iChannel = 1:nChannel
        varargout{iChannel}= imgStack(:, :, iChannel:nChannel:end);
    end
end
```

## 查看 Tiff

### Single Tiff

```matlab
figure;
imshow(img,[]);% 后一个参数是调整显示范围，建议加上，默认是根据数据类型的最小和最大值显示，使用[]就是根据实际数据的最小值和最大值，更符合通用情况的展示图片
```

### Stacked Tiff

以 GUI 形式动态查看 stack： sliceViewer、orthosliceViewer 和 volumeViewer

#### ​sliceViewer​​​​

```matlab
f = figure();
slice_viewer = sliceViewer(img_stack,"Parent",f);
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312202329829.png)​​

> * 从左向右水平拖动鼠标会更改对比度，垂直上下拖动鼠标会更改亮度。
> * 单击并拖动鼠标时按住 Ctrl 键可加速更改。按住 Shift 键同时单击并拖动鼠标会减慢更改速率。

#### ​​orthosliceViewer​​

```matlab
f = figure();
orthoslice_viewer = orthosliceViewer(img_stack,"Parent",f);
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312202329206.png)​​

#### volumeViewer

```matlab
% 打开GUI界面，选择文件加载
volumeViewer
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312202329220.png)​​

## 保存 Tiff

可以用 imwrite、Tiff 库和第三方的实现方式

### imwrite

#### 单帧

简单保存

```matlab
filepath = 'output.tif';
imwrite(img,filepath);
```

保存 metadata 到文件

```matlab
info = imfinfo("input.tif");
filepath = 'output.tif';
imwrite(img,filepath, ...
    'Description',info.ImageDescription, ...
    'RowsPerStrip',info.RowsPerStrip, ...
    'Resolution',[info.XResolution,info.YResolution], ...
    'Compression','none');
```

#### Stacked Tiff

直接保存

```matlab
info = imfinfo("input.tif");

filepath = "output.tif";
tiff_save_volume(imgStack,filepath);

function tiff_save_volume(imgStack,filepath)
    imwrite(imgStack(:,:,1),filepath, 
        'Compression','none');
    for i = 2 : size(imgStack, 3)
        imwrite(imgStack(:,:,i),filepath, ...
            'Compression','none', ...
            'WriteMode', 'append') ;
    end
end
```

保存 metadata 到文件

```matlab
info = imfinfo("input.tif");

filepath = "output.tif";
tiff_save_volume(imgStack,filepath,info(1));

function tiff_save_volume(imgStack,filepath,info)
    imwrite(imgStack(:,:,1),filepath, ...
        'Description',info.ImageDescription, ....
        'Resolution',[info.XResolution,info.YResolution], ...
        'Compression','none');
    for i = 2 : size(imgStack, 3)
        imwrite(imgStack(:,:,i),filepath, ...
            'Description',info.ImageDescription, ...
            'Resolution',[info.XResolution,info.YResolution], ...
            'Compression','none', ...
            'WriteMode', 'append') ;
    end
end
```

#### 基于 imwrite 的 tif 保存函数

写了一个函数，既可以保存单帧的 tif，也可以保存多帧 tif，既可以直接保存，也可以写入特定的图像信息

```matlab
function tiff_save_imwrite(input_img, filepath, info)
    %tiff_save_imwrite: Save a 3D image stack as a TIFF volume.
    %
    %   USAGE
    %       tiff_save_imwrite(img_stack, 'test.tif');
    %       ---
    %       info = imfinfo('original.tif');
    %       tiff_save_imwrite(img_stack, 'test.tif', info);
    %
    %   Input Arguments
    %       input_img     -   the input image,can be 2D or 3D.
    %       filepath      -   Path to the TIFF file to be created.
    %       info          -   Optional structure containing TIFF file properties.
    %

    arguments
        input_img % the input image,can be 2D or 3D.
        filepath string % Path to the TIFF file to be created.
        info struct = struct() % Optional structure containing TIFF file properties.
    end

    if ~ismember(ndims(input_img),[2,3])
        error('The number of dimensions of the input image must be 2 or 3.');
    end

    % Set default TIFF file properties if info is not provided.
    if isempty(fieldnames(info))
        info = struct();
        % imwrite cannot set the ResolutionUnit property of tif,but We can
        % set ImageDescription as the style of ImageJ
        info.ImageDescription = sprintf('ImageJ=1.53t\nunit=micron\n');
        info.XResolution = 1;
        info.YResolution = 1;
    end


    depth = size(input_img, 3);
    for d = 1:depth
        imwrite(input_img(:,:,1),filepath, ...
            'Description',info.ImageDescription, ....
            'Resolution',[info.XResolution,info.YResolution], ...
            'Compression','none');
        if d ~= depth
            imwrite(input_img(:,:,d),filepath, ...
                'Description',info.ImageDescription, ....
                'Resolution',[info.XResolution,info.YResolution], ...
                'Compression','none', ...
                'WriteMode', 'append') ;
        end
    end
end
```

示例

```matlab
% 保存图像
tiff_save_imwrite(img_stack, 'test.tif');

% 保存原图的信息
tiff_save_imwrite(img_stack, 'test.tif', info);

```

> ⚠ imwrite 如果要保存 ImageJ 的图像信息或者希望保存的图像信息被 ImageJ 正确读取，可以在 Description 添加 `ImageJ=1.53q\nunit=um....`​，imwrite 是不支持给 tif 写入 ResolutionUnit 的，但是用这种方法就可以让 ImageJ 正确读取 ResolutionUnit 单位。
>
> ```matlab
> imwrite(I, 'myLovelyImage.tif', 'TIF', 'Resolution', [1/pixSizeX 1/pixSizeY], 'Description', sprintf('ImageJ=1.53q\nunit=um\n'));
> ```
>
> ref：[Simplest way to save tif in Matlab with resolution in um - Usage &amp; Issues - Image.sc Forum](https://forum.image.sc/t/simplest-way-to-save-tif-in-matlab-with-resolution-in-um/67893/2)

‍

### Tiff

imwrite 虽然也能保存 Tiff，但是更推荐使用 Tiff 库。imwrite 只能保存简单的信息，不能保存 ResolutionUnit 信息到文件（除非写入到 Description 字段），而且保存多帧 Tif 的速度慢，而使用 LibTIFF 库保存 Tiff，就可以尽可能的保存 Metadata，保存速度也比 imwrite 快。

Tiff 对象的官方文档：[https://ww2.mathworks.cn/help/matlab/ref/tiff.html](https://ww2.mathworks.cn/help/matlab/ref/tiff.html)

使用 `Tiff()`​ 函数保存图片文件时，在将数据写入文件之前，必须先设置以下标记：

* ​`ImageWidth`​​：图像宽度
* ​`ImageLength`​​：图像长度
* ​`Compression`​：压缩情况，一般选择无压缩 ​`Tiff.Compression.None`​
* ​`PlanarConfiguration`​：存储配置。chunky 是连续存储每个像素的分量值，seperate 是分开存储每个通道。在科研中处理的大多数为单通道灰度图像，这个设置都可。​`Tiff.PlanarConfiguration.Chunky`​
* ​`BitsPerSample`​​：数据为 int16、uint16，该值为 16，数据为 uint8 该值为 8
* ​`Photometric`​：图像数据颜色空间。有好多种可以选，具体可以 doc 看看。科研处理的灰度图像，一般选'MinIsBlack'，即像素值为 0 时是黑色的。​`Tiff.Photometric.MinIsBlack`​
* ​`SamplesPerPixel`​：一个像素几个采样数，一般为 1

| 标记类型                | 解释                   | 一般设置的值                                           |
| ----------------------- | ---------------------- | ------------------------------------------------------ |
| ​`ImageWidth`​          | 图像宽度               | 根据实际图像尺寸设置：`size(img,2)`​                   |
| ​`ImageLength`​         | 图像长度               | 根据实际图像尺寸设置：`size(img,1)`​                   |
| ​`Compression`​         | 压缩情况               | ​`Tiff.Compression.None`​                              |
| ​`PlanarConfiguration`​ | 存储配置               | ​`Tiff.PlanarConfiguration.Chunky`​                    |
| ​`BitsPerSample`​       | 数据类型               | 根据实际数据类型设置：8，16，32                        |
| ​`Photometric`​         | 图像数据颜色空间       | ​`Tiff.Photometric.MinIsBlack`​                        |
| ​`SamplesPerPixel`​     | 一个像素几个采样数     | 1                                                      |
| ​`SampleFormat`​        | int 类型还是 uint 类型 | ​`Tiff.SampleFormat.UInt` ​or `Tiff.SampleFormat.Int`​ |

‍

> ℹ `RowsPerStrip` ​是什么
>
> 例如，如果一个 512x512 的图像被设置为 `RowsPerStrip`​ 为 16，则这意味着每个条将包含 16 行的数据。因此，整个图像将被分成 512 / 16 = 32 个条来存储。每个条可以单独被读取和写入，这有助于处理大图像，因为你可以一次只加载和处理图像的一部分，而不是整个图像。

自定义保存 Tiff 的函数

```matlab
function tiff_save_lib(input_img, filepath, tagstruct)
%tiff_save_lib: Save a 3D image stack as a TIFF volume.
%
%   USAGE
%       tiff_save_lib(img, 'test.tif');
%       ---
%       tagstruct = tiff_read_tag('original.tif');
%       tiff_save_lib(img, 'test.tif', tagstruct);
%
%   Input Arguments
%       input_img     -   the input image,can be 2D or 3D.
%       filepath      -   Path to the TIFF file to be created.
%       tagstruct          -   Optional structure containing TIFF file tags.
%

    arguments
        input_img % the input image,can be 2D or 3D.
        filepath string % Path to the TIFF file to be created.
        tagstruct struct = struct() % Optional structure containing TIFF file properties.
    end
    if ~ismember(ndims(input_img),[2,3])
        error('The number of dimensions of the input image must be 2 or 3.');
    end

    % Set default TIFF file properties if info is not provided.
    if isempty(fieldnames(tagstruct))
        tagstruct = generate_tagstruct(input_img);
    end




    s=whos('input_img');
    if s.bytes > 2^31-1 % 2^32-1约等于4GB,但是考虑加上tag后，文件会偏大，所以设置为2^31-1
        t = Tiff(filepath,'w8');
    else
        t = Tiff(filepath,'w');
    end

    depth = size(input_img, 3);
    for d = 1:depth
        t.setTag(tagstruct);
        t.write(input_img(:, :, d));
        if d ~= depth
            % Tiff对象若需要写入多帧图片，需要使用writeDirectory，将IFD指向下一帧，才能继续写入
            t.writeDirectory();
        end
    end
    t.close();
end


function tagstruct = generate_tagstruct(input_img)
    tagstruct.ImageLength = size(input_img, 1);
    tagstruct.ImageWidth = size(input_img, 2);
    tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
    switch class(input_img)
        case {'uint8', 'int8'}
            tagstruct.BitsPerSample = 8;
        case {'uint16', 'int16'}
            tagstruct.BitsPerSample = 16;
        case {'uint32', 'int32'}
            tagstruct.BitsPerSample = 32;
        case {'single'}
            tagstruct.BitsPerSample = 32;
        case {'double', 'uint64', 'int64'}
            tagstruct.BitsPerSample = 64;
    end
    if ismember(class(input_img),{'uint8','uint16','uint32','logical'})
        tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
    else
         tagstruct.SampleFormat = Tiff.SampleFormat.Int;
    end
   
    tagstruct.SamplesPerPixel = 1;
    tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
    tagstruct.Software = 'MATLAB';
end

```

自定义读取 Tif 的必要 Tag 函数

```matlab
function tagstruct = tiff_read_tag(filepath)
    %tiff_read_tag - 读取 Tiff 图像的信息.
    %
    %   USAGE
    %       tagstruct = tiff_read_tag(path)
    %
    %   INPUT PARAMETERS
    %       filepath             -   图像文件的路径
    %
    %   OUTPUT PARAMETERS
    %       tagstruct         -   返回图像信息的struct数组
    t = Tiff(filepath, 'r');

    tagNames = {
    'ImageLength',
    'ImageWidth',
    'ImageDescription',
    'Artist',
    'ResolutionUnit',
    'XResolution',
    'YResolution',
    'Orientation',
    'Photometric',
    'BitsPerSample',
    'SamplesPerPixel',
    'SampleFormat',
    'RowsPerStrip',
    'PlanarConfiguration',
    'Software',
};
    tagstruct = struct();
    % 循环获取每个tag的值
    for k = 1:length(tagNames)
        try
            tagName = tagNames{k};
            tagValue = t.getTag(tagName);
            tagstruct.(tagName) = tagValue;
        catch
            %fprintf('Tag %s cannot be retrieved.\n', tagNames{k});
        end
    end
    t.close();
end

```

示例

```matlab
% 保存图像
tiff_save_lib(img, 'test.tif');

% 保存原图的信息
tagstruct = tiff_read_tag('original.tif');
tiff_save_lib(img, 'test.tif', tagstruct);
```

### 第三方实现方式

[rharkes/Fast_Tiff_Write](https://github.com/rharkes/Fast_Tiff_Write)：这个 repo 实现了更快速的保存大文件，但是如下问题

* 只能保存 uint16、uint8、single 数据
* 我暂时不知道怎么保存 metadata，最重要就是 XResolution、YResolution 和 ResolutionUnit

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312201741281.png)​

```matlab
tic
fTIF = Fast_Tiff_Write('test_fastwrite.tif',1,0); % 1代表pixelsize,0代表compression
for ct = 1:size(img_stack,3)
    fTIF.WriteIMG(img_stack(:,:,ct)');
end
fTIF.close;  
toc
```
