---
title: Matlab 控制 Gentl 协议高速相机
date: '2023-09-29 20:37:00'
updated: '2023-10-11 14:08:03'
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
---

> 由于科研项目需要，需要使用 Matlab 控制高速相机拍摄小鼠行为，并与三光子显微镜成像同步，在此总结下，如何使用 Matlab 来控制相机进行采集图像和录制视频

### 相机情况简介

相机名：Basler acA1440-220um

相机参数：拍摄速度最高 227FPS，分辨率最高 1440 px x 1080 px

### 使用简介

相机需要使用USB 3.0 连接电脑，Basler Pylon Viewer 软件可以对相机进行参数设置并保存配置。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407524.png "Basler")​

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407904.png "Basler")​

### 控制相机

* 软件：自带Pylon Viewer
* 代码

  * Matlab Gentl Toolbox（不支持使用webcam、winvideo检测相机）
  * Python：[basler/pypylon-samples (github.com)](https://github.com/basler/pypylon-samples)
  * [Basler Pylon 相机 C++ SDK](siyuan://blocks/20230621142609-8k26r83)

### Pylon Viewer的使用

下载地址：[pylon Software for Image Capture ](https://www.baslerweb.com/en-us/software/pylon/)（如果需要保存为mp4，需要额外下载 pylon Supplementary Package for MPEG-4 Windows）

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407222.png "Pylon")​

一些设置经验总结

* 设置分别率，即图像尺寸大小。

  ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407890.png)​
* 设置相机曝光时间（曝光时间越短，快门速度越快，越能抓拍高速运动的物体）

  > 帧率只决定曝光时间的上限，如果帧率提高抓拍依然模糊，可以适当缩短曝光时间，虽然会造成图片亮度不足
  >

  ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407720.png)​
* 增加相机输出图像的亮度：提高 gain（应该类似于相机的iso，亮度会提高，噪声也会提高）

  ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407511.png)​
* 保存用户配置，实测除了拍摄图像的分辨率大小外，其他设置的参数比如帧率、曝光时间等都是能在Matlab用的。

  ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407469.png)​
* 软件设置录制：上方菜单【Window】→【Record Settings】

  ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407261.png)​

## Matlab 环境配置和文档总结

* **Matlab 环境配置**：需要安装两个 Toolbox

  * GenTL Support from Image Acquisition Toolbox
  * Image Acquisition Toolbox
* **videoinput 文档**：[Create video input object - MATLAB - MathWorks 中国](https://ww2.mathworks.cn/help/imaq/videoinput.html?requestedDomain=cn)，主要使用的函数总结

### 预览和结束预览

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407037.png "preview(obj")​

* ​`preview`​ 预览 【[Ref](https://ww2.mathworks.cn/help/imaq/imaqdevice.preview.html)】
* ​`closepreview`​ 结束预览 【[Ref](https://ww2.mathworks.cn/help/imaq/imaqdevice.closepreview.html)】

### 控制相机开始采集图像

* ​`start`​：获取相机专属使用权 【[Ref](https://ww2.mathworks.cn/help/imaq/start.html)】

  Data logging is controlled with the `TriggerType`​ property.

  |Trigger Type|Logging Behavior|
  | ------------| -----------------------------------------------------------------------------------------------|
  |​`'hardware'`​|Data logging occurs when the condition specified in the object's `TriggerCondition`​ property is met via the `TriggerSource`​.|
  |​`'immediate'`​|Data logging occurs immediately.|
  |​`'manual'`​|Data logging occurs when the `trigger`​ function is call|
* ​`trigger`​：如果 `triggerconfig(vid,"manual")`​，则 `start` ​后，需要 `trigger` ​相机才会开始采集；【[Ref](https://ww2.mathworks.cn/help/imaq/imaqdevice.trigger.html)】
* ​`vid.FramesPerTrigger`​：specifies the number of frames the video input object acquires each time it executes a trigger using the selected video source. 【[Ref](https://ww2.mathworks.cn/help/imaq/framespertrigger.html)】

  * When the `FramesPerTrigger`​ property is set to `Inf`​, the object ignores the value of the `TriggerRepeat`​ property.
* ​`stop`​：停止相机采集 【[Ref](https://ww2.mathworks.cn/help/imaq/stop.html)】
* ​`wait`​：Wait until image acquisition object stops running or logging, locks the MATLAB^®^ command line until the video input object `obj`​ stops running 【[Ref](https://ww2.mathworks.cn/help/imaq/wait.html)】

### LoggingMode 设置

​[`LoggingMode`](https://ww2.mathworks.cn/help/imaq/loggingmode.html?requestedDomain=cn)​："memory" (default) | "disk" | "disk&memory"

* memory，不提取数据只会把照片保存到内存，需要手动提取

  ```matlab
  vid = videoinput('gentl',1,'Mono8',"LoggingMode","memory");
  vid.FramesPerTrigger = Inf;
  triggerconfig(vid,"manual");




  % 获取相机使用权
  start(vid); %start 这一句可能存在延迟，不要放在实际相机开始拍的调用里面

  % 开始采集
  trigger(vid);

  % 等待采集完成
  pause(5);

  % 停止采集
  stop(vid);
  close(writerObj);

  % 录制结束后，需要手动提取frame，保存到视频里
  writerObj = VideoWriter('./test.mp4','MPEG-4');
  writerObj.FrameRate = 150; %<=150
  open(writerObj);
  frame = getdata(vid,vid.FramesAcquired);
  writeVideo(writerObj,frame);
  close(writerObj);
  ```
* disk：直接边采集边保存。

  ```matlab
  %%%%% 录制视频代码
  % log到硬盘
  vid = videoinput('gentl',1,'Mono8',"LoggingMode","disk");
  set(vid, 'ROIPosition', [400 0 960 640 ]);
  vid.FramesPerTrigger = Inf; % 一次Trigger后一直接收帧，直到接收到stop信号
  triggerconfig(vid,"manual");


  writerObj = VideoWriter('./test.mp4','MPEG-4');
  writerObj.FrameRate = 150; %<=150
  vid.DiskLogger = writerObj;

  preview(vid);

  % 获取相机使用权
  start(vid); %start 这一句可能存在延迟，不要放在实际相机开始拍的调用里面

  % 开始采集
  trigger(vid);

  % 等待采集完成
  pause(5);

  % 停止采集
  stop(vid);
  close(writerObj);

  % disconnect video
  delete(vid)
  clear "vid"
  ```
* disk&memory：disk 一份，memory 一份，没必要

## 获取相机信息

```matlab
%%%%% 获取相机信息
info = imaqhwinfo('gentl') % 笔记本电脑和三光子运行这句会报错
dev = imaqhwinfo('gentl',1)



>> dev = imaqhwinfo('gentl',1)

dev = 

  包含以下字段的 struct:

             DefaultFormat: 'Mono8'
       DeviceFileSupported: 0
                DeviceName: 'acA1440-220um (40241122)'
                  DeviceID: 1
     VideoInputConstructor: 'videoinput('gentl', 1)'
    VideoDeviceConstructor: 'imaq.VideoDevice('gentl', 1)'
          SupportedFormats: {'Mono12'  'Mono8'}
```

## 测试帧率和帧率稳定性

1. **直接通过预览获取信息**：通过预览 `preview(vid)` ​判断相机预设的帧率和 Matlab 获取的帧率是否一致

   ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111407179.png)​
2. **计算实际帧率**：通过代码连续获取很多帧，并计时，计算帧率

   ```matlab
   %%%%%% 计算实际帧率

   vid = videoinput('gentl',1,'Mono8');
   vid.FramesPerTrigger = 1; % 一次触发获取一帧
   triggerconfig(vid,"manual"); % 设置手动触发，必须设置，否则每次触发相机都相当于要开机，延迟久
   start(vid);
   FPS = zeros(1,10);
   for iy = 1:10 % 测试十次
       Num = 1000;  % 每次获取一千帧

       tic
       for inum = 1:Num
           Img = getsnapshot(vid); % getsnapshot相当于手动触发
       end
       h = toc; % 获取一千帧的耗时

       FPS(iy) = Num/h; % 计算FPS
   end

   plot(1:10,FPS);
   % 停止采集
   stop(vid);
   delete(vid);
   clear
   ```

   ​![test_camera_FPS](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202310111325622.png "十次计算的相机FPS")​
3. **测试录制视频帧率实际稳定性**：控制相机拍摄手机秒表录制一段视频，potplayer 前进一秒，看看视频里的秒表是不是也是前进一秒；严格测试是视频逐帧前进，看秒表前进的时间和计算的是否一致，（注意手机的屏幕刷新率注意需要提高到 120Hz）。

## 录制视频

### 录制视频代码

```matlab
%%%%% 录制视频代码
% log到硬盘
vid = videoinput('gentl',1,'Mono8',"LoggingMode","disk");
set(vid, 'ROIPosition', [400 0 960 640 ]);
vid.FramesPerTrigger = Inf; % 一次Trigger后一直接收帧，直到接收到stop信号
triggerconfig(vid,"manual");


writerObj = VideoWriter('./test.mp4','MPEG-4');
writerObj.FrameRate = 150; %<=150
vid.DiskLogger = writerObj;

preview(vid);

% 获取相机使用权
start(vid); %start 这一句可能存在延迟，不要放在实际相机开始拍的调用里面

% 开始采集
trigger(vid);

% 等待采集完成
pause(5);

% 停止采集
stop(vid);
close(writerObj);

% disconnect video
delete(vid)
clear "vid"
```

### Matlab 怎么缩小 Gentl 协议相机视频分辨率

> 使用 Basler 自带 Pylon Viewer 软件，设置的视频分辨率，无法在 Matlab 里设置，所以需要额外设置

```matlab
vid = videoinput('gentl',1,'Mono8');
set(vid, 'ROIPosition', [400 0 960 640 ]);
```

|Parameters|Explanation|
| ----------| -----------------------------------------------------------------------------------------------------|
|​`XOffset`​|Position of the upper left corner of the ROI, measured in pixels.|
|​`YOffset`​|Position of the upper left corner of the ROI, measured in pixels.|
|​`Width`​|Width of the ROI, measured in pixels. The sum of `XOffset`​ and `Width`​ cannot exceed the width specified in `VideoResolution`​.|
|​`Height`​|Height of the ROI, measured in pixels. The sum of `YOffset`​ and `Height`​ cannot exceed the height specified in `VideoResolution`​.|
