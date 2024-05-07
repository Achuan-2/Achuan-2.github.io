---
title: Matlab 优化异常处理：fprintf的妙用
date: '2024-05-07 16:44:43'
updated: '2024-05-07 17:29:28'
excerpt: 优化Matlab try...catch.end 的报错提示，使其既能简单显示报错原因，需要时也可以查看具体报错位置。
tags:
  - 编程
  - Matlab
categories:
  - 其他笔记
permalink: >-
  /post/matlab-optimization-abnormal-processing-fprintf-s-wonderful-use-z2wefdb.html
comments: true
toc: true
---



​![Matlab 优化异常处理：fprintf的妙用](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Matlab%20%E4%BC%98%E5%8C%96%E5%BC%82%E5%B8%B8%E5%A4%84%E7%90%86%EF%BC%9Afprintf%E7%9A%84%E5%A6%99%E7%94%A8-20240507170909-9a4kpt8.png)​

> **总结**
>
> 优化Matlab try...catch.end 的报错提示，使其既能简单显示报错原因，需要时也可以查看具体报错位置。

Matlab 如果给语句加了 try...catch.end，可以对异常错误进行处理，使得程序在遇到错误时不会立即停止，并可以修改输出把原本的代码报错变为用户能理解的错误原因。

比如下面这段代码，运行之后如果报错，就会提示错误原因

```matlab
try
    % 试图执行可能会出错的代码
    a = 1:5;
    b = 6;
    c = a(6);  
catch ME
    % 显示具体的错误信息
    fprintf(2,'%s\n', ME.message);
end
```

但是有一个问题——**就是不会显示到底哪一行出错了，不方便调试查看**

###### ​![Clip_2024-05-07_16-43-14](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-05-07_16-43-14-20240507164317-prk7b3f.png)​

‍

其实 matlab 的命令行不仅仅可以输出纯文字，**还可以输出超链接**，这个超链接除了可以跳转文字，**还可以执行命令**，比如将超链接的 href 设置为 `matlab:clc`​ 点击就可以清屏，设置为 `matlab:fprintf`​ 点击就可以输出文字！

所以我们可以把代码错误的具体位置信息封装起来，**需要的时候点击输出到控制台！这个报错的代码行号是可以直接点击跳转的！**

```matlab
try
    % 试图执行可能会出错的代码
    a = 1:5;
    b = 6;
    c = a(6);  
catch ME
    % 自定义显示简单错误信息  
    fprintf(2,'%s\n', ME.message);
  
    % 折叠代码报错位置
    errorReport = ME.getReport('extended');
    errorReport =  matlab.net.base64encode(unicode2native(errorReport, 'UTF-8'));
    errLink = ['<a href ="matlab:fprintf(2,''\n%s\n'', '...
        'native2unicode(matlab.net.base64decode(''' errorReport '''),''UTF-8''));">'...
        'View detailed error information</a>.'];
  
  
    % 点击自动清空窗口
    clcLink = '<a href ="matlab:clc">Clear command window</a>.';
    fprintf(2,'%s %s\n' ,errLink,clcLink);
end
```

​![Clip_2024-05-07_17-14-54](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-05-07_17-14-54-20240507171504-pkra6ve.png)​

包装为函数

```matlab
try
    % 试图执行可能会出错的代码
    a = 1:5;
    b = 6;
    c = a(6);  
catch ME
    % 自定义显示简单错误信息  
    fprintf(2,'%s\n', ME.message);
    reportError(ME);
end

% 优化异常处理
function reportError(ME)
    % 折叠代码报错位置
    errorReport = ME.getReport('extended');
    errorReport =  matlab.net.base64encode(unicode2native(errorReport, 'UTF-8'));
    errLink = ['<a href ="matlab:fprintf(2,''\n%s\n'', '...
        'native2unicode(matlab.net.base64decode(''' errorReport '''),''UTF-8''));">'...
        'View detailed error information</a>.'];
  
  
    % 点击自动清空窗口
    clcLink = '<a href ="matlab:clc">Clear command window</a>.';
    fprintf(2,'%s %s\n' ,errLink,clcLink);
end
```

‍
