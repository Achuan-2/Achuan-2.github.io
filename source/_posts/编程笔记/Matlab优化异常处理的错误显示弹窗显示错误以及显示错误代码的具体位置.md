---
title: Matlab 优化异常处理的错误显示：弹窗显示错误以及显示错误代码的具体位置
date: '2025-04-02 07:53:52'
updated: '2025-04-02 07:53:56'
categories:
  - 编程笔记
permalink: >-
  /post/matlab-optimizes-error-display-for-exception-handling-popup-window-displays-errors-and-the-specific-location-of-the-error-code-to-display-vtexe.html
comments: true
toc: true
---





![PixPin_2025-03-31_00-17-44](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-31_00-17-44-20250331001745-q1pvmga.png)

Matlab 异常处理，如果catch语句用`disp(ME.message);`​，只会打印错误信息，不会显示报错位置，无法直接跳转到代码出错位置，也不方便确定代码错误的具体原因，这在Debug的时候并不方便

```matlab
try
    % 试图执行可能会出错的代码
    a = 1:5;
    c = a(6);  
catch ME % 捕获并显示错误信息
    % 命令行显示错误
    fprintf(2,'%s\n', ME.message);
end
```

![PixPin_2025-03-30_23-59-28](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-30_23-59-28-20250330235930-bz31wfn.png)

为此，下面代码进行了改进。捕捉到错误后，会弹窗提示错误，并且会在命令行显示详细的错误。

这种优化，个人觉得会非常好用，既适合用在Matlab 脚本里，也适合放在Matlab 写的APP程序里。APP使用异常处理机制，能避免出现报错后，影响APP其他按钮的功能执行，又能通过弹窗提示和命令行显示，告知错误位置。

```matlab
try
    % 试图执行可能会出错的代码
    a = 1:5;
    c = a(6);  
catch ME % 捕获并显示错误信息
    % 弹窗显示
    errordlg(ME.message, 'Error');
    % 命令行显示
    fprintf(2,'%s\n', ME.getReport('extended'));
end
```

![PixPin_2025-03-30_23-54-36](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-30_23-54-36-20250330235438-zixjx42.png)

如果你觉得命令行直接显示错误，不太好，会吓到用户，以及会把命令行正常的输出都淹没了。其实Matlab还支持把错误给折叠起来，命令行点击报错链接，才显示错误的具体内容

```matlab
try
    % 试图执行可能会出错的代码
    a = 1:5;
    c = a(6);  
catch ME % 捕获并显示错误信息
    % 弹窗显示
    errordlg(ME.message, 'Error');
    % 错误折叠输出，点击链接才展示
    reportError(ME);
end

% 异常处理折叠错误函数
function reportError(ME)
    % 折叠代码报错位置
    errorReport = ME.getReport('extended');
    errorReport =  matlab.net.base64encode(unicode2native(errorReport, 'UTF-8'));
    errLink = ['<a href ="matlab:fprintf(2,''\n%s\n'', '...
        'native2unicode(matlab.net.base64decode(''' errorReport '''),''UTF-8''));">'...
        'View detailed error information</a>.'];
  
  
    % 点击自动清空窗口
    clcLink = '<a href ="matlab:clc">Clear command window</a>.';
    fprintf(2,'%s\n', ME.message);
    fprintf(2,'%s %s\n' ,errLink,clcLink);
end
```

![PixPin_2025-03-31_00-03-42](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-03-31_00-03-42-20250331000346-kxlkqh6.png)

为什么能折叠错误，点击后能展开错误，背后的原理见：[Matlab 优化异常处理：fprintf的妙用](https://mp.weixin.qq.com/s/HrFvhl6mIwc6L61u7Y1njA)
