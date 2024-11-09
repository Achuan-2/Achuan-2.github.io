---
title: VSCode 解决Code runner运行python不能调用选择的conda环境问题
date: '2024-11-09 09:47:52'
updated: '2024-11-09 09:47:53'
excerpt: >-
  vscode 运行python，要选择指定的conda环境，可以点击右下角选择环境，然后用默认的运行代码按钮来运行python。


  但是我安装了code runner插件后，会把默认的python运行按钮隐藏，只显示code runner的运行代码按钮。点击code
  runner的运行代码按钮，默认选择的是base环境，而不是已经选择的conda环境，这会导致无法运行代码。
categories:
  - 编程笔记
permalink: >-
  /post/vscode-solves-the-code-runner-running-python-s-conda-environment-problem-that-cannot-be-called-5beyp.html
comments: true
toc: true
---



## 问题

vscode 运行python，要选择指定的conda环境，可以点击右下角选择环境，然后用默认的运行代码按钮来运行python。

​![PixPin_2024-11-08_09-20-25](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-08_09-20-25-20241108092033-he33vv5.png)​

但是我安装了code runner插件后，会把默认的python运行按钮隐藏，只显示code runner的运行代码按钮。点击code runner的运行代码按钮，默认选择的是base环境，而不是已经选择的conda环境，这会导致无法运行代码。​​

## 解决

在  **settings.json** 中设置：

```js
{
    "code-runner.executorMap": {
        "python": "$pythonPath $fullFileName"
    }
}
```

‍

## 参考

* [How to Use Code Runner in Python Virtual Environments - Sling Academy](https://www.slingacademy.com/article/how-to-use-code-runner-in-python-virtual-environments/)
