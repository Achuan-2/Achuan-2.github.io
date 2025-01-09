---
title: 我开发了一个PPT插件！支持批量添加图片标题，复制粘贴位置、批量图片对齐！
date: '2025-01-09 23:40:11'
updated: '2025-01-10 01:55:04'
categories:
  - 效率工具
permalink: >-
  /post/i-developed-a-ppt-plug-in-support-batch-additional-picture-title-copy-the-paste-location-and-align-batch-pictures-z1ap9ss.html
comments: true
toc: true
---



​![PixPin_2025-01-10_00-46-06](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-46-06-20250110004608-qhc3w3n.png)​

> 对PPT积怨已久😮‍💨：
>
> 💔**不能添加图片标题**：图片没法像word一样直接添加图片标题，只能手动插入文本框，对齐半天还歪七扭八！
>
> 💔**不能复制元素的位置粘贴给另一个元素**：不同页PPT的类似元素要保持同一个位置，只能复制粘贴再修改，无法直接复制粘贴位置
>
> 💔**不能图片批量对齐：**  插入多张图片后，想要整齐排列？要么一张一张手动拖动，对齐到天荒地老！要么先一列列水平对齐再垂直对齐
>
> 之前尝试过写宏代码，但是发现宏代码只能一个ppt文件用，使用很麻烦，就想着开发一个PPT插件。调研后发现主流是使用VSTO (Visual Studio Tools for Office)进行开发，可以可视化添加组件。
>
> 在AI的帮助下，我就花了一晚上时间，就把这些“梦寐以求”的功能都开发完了！开发完真的成就感满满！

插件已开源，Github地址：[https://github.com/Achuan-2/my_ppt_plugin](https://github.com/Achuan-2/my_ppt_plugin)

## 功能

* **批量添加图片标题**：支持选中图片后，批量在图片下方添加居中图题，添加图题之后图片和图题自动编组

  ​![PixPin_2025-01-10_00-52-28](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-52-28-20250110005230-o1tujc2.png)​

  * 实现方法：在图片正下方添加文本框，文本框的宽度为图片宽度大小，文字默认居中
* **复制位置和粘贴位置**：可以复制某个元素的位置，粘贴给另一个元素，可以用来让不同页的PPT的某个元素位置一致，或者让同一页的不同元素都是一个位置
* **复制和粘贴图片宽高**：统一图片宽高
* **图片自动对齐**：可以自动对齐图片，可以设置每列多少张图片、列间距多少、行间距多少（默认为空，为列间距大小）、图片宽高

  ​![PixPin_2025-01-10_00-52-32](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-52-32-20250110005235-jaikqek.png)​

## 安装方法

下载Release的Achuan.PPT.zip，解压，双击setup.exe安装即可

# 开发笔记丨如何制作一个PPT插件：使用VSTO制作

## 一、安装 Visual Studio

* VSTO (Visual Studio Tools for Office) 是 Visual Studio 的一部分，因此首先需要安装 Visual Studio。
* 建议安装 **Visual Studio 2022** 或更高版本，以获得最佳的开发体验和最新的功能支持。
* 在安装过程中，确保选择  **“Office/SharePoint 开发”**  工作负载。这会安装 VSTO 所需的组件。

  ​![PixPin_2025-01-09_23-53-56](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_23-53-56-20250109235359-szgf0o3.png)​

## 二、开发

### 1. 创建项目

* 在 Visual Studio 中，选择“创建新项目”。

  ​![PixPin_2025-01-09_19-58-58](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_19-58-58-20250109195859-vkh8kb1.png)​
* 选择“PowerPoint VSTO 外接程序（C#版本）”模板。

  ​![PixPin_2025-01-09_19-59-45](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_19-59-45-20250109195946-yemm4yu.png)​
* 为项目命名并选择存储位置。

  ​![PixPin_2025-01-09_20-01-42](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-01-42-20250109200144-68tft7g.png)​
* 点击“创建”。

### 2. 创建后存在的文件

**ThisAddIn.cs:**  这是外接程序的入口点。您可以在这里处理外接程序的启动和关闭事件，以及与 PowerPoint 应用程序的交互。

### 3. 新建**Ribbon1.cs**

**Ribbon1.cs:**  如果您需要自定义 PowerPoint 的 Ribbon 界面，此文件将包含 Ribbon 设计器和相关代码。

新建方法

* 添加-新建项

  ​![PixPin_2025-01-09_20-03-33](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-03-33-20250109200345-80hdupw.png)​
* 显示所有模板，选择【功能区（可视化设置器）】，点击添加

  ​![PixPin_2025-01-09_20-04-44](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-04-44-20250109200447-w9yg92c.png)​

  ​![PixPin_2025-01-09_20-04-14](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-04-14-20250109200427-3w8indr.png)​
* 文件新建后，出现可视化功能区控件

  ​![PixPin_2025-01-09_20-05-28](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-05-28-20250109200536-dzqfi3s.png)​
* 【搜索】添加【属性窗口】

  ​![PixPin_2025-01-09_20-08-02](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-08-02-20250109200804-gq313bf.png)​

  可以用来更改tab/按钮等的标签、图标等配置

  ​![PixPin_2025-01-09_20-10-51](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-10-51-20250109201052-ux2uo4f.png)​
* 【搜索】添加【工具箱】

  ​![PixPin_2025-01-09_20-09-46](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-09-46-20250109201007-pz5i3qh.png)​

  可以用来拖动控件，比如Button按钮、Menu等功能

  ​![PixPin_2025-01-09_20-14-01](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-14-01-20250109201406-kvezzum.png)​

  比如拖动两个Button到Group1里

  对Button进行双击，则可以新建click回调，写实际的按钮功能

  ​![PixPin_2025-01-09_20-44-43](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-09_20-44-43-20250109204445-yc0mb1l.png)​
* 设计完样式

  ​![PixPin_2025-01-10_00-41-47](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-41-47-20250110004149-hmsobo2.png)​

### 3. 编写代码

Ribbon1.cs模板：使用下面模板，之后再补充添加函数和回调。

```c#
using Microsoft.Office.Tools.Ribbon;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PowerPoint = Microsoft.Office.Interop.PowerPoint;
using Office = Microsoft.Office.Core;
using System.Windows.Forms;

namespace my_ppt_plugin
{
    public partial class Ribbon1
    {
        PowerPoint.Application app; //实例化PPT
        private void Ribbon1_Load(object sender, RibbonUIEventArgs e) //插件加载事件
        {
            app = Globals.ThisAddIn.Application; //实例化PPT对象
        }
    }
}

```

## 三、打包和部署

### 1. 发布

1. 首先，使用 Visual Studio 打开您的 VSTO 项目，将其设置为 Release 模式，并点击“生成-\>生成解决方案”。

    ​![PixPin_2025-01-10_00-37-41](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-37-41-20250110003743-d07adx6.png)​

    ​![PixPin_2025-01-10_00-38-06](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-38-06-20250110003808-7zupsoz.png)​
2. 接下来，选择“生成-\>发布 [项目名称]”，这将启动发布向导。请按照向导提示操作。

    ​![PixPin_2025-01-10_00-04-37](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-04-37-20250110000442-1sgzysk.png)​
3. 建议您将发布文件路径设置为与项目根目录同级的“publish”文件夹，以便于整理发布文件。

    ​![PixPin_2025-01-10_00-38-39](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-38-39-20250110003842-fckv733.png)​
4. 发布的文件

    ​![PixPin_2025-01-10_00-39-06](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-10_00-39-06-20250110003910-myb7l9z.png)​

### 2. 安装程序

点击setup.exe安装
