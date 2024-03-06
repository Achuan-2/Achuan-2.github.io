---
title: 用Python批量给扫描pdf添加书签
date: '2024-03-06 21:31:53'
updated: '2024-03-06 21:50:36'
excerpt: >-
  本文介绍了如何利用Python编写代码，实现将一个PDF文件中的书签导出到另一个PDF文件中的功能。同时，还展示了如何通过整理书籍目录，并将其转化为书签列表，快速添加书签到PDF文件中。通过这些方法，可以有效管理和导航大型PDF文件内容。
tags:
  - 电脑技巧
  - 编程
categories:
  - 电脑技巧
permalink: /post/scan-the-pdf-batch-with-python-batch-to-add-bookmarks-zn2z7s.html
comments: true
toc: true
---



我在Zlibrary下载了《神经科学：探索脑》第四版的中文电子版。

​![Clip_2024-03-06_21-46-50](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202403062150567.png)​

本来这个版本是有书签的，但是我想用ABBYY进行OCR识别，由于书有986页，全部一起OCR到中途会提示内存不足，我拆分为两份，分别进行OCR，然后再进行合并，但是后面就发现一个问题——原来的书签不见了！

那当然不可能再一个个敲

于是在GPT的帮助下，用python写了一个代码，可以批量把原先pdf的书签导出到另一个pdf去

```python
import fitz  # PyMuPDF:pip install pymupdf

def copy_bookmarks(source_pdf_path, target_pdf_path, output_pdf_path):
    # 打开源PDF和目标PDF文件
    source_pdf = fitz.open(source_pdf_path)
    target_pdf = fitz.open(target_pdf_path)
  
    # 从源PDF读取书签（大纲）
    bookmarks = source_pdf.get_toc(simple=False)
  
    # 将书签（大纲）添加到目标PDF
    target_pdf.set_toc(bookmarks)
  
    # 保存更改到新的PDF文件
    target_pdf.save(output_pdf_path)
  
    # 关闭PDF文件
    source_pdf.close()
    target_pdf.close()

# 源PDF路径（书签来源）
source_pdf_path = 'source.pdf'
# 目标PDF路径（需要添加书签的PDF）
target_pdf_path = 'target.pdf'
# 输出的PDF路径
output_pdf_path = 'output_with_bookmarks.pdf'

# 调用函数
copy_bookmarks(source_pdf_path, target_pdf_path, output_pdf_path)

print("书签导入完成。")

```

事情到这里本来就结束了，但是我又突然有一个idea，如果一个本来没有书签的pdf，我该如何快速的添加书签呢。

我的想法是，大多数书籍都会提供目录，我可以根据书上的目录快速整理出一个目录列表，然后再用程序把这个列表变为书签，导入的pdf里去

比如基于《探索脑》这本书的目录

​![Clip_2024-03-06_21-23-46](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202403062150471.png)​

我整理得到了这样一个列表

* 第 I 篇 基础@3

  * 第 1 章 神经科学：过去、现在和未来@3
  * 第 2 章 神经元和神经胶质细胞@23
  * 第 3 章 静息状态下的神经元膜@57
  * 第 4 章 动作电位@83
  * 第 5 章 突触传递@111
  * 第 6 章 神经递质系统@145
  * 第 7 章 神经系统的结构@181
  * 第 7 章附录  人体神经解剖学图解指南@221
* 第 II 篇 感觉和运动系统@267

  * 第 8 章 化学感觉@267
  * 第 9 章 眼睛@295
  * 第 10 章 中枢视觉系统@333
  * 第 11 章 听觉和前庭系统@371
  * 第 12 章 躯体感觉系统@417
  * 第 13 章 运动的脊髓控制@455
  * 第 14 章 运动的脑控制@487
* 第 III 篇  脑和行为@525

  * 第 15 章 脑和行为的化学调控@525
  * 第 16 章 动机@555
  * 第 17 章 性与脑@585
  * 第 18 章 情绪的脑机制@621
  * 第 19 章 脑的节律和睡眠@651
  * 第 20 章 语言@691
  * 第 21 章 静息态的脑、注意及意识@725
  * 第 22 章 精神疾病@757
* 第 IV 篇  变化的脑@789

  * 第 23 章 脑连接的形成@789
  * 第 24 章 记忆系统@827
  * 第 25 章 学习和记忆的分子机制@869
* 术语表@905
* 参考文献@927

然后再根据代码，将这个列表转化为书签，导入到pdf即可

转换代码

```python
import fitz  # PyMuPDF:pip install pymupdf
def parse_bookmarks_from_txt(txt_path,offset):
    """
    解析txt文件中的书签信息。
    txt文件的书签信息格式为markdown多级列表，根据缩进来确定层级。
    """
    bookmarks = []
    with open(txt_path, 'r', encoding='utf-8') as file:
        for line in file:
            if line.strip():  # 跳过空行
                # 计算行前的空格数来确定层级
                # 假设每个层级的缩进是1个空格，可以根据实际情况调整
                indent = len(line) - len(line.lstrip())
                level = indent // 2 + 1  # 计算层级，假定每1个空格代表一级缩进
                # 移除星号和空格，然后分割标题和页码
                title, page = line.strip().removeprefix('*').strip().split('@')
                bookmarks.append([level, title.strip(), int(page)+offset])
    return bookmarks




def add_bookmarks_to_pdf(pdf_path, output_pdf_path,bookmarks):
    """
    将格式化后的书签信息添加到指定的PDF文件中。
    :param pdf_path: PDF文件的路径
    :param bookmarks: 要添加的书签列表，格式为[[level, title, page], ...]
    """
    # 打开PDF文件
    doc = fitz.open(pdf_path)
  
    doc.set_toc(bookmarks)
    # 保存更改到新的PDF文件中，以防覆盖原文件
    doc.save(output_pdf_path)
    doc.close()
    print(f"书签已添加到新的PDF文件中：{output_pdf_path}")


# 1.将书签从txt文件解析并转换为pymupdf格式
txt_path = 'bookmarks.txt'  # 假设书签信息存储在bookmarks.txt文件中
bookmarks = parse_bookmarks_from_txt(txt_path,offset=32)

# 2.添加书签到PDF
pdf_path = r"C:\Users\Achuan-2\Downloads\神经科学：探索脑（第四版）OCR.pdf" # 替换为目标PDF文件的路径
output_pdf_path = r"C:\Users\Achuan-2\Downloads\神经科学：探索脑（第四版）test.pdf"
add_bookmarks_to_pdf(pdf_path, output_pdf_path,bookmarks)
```

> 注意：因为目录和实际的pdf页码有差别，需要考虑offset，比如这本书目录和实际pdf页码差距为32，需要给目录的页码都加上32.
