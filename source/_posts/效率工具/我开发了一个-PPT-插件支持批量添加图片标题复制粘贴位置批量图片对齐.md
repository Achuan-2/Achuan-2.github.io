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



​![PixPin_2025-01-17_10-35-03](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-01-17_10-35-03-20250117103514-3yy2417.png)​

## 📝开发背景

不知道有没有人和我一样，对PPT积怨已久😡：

💔**不能添加图片标题**：图片没法像word一样直接添加图片标题，只能手动插入文本框，对齐半天还歪七扭八！

💔**不能复制元素的位置粘贴给另一个元素**：不同页PPT的类似元素要保持同一个位置，只能复制粘贴再修改，无法直接复制粘贴位置

💔**不能图片自动排列整齐**： 插入多张图片后，想要多行多列整齐排列？要么一张一张手动拖动，对齐到天荒地老！要么先一列列水平对齐再垂直对齐

💔**不能插入代码块：**     只能从外部编辑器（如VSCode）或专门网站复制粘贴，或者截图、生成图片粘贴代码块，有点麻烦

💔**不能插入latex数学公式：**     现在我基本上靠ai来识别和生成数学公式，公式都是latex数学公式格式，不方便直接粘贴到PPT里

……

市面上的ppt插件花里胡哨的功能一大堆，没几个能用得上。对我而言，每周要做研究生科研进展工作汇报，要的就是快速插入内容、做出内容清晰的PPT，不追求太美观。

在AI的帮助下，很快就把这些痛点功能都开发出来了   ！真的成就感满满！（这个插件99%的代码都是ai生成的，感谢AI老师！）

本着开源的精神，这个插件也在Github上开源了，欢迎大家给我点小星星！

Github地址：[https://github.com/Achuan-2/my_ppt_plugin](https://github.com/Achuan-2/my_ppt_plugin)

## ✨主要功能

* **批量添加图片标题**：支持<u>批量</u>选中图片后，批量在图片下方添加居中图题，支持设置图片和图题是否自动编组

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-20250116004806-2025-01-16-20250117115357-q22iq44.png)​
* **图片自动排列**：可以自动排列多张图片，支持设置每列多少张图片、列间距多少、行间距多少（默认为空，为列间距大小）、图片宽高

  * 注：如果不设置图片宽度或高度，则用第一张图片的高度来统一设置对齐时的图片高度

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-20250116004816-2025-01-16-20250117115358-zdoht5x.png)​
* **复制位置和粘贴元素位置**：可以复制多个元素的位置，粘贴给其他元素（可以多选复制和粘贴！），可以用来让不同页的PPT的多个元素位置一致，或者让同一页的不同元素都是一个位置（可以先排好一组元素，用这个功能让另一组元素自动排好，再调整位置）。​

  ​![复制粘贴位置](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/%E5%A4%8D%E5%88%B6%E7%B2%98%E8%B4%B4%E4%BD%8D%E7%BD%AE-20250117114924-suryz26.gif)​  
  ​​

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-%E5%A4%8D%E5%88%B6%E7%B2%98%E8%B4%B4%E4%BD%8D%E7%BD%AE-2025-01-16-20250117115359-8hc0bkr.gif)​
* **复制和粘贴元素宽高**：支持多选同时粘贴宽高，快速统一图片宽高
* **支持插入代码块自动高亮**

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-20250116004856-2025-01-16-20250117115359-wesh84d.png)​

  * **支持代码语言高亮列表**：matlab、python、js、html、css、csharp
  * **支持切换黑白背景色**：默认是黑色背景色，切换为背景色，只需要点击「代码黑色背景色」按钮取消激活状态即可
* **支持插入latex数学公式**

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-20250116004910-2025-01-16-20250117115400-htypznu.png)​
* **支持插入Markdown文本**：可以直接把markdown整篇笔记一口气全部粘贴到PPT里！并按原文顺序排列！

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-20250116004919-2025-01-16-20250117115400-22fbtpd.png)​

  * 支持行内格式：加粗、下划线、上标、下标、斜体、链接、行级代码、行级数学公式
  * 支持块级格式：标题、列表、代码块、表格、数学公式、引述块

    * 列表特别处理：

      * 保留列表悬挂缩进：常规粘贴html中的列表到PPT里会丢失悬挂缩进，本插件粘贴列表可以保留悬挂缩进
      * 支持任务列表粘贴，列表项符号会转化为☑和☐，代表完成和未完成
    * 代码块特别处理：

      * 独立文本框，支持设置黑白背景高亮配色，支持PPT直接再编辑
    * 表格特别处理：

      * 默认限制500px宽度，添加1pt黑色边框
    * 数学公式特别处理：

      * 独立文本框，支持PPT直接再编辑
    * 引述块特别处理：

      * 独立文本框，添加黑色边框

## 🪟支持环境

插件在Windows11 使用[Visual Studio Tools For Office](https://www.visualstudio.com/de/vs/office-tools/) 和C#语言开发，专为Microsoft Powerpoint设计，兼容安装到WPS（注：WPS版本不支持插入latex数学公式、插入markdown笔记）

插件只支持Windows端，不支持Mac端

## 🖥️安装方法

下载本插件Github页面[Release](https://github.com/Achuan-2/my_ppt_plugin/releases)中的Achuan.PPT.msi，解压，双击安装即可

注意：安装时需要先退出PPT，否则PPT不会即时加载该插件

## ❓常见问题

* **如何把插件的功能添加到PPT的快捷工具栏？**

  按钮右击，添加到「快速访问工具栏」即可

  ​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-PixPin_2025-01-16_16-56-07-2025-01-16-20250117115401-ehfsbsz.png)​

  可以把「快速访问工具栏」放在下方，更方便使用
* **添加图题的文本框只有文本宽度并且没有居中？**

  * 可能是设置了默认文本框导致的，需要将图题拉宽并设置居中后，设置居中图题为默认文本框
* **插入latex公式，显示不正常？**

  * 插件比较适合插入单行数学公式，对于复杂的多行语法，推荐使用IguanaTex插件
  * PPT特殊latex语法举例见：[https://github.com/Achuan-2/my_ppt_plugin/issues/7](https://github.com/Achuan-2/my_ppt_plugin/issues/7)

## ❤️ 用爱发电

如果喜欢我的插件，欢迎给GitHub仓库点star和捐赠，这会激励我继续完善此插件。

​![](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/network-asset-20241118182532-2024-11-18-20250117115401-upu4cfa.png)​

捐赠者列表见：https://www.yuque.com/achuan-2

## 🔍参考项目

* [jph00/latex-ppt: Use LaTeX in PowerPoint](https://github.com/jph00/latex-ppt)
