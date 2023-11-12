---
title: Matlab 基础编程语法
date: '2023-11-13 00:53:59'
updated: '2023-11-13 00:54:01'
excerpt: 简单整理Matlab的数据类型和编程逻辑语法，作为速查手册
tags:
  - Matlab
categories:
  - 技术博客
permalink: matlab-basic-programming-grammar-1ghj9i.html
comments: true
toc: true
---



## 数据结构概览

* int、float、complex
* logical：true、false
* char `' '`​ & string `" "`​
* array：`[]`​
* strcuct: `()`​ & `.`​
* cell: `{}`​
* others

  * function handle
  * table
  * map
  * datetime

## 条件语句

* if...elseif...else...end

  ```matlab
  if expression1
      <statements1>

  elseif expression2
      <statements2>

  else
      <statements3>

  end
  ```
* switch...end

  ```matlab
  switch <expression>
     case <value1>
        <statements1>
     case {<value2>,<value3} % 可以合并多种情况
        <statements2>
     otherwise
        <statements3>
  end
  ```

  * 当情况(`case`​​​)为真时，MATLAB 会执行相应的语句，然后退出 `switch`​​​块。
  * ​`otherwise`​​​块是可选的，并且仅在没有 `case`​​​为真时执行。

## 循环语句

* while...end

  ```matlab
  while <expression>
     <statements>
  end
  ```
* for...end

  ```matlab
  for index = values
     <statements>
  end
  ```

  * values 可以是循环一整个 valArray 的每个元素，这点和 python 很像

## 函数

* 单函数定义

  * 普通函数

    ```matlab
    function [out1,out2, ..., outN] = myfun(in1,in2,in3, ..., inN)
    % Annotation
        expression
    end
    ```

    注：Matlab 2019b起函数已经支持设置默认值、键值对传参、参数验证等功能了，详见[Matlab  arguments 让函数回归函数](/matlab-arguments-to-return-the-function-to-the-function-2e76vf)
  * 匿名函数

    语法

    ```matlab
    f = @(arglist)expression
    ```

    例子

    ```matlab
    power = @(x, n) x.^n;
    result1 = power(7, 3)
    result2 = power(49, 0.5)
    result3 = power(10, -10)
    result4 = power (4.5, 1.5)
    ```
* 多函数的定义：自上而下书写，主函数写在最前面

  ```matlab
  function hello()
      fprintf("hello matlab\n")
      hello2()
  end

  function hello2()
      fprintf("hello matlab2\n")
  end
  ```
* 函数的嵌套

  ```matlab
  function x = A(p1, p2)
  ...
  	B(p2)
      function y = B(p3)
      ...
      end
  ...
  end
  ```
* 函数的调用：

  * 单文件：函数定义放在调用之后
  * 多文件：

    * 通过<u>文件名</u>来调用的，而不是函数名！！！
    * <u>第一个函数</u>会被认为是主函数，按惯例与 m 文件同名
* 其他

  * 函数体中提供了两个名为 [`nargin`]()​​​​ 和 [`nargout`]()​​​​的数量，方便记录输入变量和输出变量
  * 关于 end：虽然它有时是可选的，但使用 `end`​​​​ 可提高代码可读性。所以一般还是加上

## 类

这里简单展示 Matlab 和 Python 面向对象语法

Matlab 面向对象语法

```matlab
classdef demo < parent
    properties  (Access = public) 
        property1
        property2 logical = true;  % set type and default value
    end

    methods (Access = public)
	% Constructor
        function self = demo(va1, val2)
            self.property1 = val1
        end
	methods
	% Class public method
        function fun1(self,val)
            <statements1>
        end
	end
    methods (Access = private)
	% Class private method
        function fun2(self,val)
             <statements2>
        end
    end
end
```
Python 面向对象语法

```python
class Demo(Parent):
    def __init__(self, val1, val2):
        super().__init__()
        self.property1 = val1
        self.property2 = True  # Default value

    def fun1(self, val):
        # <statements1>
        pass

    def _fun2(self, val):
        # <statements2>
        pass
```
