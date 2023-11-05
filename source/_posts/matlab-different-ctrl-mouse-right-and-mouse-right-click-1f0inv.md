---
title: Matlab 区别 Ctrl+ 鼠标左键和鼠标右键单击
date: '2023-11-01 16:09:47'
updated: '2023-11-01 16:46:05'
excerpt: Matlab 非常脑残地用 alt 同时代表 Ctrl+ 左键或单击右键，而我的项目又需要 ctrl+ 左键和右键分别代表不同的事件，所以尝试写代码进行区分
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
abbrlink: dd948bab
---



Matlab 版本：2023b

Matlab 的 UIFigure WindowButtonDownFcn 回调可以监听鼠标点击事件，UIFigure.SelectionType 记录了鼠标点击情况，只返回以下四个值：

* normal：代表单击鼠标左键；
* extend：代表 Shift+ 左键、鼠标中键或左右键一起按

  * 备注：实测左右键一起按没用，事实上一般人也不会左右键一起按
* alt：代表 Ctrl+ 左键，或者单击右键；
* open：代表双击鼠标任意键

  * 备注：我实测只有双击鼠标左键才会返回 open，双击右键不会

可以看到 Matlab 非常脑残地用 alt 同时代表 Ctrl+左键或单击右键，而我的项目又需要 Ctrl+ 左键和右键分别代表不同的事件，所以尝试写代码进行区分：

```matlab
fig = uifigure();
fig.WindowButtonDownFcn = @figureClickCallback;
fig.WindowKeyPressFcn = @figureKeyPressCallback;
fig.WindowKeyReleaseFcn = @figureKeyReleaseCallback;
fig.UserData.CtrlPressed = false;
fig.UserData.ShiftPressed = false;

function figureClickCallback(src, ~)
    switch src.SelectionType
        case 'normal'
            disp('Left Click');
        case 'alt'
            if src.UserData.CtrlPressed
                disp('Ctrl + Left Click');
            else
                disp('Right Click');
            end
        case 'extend'
            if src.UserData.ShiftPressed
                disp('Shift + Left Click');
            else
                disp('Middle Click');
            end
        case 'open'
            disp("Double Click");
    end

end

function figureKeyPressCallback(src, event)
    switch event.Key
        case 'control'
             src.UserData.CtrlPressed = true;
        case 'shift'
            src.UserData.ShiftPressed = true;
    end
end

function figureKeyReleaseCallback(src, event)
    switch event.Key
        case 'control'
             src.UserData.CtrlPressed = false;
        case 'shift'
            src.UserData.ShiftPressed = false;
    end
end

```

> 💡 <span style="font-weight: bold;" data-type="strong"> </span> 这里妙用了 Figure 的 UserData，设置一个 CtrlPressed 和 ShiftPressed 字段来存储是否按住了 Ctrl 和 Shift 键，不需要额外设置一个全局变量。

> ⚠ 注意：Matlab UIFigure KeyPressFcn 和 WindowKeyPressFcn 不一样
>
> * ​`KeyPressFcn`​​ is evaluated only when the figure has focus (but not its children).
> * ​`WindowKeyPressFcn`​​, on the other hand, is evaluated whenever the figure or any of its children has focus.
>
> 对于要判断Ctrl是否按下，需要用WindowKeyPressFcn，如果用KeyPressFcn，一旦点击GUI其他组件，可能就失效，而调用鼠标左键的函数了。
>
> ref：[matlab: difference between KeyPressFcn and WindowKeyPressFcn - Stack Overflow](https://stackoverflow.com/questions/25174400/matlab-difference-between-keypressfcn-and-windowkeypressfcn)

‍
