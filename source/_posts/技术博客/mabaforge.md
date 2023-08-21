---
title: 安装mambaforge
date:  '2023-04-25 23:58:42'
updated: '2023-04-25 23:58:42'
excerpt: 还在用conda？
tags:
  - 配置
  - Python
categories:
  - 技术博客
comments: true
abbrlink: c6467c9c
---



## 为什么要用mambaforge？

Anaconda 臃肿，

## 下载

[conda-forge/miniforge: A conda-forge distribution. (github.com)](https://github.com/conda-forge/miniforge)

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Windows-x86_64.exe
```

## 配置

mamba init：`~/.bash_profile`​添加

```bash


eval "$('/c/Users/Achuan-2/mambaforge/Scripts/conda.exe' 'shell.bash' 'hook')"

if [ -f "/c/Users/Achuan-2/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/c/Users/Achuan-2/mambaforge/etc/profile.d/mamba.sh"
fi

```

## 新建个人环境

新建个人环境，base环境不装东西

```bash
conda create -n achuan --clone base
```

安装基础包：vim equirements.txt

```plaintext
autopep8
numpy
pandas
tqdm
pandas
matplotlib
Pillow
seaborn
ipympl
ipykernel
scikit-image
jupyterlab
```

安装

```bash
mamba install --yes --file requirements.txt
```

## 配置镜像

​`vim ~/.condarc`​

```bash

conda config



conda config --add channels bioconda
#conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
#conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/


conda config --get channels


conda config --set show_channel_urls yes

#恢复默认镜像
conda config --remove-key channels

```

## 问题

### windows 不支持mamba init，只能用conda activate来切换环境

```bash
'gbk' codec can't decode byte 0xaa in position 347: illegal multibyte sequence
An unexpected error has occurred. Conda has prepared the above report
```

* 解决方法

  C:\Users\Achuan-2\mambaforge\Lib\site-packages\mamba\mamba_shell_init.py

  ```diff
  - 35 with open(file, "r") as fi:
  + 35 with open(file, "r",encoding="utf-8") as fi:
  ```
