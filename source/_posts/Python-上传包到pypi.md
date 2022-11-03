---
title: Python 上传包到pypi
tags:
  - Python
  - Coding
abbrlink: d2b2fba7
excerpt: 阿巛同学第一个上传到Pypi的包
date: 2022-11-04 00:57:58
updated: 2022-11-04 00:57:58
---

> 要学会可以创建属于自己的轮子！
>

阿巛同学第一个上传到Pypi的包：[https://pypi.org/project/pairwiseAlignment/](https://pypi.org/project/pairwiseAlignment/)

## 准备工作

* 注册[pypi](https://pypi.org/)，创建一个`$HOME/.pypirc`​文件，里面填入token（在[Account settings ](https://pypi.org/manage/account/)获取）

  ```ini
  [pypi]
    username = __token__
    password = pypi生成的token
  ```
* 把之前的代码文件全部放入一个新的文件夹里，在外部生成下面这些文件

  * README.md
  * setup.py

    ```python
    from setuptools import setup,find_packages
    from os import path
    from PairwiseAlignment import __version__

    here = path.abspath(path.dirname(__file__))

    with open(path.join(here, 'requirements.txt'), 'r', encoding='utf-8') as f:
        all_reqs = f.read().split('\n')
        install_requires = [x.strip() for x in all_reqs if 'git+' not in x]

    with open(path.join(here, 'README.md'), 'r', encoding='utf-8') as f:
        long_description = f.read()

    setup(
        name='pairwiseAlignment',  # 必填，项目的名字，用户根据这个名字安装，pip install pairwiseAlignment
        version=__version__, # 必填，项目的版本，建议遵循语义化版本规范
        author='Achuan-2',  # 项目的作者
        description='Using Python to implement Needleman Wunsch and Smith Waterman algorithms',  # 项目的一个简短描述
        long_description=long_description,  # 项目的详细说明，通常读取 README.md 文件的内容
        long_description_content_type='text/markdown',  # 描述的格式，可选的值： text/plain, text/x-rst, and text/markdown
        author_email='achuan-2@outlook.com',  # 作者的有效邮箱地址
        url='https://github.com/Achuan-2/mini/tree/main/pairwiseAlignment',  # 项目的源码地址
        include_package_data=True,
        py_modules=['pairwiseAlignment'],
        platforms='any', # 项目的运行平台，可选的值：any, windows, linux, macos, unix, os2, ce, java, and riscos
        packages=find_packages(), # 项目的包列表，如果项目只有一个包，那么这个参数可以省略
        python_requires='>=3.7',  # 项目的 Python 版本要求
        license='MIT', # 项目的许可证
        install_requires=install_requires,
        #  下面的设置将在命令行提供一个叫做 pairwiseAlignment 的命令，用来执行 main.py 的 main 方法
        entry_points={
            'console_scripts': {
                'pairwiseAlignment= PairwiseAlignment.run:main'
            },
        },
    )
    ```
  * LICENSE.txt

    ```
    Copyright (c) 2022 The Python Packaging Authority
     
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
     
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
     
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
    ```
  * MANIFEST.in

    ```c
    include requirements.txt
    include README.md
    ```
  * requirements.txt

    ```shell
    pipreqs ./ --encoding=utf8
    ```
* 之后目录架构

  ```shell
  |-- PairwiseAlignment/（要上传的代码方在一个文件夹）
  |   |-- __init__.py
  |   |-- __pycache__/
  |   |-- run.py
  |   `-- src/
  |-- CHANGELOG.md
  |-- LICENSE.txt
  |-- MANIFEST.in
  |-- README.md
  |-- requirements.txt
  `-- setup.py
  ```

  * 由于现在代码变为包了，所以要注意包内的自定义模块导入方式，比如.代表同级，..代表上一级
* 安装所需要的包

  ```bash
  pip install build
  pip install twine
  ```

## 测试

直接安装测试

```bash
python setup.py install
```

运行对于程序的命令，检测有无问题

## 上传

```bash
python -m build # 打包
twine upload dist/* # 上传包到pypi
rm -r dist build *.egg-info # 删除临时文件
```

‍