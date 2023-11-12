---
title: Matlab  arguments 让函数回归函数
date: '2023-11-05 17:30:50'
updated: '2023-11-05 17:48:27'
excerpt: >-
  Matlab  arguments 是Matlab 2019才有的语法，它让Matlab
  编写函数能以更简单的设置函数默认参数、支持键值对传参、支持参数验证以及自动参数类型转化等功能。习惯Python简单粗暴的编写函数的我，总算因为arguments这个语法，对Matlab的函数编写少了一丝敌意。目前class也是能用arguments语法对类属性进行设置。
tags:
  - Matlab
categories:
  - 技术博客
permalink: /posts/matlab-arguments-to-return-the-function-to-the-function-2e76vf.html
comments: true
toc: true
---



Matlab  arguments 是Matlab 2019才有的语法，它让Matlab 编写函数能以更简单的设置函数默认参数、支持键值对传参、支持参数验证以及自动参数类型转化等功能。习惯Python简单粗暴的编写函数的我，总算因为arguments这个语法，对Matlab的函数编写少了一丝敌意。目前class也是能用arguments语法对类属性进行设置。

## 语法概览

```matlab
arguments % 基本语法
    argName1 (dimensions) class {validators} = defaultValue
    ...
    argNameN ...
end

arguments (Input) % 验证输入参数
    argName1 (dimensions) class {validators} = defaultValue
    ...
    argNameN ...
end


arguments (Output) % 验证输出参数
    argName1 (dimensions) class {validators}
    ...
    argNameN ...
end

arguments (Input,Repeating) % 声明重复输入参数:可以重复输入两组组数据，如果不指定Output Repeating，需要调用的代码块支持输入重复两组数据，才能达到一次输入多次调用函数的效果
    argName1 (dimensions) class {validators} = defaultValue
    ...
    argNameN ... 
end

arguments (Output,Repeating) % % 声明重复输出参数: 与Input Repeating结合使用，可以达到一次输入多次调用函数的效果
    argName (dimensions) class {validators}
end
```

​`argName (dimensions) class {validators} = defaultValue`​​

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311051733668.png)​

1. ​`(dimensions)`​​ ：输入大小，指定为包含两个或多个数值的以逗号分隔的列表，如 `(1,2)`​​、`(3,5,2)`​​ 或 `(1,:)`​​。冒号表示该维度可以包含任意长度。

    * ​`(1, 1) `​：表示标量
    * ​`(1, :)`​：表示行向量
    * ​`(:, 1)`​：表示列向量
    * ​`(: , :)`​：表示必须是3行的矩阵.
    * ​`(3, 4)`​：表示必须是3行, 4列的矩阵.
2. ​`class`​ ：输入变量的类型:`double`​, `string`​,`char,`​ `cell,`​ 或者自定义的class。如果变量类型不符合，会自动进行转化，比如double类型被转化为uint8。
3. ​`{validators}`​ - 用于参数验证的函数，验证函数支持<span style="font-weight: bold;" data-type="strong">自定义。</span> 有关验证函数的列表，请参阅 [参数验证函数](https://ww2.mathworks.cn/help/matlab/matlab_prog/argument-validation-functions.html)。举例：

    * ​`mustBeNumeric`​、`mustBeNumericOrLogical`​、​`mustBeVector`​
    * ​`mustBeText`​​​、`mustBeTextScalar`​​​ 或 `mustBeNonZeroLengthText`​​​
    * 将 `style`​​​ 限制为字符串 `"--"`​​​ 和 `":"`​​​：`style {mustBeMember(style,["--",":"])}   `​​​
4. ​`defaultValue`​ - 默认值必须符合指定的大小、类型和验证规则。<span style="font-weight: bold;" data-type="strong">默认值也可以是表达式</span>。指定默认值会使该参数成为<span style="font-weight: bold;" data-type="strong">可选参数，函数调用传参时候可以不用传</span>。可选参数必须位于函数签名中和 `arguments`​ 块中的必需参数后。

## 我的使用笔记

### 支持设置默认参数

默认参数：像python一样设置默认参数

```matlab
function power_set_supply(app, options)
    % manual : https://www.siglent.com/u_file/download/22_11_24/SPD3303C_QuickStart_C02A.pdf
    % function : 设置电流电压并选择output
    arguments
        app Power_supply_control_20230508_Add_PMTcooling
        options.USBAddress string
        options.track uint8 = 0 %  0| 1| 2，分别表示（独立，串联，并联）
        options.currentCH1 double = 3.2
        options.currentCH2 double = 3.2
        options.voltageCH1 double = 12
        options.voltageCH2 double = 12
        options.ch1Output {mustBeNumericOrLogical} = false
        options.ch2Output {mustBeNumericOrLogical}  = false
    end
end
```

默认参数还可以是表达式

```matlab
function y = clip(x,x_min,x_max)
    arguments
        x
        x_min = min(x,[],'all')
        x_max = max(x,[],'all')
    end
    y=min(max(x,x_min),x_max);
end
```

class的properties也可以设置默认值等arguments的语法

```matlab
classdef ColorInRGB
   properties
      Color (1,3) = [1,0,0];
   end
   methods
      function obj = ColorInRGB(c)
         if nargin > 0
            obj.Color = c;
         end
      end
   end
end
```

### 参数验证

除了验证是数字、文本外，下面这个示例还可以设置style必须是指定的字符。

```matlab
function fRepeat(x,y,style)
    arguments (Repeating)
        x (1,:) double
        y (1,:) double
        style {mustBeMember(style,["--",":"])}   
    end
  
    % Reshape the cell arrays of inputs and call plot function
    z = reshape([x;y;style],1,[]);
    if ~isempty(z)
        plot(z{:});
    end
end
```

### 支持自动转化Output数据类型

自动把输出图像变为uint8类型。

```matlab
function rgb_image = rgb_add_area(rgb_image,roi_position,colormaps)
    % add roi to rgb mask
    arguments (Input)
        rgb_image (:,:,3) uint8
        roi_position (:,:) logical
        colormaps
    end
    arguments (Output)
        rgb_image uint8
    end
    % rgb_image = double(rgb_image);
    % Transform 2D logical array to 3D logical array to index 3D Array
    roi_3D = repmat(roi_position,1,1,3);
    % Assign a RGB to the specified position
    randowm_rgb_color = colormaps(randi([1,length(colormaps)]),:);
    rgb_image(roi_3D) = repmat(randowm_rgb_color,sum(roi_position,'all'),1);
end

```

### 支持name=value设置参数

设置默认参数后，函数调用的时候没输入参数也能使用

函数定义

```matlab
function y = myFunction(x,options)
	arguments 
    x
    options.Name1
    options.Name2
	end 

	y = x;
	disp(options);
end
```

函数调用

```matlab
>> myFunction(1,Name1="Hello",Name2="Matlab")
    Name1: "Hello"
    Name2: "Matlab"


ans =

     1
```

> ⚠注意：错误使用的常见报错
>
> 以下两个例子都是对位置参数使用键值对传参，导致的错误
>
> * 例子1：报错“输入参数太多”。
>
>   <span style="font-weight: bold;" data-type="strong">函数定义</span>
>
>   ```matlab
>   function y = myFunction(x)
>   	arguments 
>       x
>   	end 
>   	y = x;
>   end
>   ```
>
>   <span style="font-weight: bold;" data-type="strong">函数调用</span>
>
>   ```matlab
>   >> myFunction(x=1)
>   错误使用 myFunction
>   输入参数太多。
>
>   ```
> * 例子2：报错“函数要求名称 'Name1' 之前恰好有 1 个位置输入”。
>
>   <span style="font-weight: bold;" data-type="strong">函数定义</span>
>
>   ```matlab
>   function y = myFunction(x,options)
>   	arguments 
>       x
>       options.Name1
>       options.Name2
>       end 
>
>   	y = x;
>   	disp(options);
>   end
>   ```
>
>   <span style="font-weight: bold;" data-type="strong">函数调用</span>
>
>   ```matlab
>
>   >> myFunction(x=1,Name1="Hello",Name2="Matlab")
>   错误使用 myFunction
>    myFunction(x=1,Name1="Hello",Name2="Matlab")
>                 ↑
>   位置 2 处的参数无效。 函数要求名称 'Name1' 之前恰好有 1 个位置输入。
>   ```

## 官方示例

见：[声明函数参数验证 - MATLAB arguments - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/arguments.html)

## Ref

* [声明函数参数验证 - MATLAB arguments - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/arguments.html)
* [arguments: MATLAB输入检查的新语法 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/344538954)
* [[MATLAB]如何优雅地使用 arguments (一) - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/617993965)
