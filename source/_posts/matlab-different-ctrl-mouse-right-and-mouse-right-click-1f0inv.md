---
title: Matlab 区别 Ctrl+ 鼠标左键和鼠标右键单击
date: '2023-11-01 16:09:47'
updated: '2023-11-01 16:46:05'
excerpt: >-
  UIFigure.SelectionType 返回 alt 同时代表 Ctrl+ 左键或单击右键，而项目又需要 ctrl+
  左键和右键分别代表不同的事件，所以额外写了代码进行区分
tags:
  - Matlab
categories:
  - Notes
  - '11'
  - 技术博客
comments: true
toc: true
---



UIFigure.SelectionType 返回 alt 同时代表 Ctrl+ 左键或单击右键，而项目又需要 ctrl+ 左键和右键分别代表不同的事件，所以额外写了代码进行区分

```matlab
fig = uifigure();
fig.WindowButtonDownFcn = @figureClickCallback;
fig.KeyPressFcn = @figureKeyPressCallback;
fig.KeyReleaseFcn = @figureKeyReleaseCallback;
fig.UserData.CtrlPressed = false;


function figureClickCallback(src, ~)

    if  strcmp(src.SelectionType, 'alt') && src.UserData.CtrlPressed
        % Ctrl + Left Click
        disp('Ctrl + Left Click');
    elseif  strcmp(src.SelectionType, 'normal')
        % Left Click
        disp('Left Click');
        % Right Click
    elseif  strcmp(src.SelectionType, 'alt')
        disp('Right Click');
    end
end

function figureKeyPressCallback(src, event)
    if strcmp(event.Key, 'control')
        src.UserData.CtrlPressed = true;
    end
end

function figureKeyReleaseCallback(src, event)
    if strcmp(event.Key, 'control')
        src.UserData.CtrlPressed = false;
    end
end

```

> 💡 <span style="font-weight: bold;" data-type="strong"> </span> 这里妙用了Figure的UserData，设置一个CtrlPressed字段，不需要额外设置一个全局变量。

‍

‍
