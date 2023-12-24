---
title: Matlab 2024a 尝鲜：函数编写体验大升级
date: '2023-12-24 02:35:31'
updated: '2023-12-24 22:12:54'
excerpt: >-
  在R2024a之前：脚本中的本地函数必须定义在文件末尾，在最后一行脚本代码之后。而2024a开始，Matlab终于对这一点进行了改进，可以在运行函数代码前面或后面添加函数！2024a把这类函数叫做local
  functions，即局部函数。
tags:
  - Matlab
categories:
  - 编程
permalink: >-
  /post/matlab-2024a-everbright-functional-writing-experience-big-upgrade-eao4i.html
comments: true
toc: true
---



旧电脑坏了买了台新电脑顶上，正打算装上 MATLAB，突然发现已经有 R2024a 预览版了。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312242213996.png)​

简单看了下介绍我就迫不及待地下载试用了，因为 R2024a 更新了一个非常重要的特性，函数可以在脚本文件的任意位置了！

在R2024a之前：脚本中的本地函数必须定义在文件末尾，在最后一行脚本代码之后。而2024a开始，Matlab终于对这一点进行了改进，可以在运行函数代码前面或后面添加函数！2024a把这类函数叫做local functions，即局部函数。

个人认为Matlab 现在改进这一点，更多是为了推广实时脚本（对标 python 的 jupyter notebook）而改进。实时脚本尽管加了很多UI控件，由于之前函数只能写在最后，对于要新建函数的代码编写和测试不是特别好用，要写函数要么新建一个函数文件要么把函数放在最后，代码写的不流畅。有了这一功能后，可以直接在块内新建一个函数并调用，这coding体验简直上了一个台阶！真的得夸夸！

此外，Matlab 还优化了函数 arguments 语法的编写体验，现在会自动填充输入参数变量，不需要再手动一个个填写，我个人觉得Matlab虽然目前不上python的函数编写体验（python 可以很方便的自定义函数参数默认值，键值对传参），arguments也比较繁琐，但 arguments 参数块的引入还是很大程度提高了 MATLAB 的函数编写体验，可以对输入参数进行类型验证和类型转换、设置参数默认值、键值对传参等功能，很建议没接触的朋友们学一学arguments 怎么使用，国内这块Matlab相关书籍和博客还是比较少提到的，直接查阅 MATLAB 文档就好了。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312242213754.png)​

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312242213979.png)​​

## Ref

* [2024a 更新内容](https://ww2.mathworks.cn/help/releases/R2024a/matlab/release-notes.html)
* [Add Functions to Scripts](https://ww2.mathworks.cn/help/releases/R2024a/matlab/matlab_prog/local-functions-in-scripts.html)
