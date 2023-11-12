---
title: Matlab 'Hello World' vs "Hello World" 单引号和双引号有何区别
date: '2023-11-13 02:24:10'
updated: '2023-11-13 02:24:12'
excerpt: Matlab 的单引号和双引号包裹字符代表的意义有所不同，不像 Python 几乎没有区别，使用需要注意
tags:
  - Matlab
categories:
  - 技术博客
permalink: >-
  post/what-is-the-difference-between-matlab-hello-world-vs-hello-world-single-quotation-number-and-dual-quotation-number-z1ynuyi.html
comments: true
toc: true
---



​`'Hello World'`​单引号是字符数组 char ，`"Hello World"`​ 双引号是单个字符串标量string scalar，字符串数组是`["Hello", "World"]`​

下面具体罗列了它们的区别：

## 索引

单引号 `'Hello World'`​有多个字符，会认为是字符数组，即各个字符可以通过索引来提取

```matlab
>> a = 'Hello World';
>> a(1)

ans =

    'H'
```

而双引号 `"Hello World"`​ 会被认为是单个字符串，无法直接用索引获取子字符串，需要用`extract`​函数来提取子字符串

```matlab
>> b = "Hello World";
>> b(1)

ans = 

    "Hello World"
>> extract(b,1)

ans = 

    "H"
```

## 拼接

* 方括号`[]`​拼接方式只适用于 char，因为本质上char就是数组，本质上就是在用逗号合并数组的方法合并字符数组。

  ```matlab
  >> ['Hello','World'] 

  ans =

      'HelloWorld'

  >> ["Hello","World"]

  ans = 

    1×2 string 数组

      "Hello"    "World"
  ```
* 加号`+`​拼接方式只用于 string

  ```matlab
  >> 'Hello' + 'World'

  ans =

     159   212   222   216   211

  >> "Hello" + "World"

  ans = 

      "HelloWorld"
  ```
* 函数`strcat`​既可用于string也可用于char

  ```matlab
  >> strcat('Hello','World')

  ans =

      'HelloWorld'

  >> strcat("Hello","World")

  ans = 

      "HelloWorld"
  ```

## 判断字符数

* 函数`length`​只能用于char，用于string只会返回1

  ```matlab
  >> length('Hello World')

  ans =

      11

  >> length("Hello World")

  ans =

       1
  ```
* 判断字符是否为空，string也不能用 `isempty `​判断是否为空

  ```matlab
  >> isempty('')

  ans =

    logical

     1

  >> isempty("")

  ans =

    logical

     0
  ```
* 判断字符数的最佳做法是使用 `strlength`​ 函数。无论输入是字符串标量还是字符数组，都可以返回正确的数字，也可以用来判断字符是否为空

  ```matlab
  >> strlength('Hello World')

  ans =

      11

  >> strlength("Hello World")

  ans =

      11

  >> logical(strlength(''))

  ans =

    logical

     0

  >> logical(strlength(""))

  ans =

    logical

     0
  ```

## 函数传参

目前一般函数的字符传参都是支持char和string混用的，不过还是需要注意下函数说明。

但以命令形式使用 `cd`​、`dir`​、`copyfile`​ 或 `load`​ 等函数时，应避免使用双引号。在命令形式中，双引号被视为字面文本的一部分，而不是字符串构造运算符，因此导致报错。

```matlab
>> cd "C:\Program Files"
错误使用 cd
输入参数太多。
```

> ​`cd "C:\Program Files"`​ 等效于 ​`cd('"C:\Program','Files"')`​

涉及空格，命令形式只支持用单引号包裹，或者改用函数形式才支持传入双引号

```matlab
cd 'C:\Program Files'
cd("C:\Program Files")
```

## Ref

* [有关字符串数组的常见问题解答 - MATLAB &amp; Simulink (mathworks.com)](https://www.mathworks.com/help/matlab/matlab_prog/frequently-asked-questions-about-string-arrays_zh_CN.html)

  * 为什么在命令形式中使用字符串会返回错误？
  * 为什么元胞数组中的字符串返回错误？
  * 为什么使用 length() 调用字符串会返回 1？
  * 为什么 isempty("") 返回 0？
  * 为什么使用方括号追加字符串返回多个字符串？
* [更新您的代码以接受字符串](https://ww2.mathworks.cn/help/matlab/matlab_prog/update-your-code-to-accept-strings.html#mw_7f89d759-1649-4135-bb88-d7ae4dd6f6e4)

  * Matlab更推荐函数传参使用字符串，因为其是对象，性能更好
