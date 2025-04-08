---
title: Matlab 读取超大文件丨memmapfile
date: '2025-03-31 23:39:04'
updated: '2025-04-08 09:13:41'
excerpt: >-
  如果钙成像成像一次成像几千上万个细胞，一次成像上万帧，Tiff文件会特别大，就算提取钙信号得到的矩阵也会很大，


  如果自己的电脑内存小，就很难跑得动代码。


  为了解决这个问题，可以使用matlab的memmapfile函数，它可以一个文件的内容映射到 MATLAB
  的虚拟内存地址空间中，而不是将整个文件一次性读入物理内存（RAM）。这样做可以让你像访问内存中的数组一样访问文件的内容，特别适用于处理那些远大于可用 RAM
  的大型文件。


  这篇笔记介绍了memmapfile函数的基本用法，还用一个例子介绍如何用memmapfile保存和读取几十GB的钙信号二维数据
tags:
  - Matlab
categories:
  - 编程笔记
permalink: /post/matlab-reads-super-large-filegun-memmapfile-zj7f76.html
comments: true
toc: true
---





> 如果钙成像成像一次成像几千上万个细胞，一次成像上万帧，Tiff文件会特别大，就算提取钙信号得到的矩阵也会很大，
>
> 如果自己的电脑内存小，就很难跑得动代码。
>
> 为了解决这个问题，可以使用matlab的memmapfile函数，它可以一个文件的内容映射到 MATLAB 的虚拟内存地址空间中，而不是将整个文件一次性读入物理内存（RAM）。这样做可以让你像访问内存中的数组一样访问文件的内容，特别适用于处理那些远大于可用 RAM 的大型文件。
>
> 这篇笔记介绍了memmapfile函数的基本用法，还用一个例子介绍如何用memmapfile保存和读取几十GB的钙信号二维数据

## memmapfile介绍

​`memmapfile`​ 它允许你将一个文件（通常是二进制文件）的内容**映射**到 MATLAB 的虚拟内存地址空间中，而不是将整个文件一次性读入物理内存（RAM）。这样做可以让你像访问内存中的数组一样访问文件的内容，特别适用于处理那些远大于可用 RAM 的大型文件。

​**​`memmapfile`​**​ **的主要优点：**

1. **处理超大文件：**  可以访问远超物理内存大小的文件，因为只有实际被访问的部分才会被加载到内存。
2. **高效的访问：**  对于需要频繁读取或修改文件中不同位置小块数据的场景，内存映射通常比反复使用 `fseek`​ 和 `fread`​/`fwrite`​ 更高效，因为它避免了重复的文件 I/O 开销和系统调用开销。
3. **代码简洁性：**  一旦映射创建成功，你可以像操作普通 MATLAB 数组一样访问文件数据（通过 `memmapfile`​ 对象的 `Data`​ 属性），代码更直观。
4. **潜在的共享内存：**  不同的 MATLAB 进程或甚至其他支持内存映射的程序可以映射同一个文件，从而实现一种形式的进程间数据共享（需要注意同步问题）。

    例子见：[Share Memory Between Applications](https://www.mathworks.com/help/matlab/import_export/share-memory-between-applications.html)

## ​**​`memmapfile`​**​如何使用

​**​`memmapfile`​**​ **的基本语法：**

```matlab
m = memmapfile(filename, Name, Value, ...)
```

* ​`filename`​: 你要映射的文件的完整路径和名称（字符串）。文件必须存在。
* ​`Name, Value`​ pairs: 一系列可选的参数，用于控制映射的行为。

**关键的可选参数 (Name-Value Pairs)：**

1. ​**​`Writable`​**​: (逻辑值 `true`​ 或 `false`​)

    * ​`false`​ (默认): 只读映射。你只能读取文件数据，不能修改。尝试写入会报错。
    * ​`true`​: 可写映射。你可以读取和修改文件数据。修改会最终写回磁盘文件。**注意：**  可写映射通常会对文件进行独占锁定，其他程序可能无法同时写入该文件。
2. ​**​`Offset`​**​: (非负整数)

    * 指定从文件**开头**算起的字节偏移量，映射从这里开始。默认是 `0`​（文件开头）。
    * 这允许你只映射文件的一部分，比如如果文件会在开头放置一些基础的metadata线，就可以通过Offset跳过文件头的metadata信息。
3. ​**​`Format`​**​: (字符向量 或 元胞数组)

    * **极其重要**的参数！它定义了如何解释文件中的原始字节数据。
    * **简单形式 (字符向量):**  指定一个 MATLAB 的基本数据类型，例如：

      * ​`'uint8'`​, `'int8'`​, `'uint16'`​, `'int16'`​, `'uint32'`​, `'int32'`​, `'uint64'`​, `'int64'`​ (整数类型)
      * ​`'single'`​ (单精度浮点数, 对应 C 的 `float`​)
      * ​`'double'`​ (双精度浮点数, 对应 C 的 `double`​)
      * ​`'logical'`​ (逻辑值, 通常是 1 字节)
      * ​`'char'`​ (字符, 通常是 1 或 2 字节，取决于系统编码)  
        整个映射区域的数据都会被解释为这种类型的连续数组。

      例子

      ```matlab
      myData = (1:10);

      fileID = fopen('records.dat','w');
      fwrite(fileID,myData,'double');
      fclose(fileID);

      m = memmapfile('records.dat','Format','double') ;
      m.Data

      ans =

           1
           2
           3
           4
           5
           6
           7
           8
           9
          10
      ```
    * 多维矩阵 **:**  每个多维矩阵元素定义结构体的一个字段：

      ```matlab
      {'DataType', [Dimensions], 'FieldName'}
      ```

      * ​`DataType`​: 该字段的数据类型 (同上)。
      * ​`Dimensions`​: 该字段的维度 (一个行向量，例如 `[1 1]`​ 表示标量，`[1 10]`​ 表示 1x10 的数组)。
      * ​`FieldName`​: 该字段在 `memmapfile`​ 对象的 `Data`​ 结构体中的名称。
      * 例如，把文件里存放到从1到20的数组，解析为4×5的二维矩阵

        ```matlab
        myData = (1:20);

        fileID = fopen('records.dat','w');
        fwrite(fileID,myData,'double');
        fclose(fileID);

        m = memmapfile('records.dat','Format',{'double',[4,5],'value'}) ;
        m.Data.value

        ans =

             1     5     9    13    17
             2     6    10    14    18
             3     7    11    15    19
             4     8    12    16    20

        ```
      * 例如，如果文件包含一系列记录，每个记录包含一个 double 和一个长度为10的 int16 数组：

        ```matlab
        format = {'double', [1 1], 'value'; 'int16', [1 10], 'samples'};
        m = memmapfile('mydata.bin', 'Format', format);
        % 访问第一个记录的 value 字段: m.Data(1).value
        % 访问第三个记录的 samples 字段: m.Data(3).samples
        ```
4. ​**​`Repeat`​**​: (正整数 或 `inf`​)

    * 指定 `Format`​ 定义的数据结构在文件中重复多少次。
    * 默认是 `inf`​，表示从 `Offset`​ 开始，一直映射到文件末尾，有多少个完整的 `Format`​ 结构就映射多少个。
    * 如果你知道确切的记录数量，可以指定一个具体的整数。

## memmapfile的使用注意事项

* 如何关闭memmapfile对象

  * 方法1：给`memmapfile`​重新赋一个值
  * 方法2：用clear命令清除`memmapfile`​变量
  * 方法3：在函数使用，函数使用完毕，会自动删除`memmapfile`​对象
  * 注意：如果使用了`d = m.Data`​, 把memmapfile对象的Data字段赋值给一个变量时，MATLAB会创建一个共享数据副本，这很高效，因为实际上没有内存被复制。如果先清除m对象，文件和相关变量之间的数据共享就会断开，如果后面还要使用相关数据，必须在清除对象前把这些变量的数据复制到内存里。
* 不能直接memmapfile('mydata.bin').Data，这样相当于读取全部数据会非常卡，可以

  ```matlab
  m = memmapfile('mydata.bin');
  m.Data; % 这样就不会卡
  ```
* 如果使用memmapfile要直接修改文件的数据，不要用`data = m.Data`​，然后用data进行修改数据`data.x=ones(300,8,'uint16');`​，这个时候data只是一个副本，修改数据不会影响到原数据，需要`m.Data.x = ones(300,8,'uint16')`​这样才能正确修改

## 示例：保存和读取几十GB的钙信号二维数据

假设一个钙信号数据，有10000个神经元，每个神经元有1000000帧的数据，我的电脑是无法直接在内存生成10000×1000000的矩阵的

![PixPin_2025-03-31_23-50-34](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-31_23-50-34-20250331235040-6skkt5a.png)

我们可以使用fwrite，一行一行写入，保存数据为文件

```matlab
% 定义元数据
nROI = 10000;       % ROI数量
nFrames = 1000000; % 每个ROI的帧数

% 定义文件名
filename = 'roi_data.dat';

% 打开文件写入
fid = fopen(filename, 'w');

% 1. 写入元数据
fwrite(fid, nROI, 'int32');       % 写入 ROI 的数量 (4字节整数)
fwrite(fid, nFrames, 'int32');   % 写入每个ROI的帧数 (4字节整数)

% 2. 写入实际数据
for roiIdx = 1:nROI
    % 生成随机信号数据，每个ROI是一个 [nFrames x 1] 的向量
    signalData = rand(nFrames, 1); 
    fwrite(fid, signalData, 'double'); % 写入信号数据
end

% 关闭文件
fclose(fid);

disp('元数据和信号数据已成功写入文件');

```

生成的文件有74.5GB大小

![PixPin_2025-03-31_23-53-23](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-31_23-53-23-20250331235326-rbzikfn.png)​

之后使用memmapfile来读取这个文件，就可以想读哪个ROI的数据，就读哪个ROI的数据了

```matlab
% 文件名
filename = 'roi_data.dat';

% 打开文件以读取元数据
fid = fopen(filename, 'r');

% 1. 读取元数据
nROI = fread(fid, 1, 'int32');       % 读取 ROI 的数量
nFrames = fread(fid, 1, 'int32');   % 读取每个ROI的帧数

% 2. 计算信号数据的起始位置
dataStartPos = ftell(fid); % 当前文件指针位置（即信号数据的起始字节位置）

% 关闭文件
fclose(fid);

% 3. 使用 memmapfile 映射文件
signalDataFormat = {'double', [nFrames, nROI], 'SignalData'};
mmf = memmapfile(filename, ...
    'Format', signalDataFormat, ...
    'Offset', dataStartPos, ...
    'Writable', false, ... % 通常设为 false 除非需要修改
    'Repeat', 1);          % 明确指定只映射一次这个结构

% 4. 读取指定ROI的数据
roiIdx = 50; % 假设我们想读取第50个ROI的数据
signalData = mmf.Data.SignalData(:, roiIdx);

% 显示读取的数据
disp(['读取第' num2str(roiIdx) '个ROI的数据：']);
figure;plot(signalData); 

```

> 注意，这里读取的矩阵格式格式是nframes×nROI，这是因为写入二进制的时候，就是
>
> * ​`nROI`​ (int32)
> * ​`nFrames`​ (int32)
> * ROI 1 的所有帧数据 (double \* nFrames)
> * ROI 2 的所有帧 数据(double \* nFrames)
>
> MATLAB 默认就是按列读取和存储矩阵的，所以读取的时候，就成了nframes×nROI

也可以改为memapfile读取的format只有帧这个单一维度，同时设置repeat=nROI数目

```matlab
signalDataFormat = {'double', [nFrames], 'SignalData'};
mmf = memmapfile(filename, ...
    'Format', signalDataFormat, ...
    'Offset', dataStartPos, ...
    'Writable', false, ... % 通常设为 false 除非需要修改
    'Repeat', nROI);          % 明确指定只映射一次这个结构
```

这样的话，读取单个ROI的数据就是

```matlab
mmf.Data(roiIdx).SignalData
```

‍
