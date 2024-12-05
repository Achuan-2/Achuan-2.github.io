---
title: Python丨jupyter要重新调用修改后的自定义模块，应该怎么办
date: '2024-12-05 15:48:48'
updated: '2024-12-05 15:48:50'
excerpt: >-
  使用python进行数据分析，我一般喜欢在jupyter
  notebook里分析数据，如果分析任务重、需要对多组数据进行分析，我就会把函数抽取出来，放进自定义模块里，便于维护和复用。但是jupyter
  notebook有一个问题，import自定义模块之后，不会自动更新自定义模块。

  之前，函数没写好需要更改，我都是手动重启Jupyter内核，非常麻烦，还得重跑前面代码，如果前面代码运行时间久，就非常浪费时间，一度想要放弃jupyter
  notebook分析数据。

  现在发现jupyter其实有自动更新模块的魔法命令%autoreload
tags:
  - Python
categories:
  - 编程笔记
permalink: >-
  /post/python-gun-justyter-wants-to-re-call-the-modified-custom-module-what-should-i-do-1c0o5p.html
comments: true
toc: true
---



​![image](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/image-20240729180350-a3iakp9.png)​

使用python进行数据分析，我一般喜欢在jupyter notebook里分析数据，如果分析任务重、需要对多组数据进行分析，我就会把函数抽取出来，放进自定义模块里，便于维护和复用。但是jupyter notebook有一个问题，**import自定义模块之后，不会自动更新自定义模块**。

之前，函数没写好需要更改，我都是手动重启Jupyter内核，非常麻烦，还得重跑前面代码，如果前面代码运行时间久，就非常浪费时间，**一度想要放弃jupyter notebook分析数据**。

现在发现jupyter其实有自动更新模块的魔法命令`%autoreload`​

语法概览：

```python
# 设置自动重载
%load_ext autoreload

# 方案1：只重载指定import的模块
%autoreload 1
%aimport utils.func

# 方案2：全部重载
%autoreload 2
```

​`autoreload`​的意思是自动重新装入，它后面可带参数。

* **无参**：装入所有模块
* **0**：不执行装入命令。
* **1**：只装入所有%aimport 要装的模块。

  **选择性重新加载**：只重新加载那些使用 `%aimport`​ 明确指定的模块。

  **用法**：

  ```python
  %load_ext autoreload
  %autoreload 1
  %aimport your_module
  ```
* **2**：装入所有%aimport不包含的模块。

  **全面重新加载**：自动重新加载所有已导入的模块（除了一些系统模块）。

  **用法**：

  ```python
  %load_ext autoreload
  %autoreload 2
  ```

> **注意**
>
> * 如果导入一个模块之后，已经运行，后面进行修改之后，才添加`autoreload`​语句，是没法自动重载的，只能重启内核，所以**建议直接在jupyter的开头就添加autoreload命令**

## 示例

创建一个示例自定义模块 `mymodule.py`​，内容为

```python
def greet(name):
    return 'Hello, ' + name + '?'
```

用jupyter调用

​![Clip_2024-07-29_18-05-33](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/Clip_2024-07-29_18-05-33-20240729180540-nqbuy9y.png)​

对`mymodule.py`​进行更改，重新运行jupyter

​![Clip_2024-07-29_18-06-20](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/Clip_2024-07-29_18-06-20-20240729180621-qflvchz.png)​

发现输出没有改变

添加自动重载模块的魔法命令，并重启jupyter内核，发现输出改变

​![Clip_2024-07-29_18-07-26](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/Clip_2024-07-29_18-07-26-20240729180749-cmjq0z3.png)​

现在不需要重启内核，就可以自动重载

​![Clip_2024-07-29_18-08-18](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/Clip_2024-07-29_18-08-18-20240729180840-g9n4chq.png)​
