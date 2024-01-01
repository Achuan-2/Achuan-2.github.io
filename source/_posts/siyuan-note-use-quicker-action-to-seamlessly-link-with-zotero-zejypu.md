---
title: 思源笔记|用quicker动作与zotero进行无缝联动
date: '2024-01-01 16:39:56'
updated: '2024-01-01 18:46:12'
excerpt: >-
  导出 word 之后使用该动作可以把 Zotero URL 变为 Zotero 引注，实现与原生 Zotero
  插件格式兼容，就可以愉快在思源写文章，然后直接导出 word 了，再搭配设计好的 word 模板，导出后基本就不需要怎么改了！
tags:
  - 思源笔记
  - Zotero
categories:
  - 电脑技巧
permalink: >-
  /post/siyuan-note-use-quicker-action-to-seamlessly-link-with-zotero-zejypu.html
comments: true
toc: true
---



开发者写的文档：[Siyuan 文献管理插件，实现与 Zotero 无缝对接 (yuque.com)](https://www.yuque.com/chentaotao-cf9fr/gthfy4/zd1m20wi0y27whla)

相关 quicker 动作

* [插入引用 - by ttChen - 动作信息 - Quicker (getquicker.net)](https://getquicker.net/Sharedaction?code=c864bb72-b1dc-447e-594d-08db837051fc&fromMyShare=true)
* [文献列表 - by ttChen - 动作信息 - Quicker (getquicker.net)](https://getquicker.net/Sharedaction?code=c064a200-45d1-4ad1-594e-08db837051fc&fromMyShare=true)
* [格式化 - by ttChen - 动作信息 - Quicker (getquicker.net)](https://getquicker.net/Sharedaction?code=451c8146-9948-419f-1267-08db84706690&fromMyShare=true)

## 功能简介

优点

* 引用文献插入的是 Zotero URL，<span style="font-weight: bold;" data-type="strong">不需要导入文档进思源</span>
* 导出 word 之后<span style="font-weight: bold;" data-type="strong">可以把 Zotero URL 变为 Zotero 引注</span>，实现与原生 Zotero 插件格式兼容，就可以愉快在思源写文章，然后直接导出 word 了，再搭配设计好的 word 模板，导出后基本就不需要怎么改了！

缺点：

* 插入文献不方便，需要在zotero先选中文献才能插入，选择多篇文献不方便，要是能弹出zotero内置的添加引注面板就好了

## 配置笔记

1. 需要安装 debug-bridge 插件，具体见 [Run Javascript in Zotero by Quicker (yuque.com)](https://www.yuque.com/chentaotao-cf9fr/gthfy4/clqahv57w5ugmdev?utm_source=ld246.com)
2. CSL 文献样式要求选择 Author+Year 样式，我是根据作者录屏所示选择的 Field Crops Research 样式，不知道其他样式行不行

   ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202401011847128.png)​

## 使用笔记

* <span style="font-weight: bold;" data-type="strong">插入文献</span>：

  * 需要打开 Zotero，先在 Zotero 主窗口中选择单条或多条，再点击 quicker 的「<span style="font-weight: bold;" data-type="strong">插入引用</span>」按钮
  * ⚠ 警告：点击 quicker 的「<span style="font-weight: bold;" data-type="strong">插入引用</span>」按钮，鼠标需要先聚焦在思源笔记的文字内
* <span style="font-weight: bold;" data-type="strong">导出 word 之后格式化 word 文档，使其与 Zotero 的 word 引用插件兼容</span>：

  * 将思源笔记的文档导出为 word 之后，打开 word 文档，点击 quicker 的「<span style="font-weight: bold;" data-type="strong">格式化</span>」按钮，将弹出选择 CSL 央视，选择完成后将自动格式化，将 Zotero URL 转换为 Zotero 引注格式
* <span style="font-weight: bold;" data-type="strong">思源笔记插入文献列表</span>

  * 点击 quicker 的「<span style="font-weight: bold;" data-type="strong">文献列表</span>」按钮，就可以在文档末尾插入文献列表，不过我觉得这个功能暂时并没有用，因为导出 word 后的格式化功能是不能将思源笔记的文献列表自动生成为 Zotero 的文献列表的

## 使用效果

思源笔记内的笔记样式

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202401011847399.png)​

直接导出word无处理的样式

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202401011847448.png)​

word格式化之后的样式

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202401011847378.png)​

## 使用的疑问

* <span style="font-weight: bold;" data-type="strong">现在引用格式主要支持 Author+year 样式，支持编号样式不？</span>

  * 目前只支持(Author,year)样式，编号样式，建议导出 word 后，用格式化转换实现。
* <span style="font-weight: bold;" data-type="strong">如果前面添加完一个引用，还想在同一句话再添加一个引用，有什么方便的方式吗？</span>

  * 解决方式1：一个个添加，再手动更改

    ([Cramer et al., 2021](zotero://select/items/1_YACNJ4QB)) → ([Cramer et al., 2021](zotero://select/items/1_YACNJ4QB);[Dana et al., 2019](zotero://select/items/1_GEWY7DEN))
  * 解决方式2：用高级搜索，使用匹配任意条件模式，就可以搜索多个，然后选中，再插入

    ​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202401011847944.png)​

## Ref

* [Siyuan 文献管理插件，实现与 Zotero 无缝对接 (yuque.com)](https://www.yuque.com/chentaotao-cf9fr/gthfy4/zd1m20wi0y27whla)
* [Siyuan 文献管理插件，实现与 Zotero 无缝对接 - 链滴 (ld246.com)](https://ld246.com/article/1689296953335)
