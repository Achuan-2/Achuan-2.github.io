---
title: VSCode 配置 Matlab 运行环境
date: '2023-03-14 13:45:07'
updated: '2023-03-14 13:45:07'
excerpt: VSCode 也能用 Matlab
tags:
  - VSCode
  - Matlab
categories:
  - 其他笔记
comments: true
abbrlink: c873b400
---



## 需要的扩展

* [Matlab ](https://marketplace.visualstudio.com/items?itemName=Gimly81.matlab)：支持代码高亮、snippets、代码检查
* [matlab-formatter](https://marketplace.visualstudio.com/items?itemName=AffenWiesel.matlab-formatter)：设定缩进距离以及是否分隔块
* [Matlab Interactive Terminal - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=apommel.matlab-interactive-terminal)：调用了 matlab 官方提供的 python engine，无需打开 matlab 的 IDE 即可运行 matlab 终端

## 配置

### 为 Python 配置 Matlab 引擎的 API

在管理员模式打开终端，运行

```powershell
cd "C:\Program Files\MATLAB\R2022b\extern\engines\pythonn" python setup.py install
```

> 如果报错：​`error: [WinError 5] 拒绝访问。: 'dist\matlabengineforpython.egg-info'`​
>
> 说明没打开管理员模式。

### VSCode 的 Settings.json 配置

```json
  // ------matlab Start----------- //
  "files.associations": {
    "*.m": "matlab" // 为.m文件启动 Matlab 扩展
  },
  "matlab.linterEncoding": "utf8",  // 设置mlint返回结果编码为 utf8
  "matlab.matlabpath": "C:\\Program Files\\MATLAB\\R2022b\\bin\\matlab.exe", // 根据自己的路径设置matlab.exe路径
  "matlab.mlintpath": "C:\\Program Files\\MATLAB\\R2022b\\bin\\win64\\mlint.exe", // 根据自己的路径设置mlint.exe路径
  // ------matlab End----------- //
```

## 如何使用

打开 Matlab 终端：`Ctrl + Shift + P ​`​→ `Open a Matlab Terminal`​

运行当前打开的脚本：​`Ctrl + Shift + P ​`​→ `Run current Matlab Script`​

执行选中的部分代码：​`Ctrl + Shift + P ​`​→`Run current selection in Matlab`​

添加脚本到 Matlab 路径中，在 matlab 终端中输入 `pathtool`​，然后弹出如下窗口

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202308101027924.png)​​

## 不建议

* 使用 code runner 扩展跑 Matlab

  ```json
    "code-runner.executorMap": {
      "matlab": "cd $dir && matlab -nosplash -nodesktop -r $fileNameWithoutExt"
    },
  ```
* 使用 [Matlab Code Run](https://marketplace.visualstudio.com/items?itemName=bramvanbilsen.matlab-code-run) 扩展

## 参考

* [使用 vscode 编辑并运行 matlab 脚本 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/395486395)
