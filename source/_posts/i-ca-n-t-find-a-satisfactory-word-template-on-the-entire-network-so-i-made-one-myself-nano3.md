---
title: 全网找不到满意的 Markdown 转 Docx 模板，那就自己动手吧
date: '2023-12-15 00:14:47'
updated: '2023-12-15 11:14:36'
excerpt: "大多数 Markdown 笔记应用程序使用 Pandoc 将笔记转换为 Word 文档，例如我主要使用的思源笔记。然而，Pandoc 默认导出的 Word 文档样式往往不美观，不符合中文排版习惯。\n\n幸运的是，pandoc 可以自定义 Word 模板，用于导出时的自动格式化以美化文档，但是很奇怪的是，全网很少有人分享自己是如何具体制作模板的，就算提到也只是泛泛而谈。我自己在制作模板中遇到很多问题，比如怎么设置表格样式、怎么设置列表样式。2023 年 12 月 15 日，我终于突然解决了设置模板的有序列表和无序列表样式问题，使得自己的模板很大程度可用了，所以分享下目前在用的 word 模板，也当做一个抛砖引用，希望有更多人能分享自己的模板！\U0001F601"
tags:
  - Markdown
  - 折腾
  - 思源笔记
categories:
  - 其他笔记
permalink: >-
  /post/i-ca-n-t-find-a-satisfactory-word-template-on-the-entire-network-so-i-made-one-myself-nano3.html
comments: true
toc: true
abbrlink: 9a42c9c
---



> 大多数 Markdown 笔记应用程序使用 Pandoc 将笔记转换为 Word 文档，例如我主要使用的思源笔记。然而，Pandoc 默认导出的 Word 文档样式往往不美观，不符合中文排版习惯。
>
> 幸运的是，pandoc 可以自定义 Word 模板，用于导出时的自动格式化以美化文档，但是很奇怪的是，全网很少有人分享自己是如何具体制作模板的，就算提到也只是泛泛而谈。我自己在制作模板中遇到很多问题，比如怎么设置表格样式、怎么设置列表样式。2023 年 12 月 15 日，我终于突然解决了设置模板的有序列表和无序列表样式问题，使得自己的模板很大程度可用了，所以分享下目前在用的 word 模板，也当做一个抛砖引用，希望有更多人能分享自己的模板！😁

## 样式预览

pandoc 不设置模板导出 docx 的样式

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312151118881.png)​

设置本模板导出 docx 的样式

​​​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312151117278.png)​​​​

## 模板分享

有两个模板，一个标题自动编号，一个不自动编号，按需选用。

* Github：[Achuan-2/pandoc_word_template ](https://github.com/Achuan-2/pandoc_word_template)
* 蓝奏云：[https://achuan.lanzoul.com/b0f5y8sja](https://achuan.lanzoul.com/b0f5y8sja) （密码:a8om）

ps：如何从零创建模板我之前写过博客，具体见[设置 word 模板，Markdown 也能自动转换为美观规范的 Word 文档 - 知乎 ](https://zhuanlan.zhihu.com/p/581000852)。喜欢折腾的同学可以看看，不过还是建议基于此模板修改，因为默认列表样式你可能改不了（是我无意中搓出来的）。

## 如何使用此模板

以思源笔记为例，在【设置】-【导出】-【导出 Word .docx模板路径】设置模板文件地址即可。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312151143093.png)​

其他笔记软件请自行探索，pandoc是通过 `--reference-doc `​参数设置模板路径的，可以用命令行调用下面命令：

```bash
pandoc --reference-doc template.docx -s input.md  -o output.docx
```

​​​​

## 如何修改此模板

注意，要修改模板，需要更改每个类型对应的 Word 的样式，而不是只是自己改改样式就能 work 的。

### 一般样式

一般样式，只需要打开 word 的样式面板，鼠标点击改行，自动显示对应的样式，然后点击【修改】根据自己的需求修改样式就可以了

一般样式如下：

|        样式名         |                    描述                     |                                           本模板样式                                            |
| :-------------------: | :-----------------------------------------: | :---------------------------------------------------------------------------------------------: |
|     Normal（正文)     | word 的基础样式，还会应用于列表项和列表子项 |                 字号小四，中文字体为宋体，英文 Times New Roman<br />1.5 倍行距                  |
|    First Paragraph    |                  段落首段                   | 首行缩进，<br />字号小四，中文字体为宋体，英文 Times New Roman<br />1.5 倍行距，段前 9 磅<br /> |
| Body Text（正文文本） |       在正文段落中应用（除段落首段）        | 首行缩进，<br />字号小四，中文字体为宋体，英文 Times New Roman<br />1.5 倍行距，段前 9 磅<br /> |
|        Compact        |                 表格单元格                  |                          字号 10，中文字体为宋体，英文 Times New Roman                          |
|  Heading 1（标题 1）  |                  一级标题                   |    字号小二，加粗，中文字体为黑体，英文 Times New Roman，<br />段前 24 磅，段后 24 磅<br />     |
|  Heading 2（标题 2）  |                  二级标题                   |                      字号三号，加粗，中文字体为黑体，英文 Times New Roman                       |
|  Heading 3（标题 3）  |                  三级标题                   |                       字号 13，加粗，中文字体为黑体，英文 Times New Roman                       |
|  Heading 4（标题 4）  |                  四级标题                   |                         字号小四，中文字体为黑体，英文 Times New Roman                          |
|  Heading 5（标题 5）  |                  五级标题                   |                         字号小四，中文字体为黑体，英文 Times New Roman                          |
|  Heading 6（标题 6）  |                  六级标题                   |                         字号小四，中文字体为黑体，英文 Times New Roman                          |
| Block Text（文本块）  |                 引述块样式                  |                            四周添加 1 磅边框，左侧设置为 6 磅粗边框                             |
|      Source Code      |            行内代码和代码块样式             |                                底纹设置为灰色，四周添加 1 磅边框                                |

修改表格样式和列表样式比较特殊

### 表格样式

修改表格需要点击表格后，在【表设计】下拉，点击【修改表格样式】，进行修改

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312151117256.png)​

### 列表样式

#### 修改列表层级样式

> 所谓的层级样式是无序列表不同层级是圆点还是方块，有序列表则是不同层级的编号格式。

在下图 ① 的位置点击，可以看到列表样式有两个样式，分别对应无序列表和有序列表样式，右键修改。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312151114293.png)​

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312150020186.png)​

#### 修改列表缩进

鼠标点击列表所在行，右键点击【调整列表缩进】，选择【设置所有级别】

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312150014510.png)​

‍

## 模板已知问题

1. 图片无法自动居中，另外注意图片添加题注要居中的话，必须先让图片居中，再添加题注。
2. 模板可以做到表格整体居中，但是表格单元格自动居中需要思源笔记文档中的表格本身先设置居中，否则不居中。这是因为 markdown 表格默认是居左的，markdown 的居中语法如下：

   ```markdown
   | header 1 | header 2 |
   | :------: | :------: |
   |  cell 1  |  cell 2  |
   |  cell 3  |  cell 4  |
   |  cell 5  |  cell 6  |
   ```

## 我的探索过程记录

1. 有序列表和无序列表可以基于模板改动项目符号，老实说这是我误打误撞搞出来的 😂……目前自己都没能复现，所以大家不想折腾，还是基于本模板改动，且用且珍惜。
2. 有序列表和无序列表的行间距调整：每个列表项的间距与【正文】样式的行间距有关，此外列表项的子文本段落也是正文样式而不是【正文文本样式】（一般段落其实是【First Paragraph】、【正文文本】样式），所以需要调整列表行间距而改动【正文】样式是不太影响正文的（不过需要注意【First Paragraph】、【正文文本】样式都是基于【正文】样式改动的。为了让列表更美观，我把【正文】样式设置为 1.5 倍行距，不设置段前和段后距离，【First Paragraph】、【正文文本】会设置段前和段后距离
