---
title: 思源笔记与Zotero联动详细教程：如何用思源笔记管理文献、写文献笔记、写论文初稿
date: '2025-06-29 10:18:45'
updated: '2025-06-30 10:07:25'
tags:
  - 思源笔记
  - 知识管理
categories:
  - 研究生的自我修养
permalink: >-
  /post/detailed-tutorial-on-linking-siyuan-notes-and-zotero-how-to-use-siyuan-notes-to-manage-literature-write-document-notes-and-write-first-draft-of-papers-28ub2m.html
comments: true
toc: true
---



![PixPin_2025-06-29_20-17-30](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_20-17-30-20250629201738-kugpcr1.png)

思源笔记目前靠[「文献引用插件」](https://github.com/WingDr/siyuan-plugin-citation)已经可以很好地与zotero联动了，可以引用Zotero文献在思源笔记生成笔记、自动把文献添加到思源笔记数据库并生成文献的基本信息，还可以把有引用文献的笔记一键导出为带文献引用格式的word文档，完成论文初稿的写作。

之前我也有简单介绍过思源笔记与zotero的联动的，不过介绍的都比较简单，只讲体验，没讲如何配置。由于有人给我打赏了20块，让我讲讲具体的联动教程，因此有了这篇文章，来详细讲讲思源笔记与Zotero联动的详细教程。

过去一些关于记文献笔记的分享：

- 号外！从此用思源笔记写论文不再是梦，思源笔记和Zotero终于实现完美联动
- [思源笔记丨我如何在思源笔记里记文献笔记](/post/how-did-i-remember-literature-notes-geqrg.html)
- Zotero丨快速复制引用和参考文献样式到PPT和其他笔记软件
- 20250302 反思自己的科研笔记和数据管理

---

**本文目录**

- 思源笔记与Zotero联动管理文献、写论文的好处
- Zotero基本配置

  - 复制笔记带回链
  - 设置zotero复制批注的笔记模板
  - 取消英文拼写纠正提示
  - Zotero如何快捷复制条目链接
- 思源笔记文献引用插件配置

  - 插件基本设置
  - Zotero安装debug-bridge 插件
  - 插件模板设置

    - 引用链接模板
    - 文献内容模板设置
    - 文献笔记模板设置
    - 用思源笔记的数据库管理文献
- 在思源笔记里如何引用Zotero文献
- 我是如何记文献笔记

  - 💡记Figure笔记
  - 💡记概念笔记
  - 💡手动构建独属于自己的知识网络
- 思源笔记如何写论文

## 思源笔记与Zotero联动管理文献、写论文的好处

1. **思源笔记可以用数据库直接管理zotero的文献，可以根据主题进行筛选和排序，可以很方便在数据库搜索想要的文献。**

    思源笔记的数据库功能相比notion，有一个改进，一个文档可以加入多个数据库，也就意味着数据库可以当**标签Plus功能**来用，相比其他笔记的标签功能，数据库除了汇集笔记功能，还自带笔记管理功能，很适合整理笔记。

    表格视图预览

    ![PixPin_2025-06-03_23-40-40](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-03_23-40-40-20250603234059-loh6kyz.png)

    画廊视图预览（思源笔记v3.2.0 数据库添加了画廊视图，画廊视图很适合来展示文献笔记，相比文献只是表格的方式展示在zotero，可以展示文献里的图片，更方便快速回顾文献内容。

    ![PixPin_2025-06-29_18-38-19](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_18-38-19-20250629183827-huv7k24.png)
2. **写笔记和整理参考文献在一个应用里完成：** 做好文献笔记后，就可以直接加入自己的文章初稿或者知识领域笔记里，不需要切换应用
3. **引用文献，可以悬浮预览文献笔记内容**

    > **目前word使用zotero引用文献如果使用GB国标引用格式，引用只有编号，是不方便查看引用是否正确的。**
    >

    ![PixPin_2025-06-04_08-20-48](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-04_08-20-48-20250604082053-y78l5sc.png)

## Zotero基本配置

### 复制笔记带回链

设置-导出-笔记格式，把Markdown和富文本的「包括Zotero链接」都勾选上

否则粘贴到思源笔记或者其他地方，可能会没有回链，无法跳转回zotero对应条目

![PixPin_2025-06-29_16-13-15](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_16-13-15-20250629161339-x5b946g.png)

有回链的效果

> “由于我们翻译的时间较为短促,加之我们英语和专业水平的限制, 本书难免会存在一些错误和不当之处,愿请读者予以指正。” ([Bear 等, 2023, p. 7](zotero://select/library/items/D7UTQYXN)) ([pdf](zotero://open-pdf/library/items/YWBB6P29?page=7&annotation=CSNY8FI7))

### 设置zotero复制批注的笔记模板

参考官方文档：[note templates [Zotero Documentation]](https://www.zotero.org/support/note_templates)

首选项-高级-编辑器设置：搜索`annotations.noteTemplates.highlight`​

![PixPin_2025-06-29_16-36-38](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_16-36-38-20250629163641-2vwyp4k.png)

![PixPin_2025-06-29_16-36-50](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_16-36-50-20250629163651-msi34l4.png)

默认模板

```html
<p>{{highlight}} {{citation}} {{comment}}</p>
```

个人模板：把批注用引述块包裹起来

```html
{{if comment}} 
    <blockquote>
	<blockquote>{{highlight}}
	</br> </br> 
	👉引自：{{citation}}
	</blockquote>  
	<p>{{comment}}</p> 
	</blockquote>
{{else}} 
    <blockquote>
	<blockquote>{{highlight}}
	</br></br> 
	👉引自：{{citation}}
	</blockquote>
	</blockquote>  
{{endif}}

```

复制pdf批注到思源笔记的效果（使用思源笔记Tsundoku主题，对引述块样式进行了优化）

![PixPin_2025-06-29_19-23-03](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_19-23-03-20250629192306-6vh11hg.png)

### 取消英文拼写纠正提示

首选项-高级-编辑器设置：搜索：extensions.spellcheck.inline.max-misspellings，改为0

### Zotero如何快捷复制条目链接

zotero批注笔记复制是自带链接的，但是如果想要复制文献条目的链接，就会有点麻烦，需要用插件

安装zotero-actions-tags插件：[https://github.com/windingwind/zotero-actions-tags](https://github.com/windingwind/zotero-actions-tags)

新建一个动作

![PixPin_2025-06-29_19-20-01](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_19-20-01-20250629192005-18nmfwq.png)

数据代码为

```js
// @author windingwind, garth74
// @link https://github.com/windingwind/zotero-actions-tags/discussions/115
// @usage Select an item in the library and press the assigned shortcut keys
// @update Mon, 22 Jan 2024 00:10:18 GMT (by new Date().toGMTString())

// EDIT THESE SETTINGS

/** @type {string} Name of the field to use as the link text. To use the citation key, set this to "citationKey". */
let linkTextField = "title";

/** @type {'html' | 'md' | 'plain'} What type of link to create. */
let linkType = "html";

/** @type {boolean} If true, make the link specific to the currently selected collection. */
let useColl = false;

/** @type {boolean} If true, use Better Notes zotero://note link when the selected item is a note. */
let useNoteLink = false;

/** @type {'select' | 'open-pdf' | 'auto'} Action of link*/
let linkAction = "auto"; // auto = open-pdf for PDFs and annotations, select for everything else

// END OF EDITABLE SETTINGS

// For efficiency, only execute once for all selected items
if (item) return;
item = items[0];
if (!item && !collection) return "[Copy Zotero Link] item is empty";

if (collection) {
  linkAction = "select";
  useColl = true;
}

if (linkAction === "auto") {
  if (item.isPDFAttachment() || item.isAnnotation()) {
    linkAction = "open-pdf";
  } else {
    linkAction = "select";
  }
}

const uriParts = [];
let uriParams = "";

let targetItem = item;
if (linkAction === "open-pdf") {
  uriParts.push("zotero://open-pdf");
  if (item.isRegularItem()) {
    targetItem = (await item.getBestAttachments()).find((att) =>
      att.isPDFAttachment()
    );
  } else if (item.isAnnotation()) {
    targetItem = item.parentItem;
    // If the item is an annotation, we want to open the PDF at the page of the annotation
    let pageIndex = 1;
    try {
      pageIndex = JSON.parse(item.annotationPosition).pageIndex + 1;
    } catch (e) {
      Zotero.warn(e);
    }
    uriParams = `?page=${pageIndex}&annotation=${item.key}`;
  }
} else {
  uriParts.push("zotero://select");
  if (item?.isAnnotation()) {
    targetItem = item.parentItem;
  }
}

if (!targetItem && !collection) return "[Copy Zotero Link] item is invalid";

// Get the link text using the `link_text_field` argument
let linkText;
if (collection) {
  // When `collection` is truthy, this script was triggered in the collection menu.
  // Use collection name if this is a collection link
  linkText = `${collection.name}`;
} else if (item.isAttachment()) {
  // Try to use top-level item for link text
  linkText = `${Zotero.Items.getTopLevel([item])[0].getField(linkTextField)}`;
} else if (item.isAnnotation()) {
  // Add the annotation text to the link text
  linkText = `${targetItem.getField(linkTextField)}(${
    item.annotationComment || item.annotationText || "annotation"
  })`;
} else {
  // Use the item's field
  linkText = item.getField(linkTextField);
}

// Add the library or group URI part (collection must go first)
let libraryType = (collection || item).library.libraryType;
if (libraryType === "user") {
  uriParts.push("library");
} else {
  uriParts.push(
    `groups/${Zotero.Libraries.get((collection || item).libraryID).groupID}`
  );
}

// If useColl, make the link collection specific
if (useColl) {
  // see https://forums.zotero.org/discussion/73893/zotero-select-for-collections
  let coll = collection || Zotero.getActiveZoteroPane().getSelectedCollection();

  // It's possible that a collection isn't selected. When that's the case,
  // this will fall back to the typical library behavior.

  // If a collection is selected, add the collections URI part
  if (!!coll) uriParts.push(`collections/${coll.key}`);
}

if (!collection) {
  // Add the item URI part
  uriParts.push(`items/${targetItem.key}`);
}

// Join the parts together
let uri = uriParts.join("/");

// Add the URI parameters
if (uriParams) {
  uri += uriParams;
}

if (useNoteLink && item?.isNote() && Zotero.BetterNotes) {
  uri = Zotero.BetterNotes.api.convert.note2link(item);
}

// Format the link and copy it to the clipboard
const clipboard = new Zotero.ActionsTags.api.utils.ClipboardHelper();
if (linkType == "html") {
  clipboard.addText(`《${linkText}》<a href="${uri}">link</a>`, "text/unicode");
} else if (linkType == "md") {
  clipboard.addText(`《${linkText}》[link](${uri})`, "text/unicode");
} else {
  clipboard.addText(uri, "text/unicode");
}

clipboard.addText(`《${linkText}》<a href="${uri}">link</a>`, "text/html");

clipboard.copy();

return `[Copy Zotero Link] link ${uri} copied.`;
```

这样就能右键直接复制条目链接

![PixPin_2025-06-29_19-21-42](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_19-21-42-20250629192154-f1v34hd.png)

## 思源笔记文献引用插件配置

这里分享我的配置，其他配置具体看插件README介绍

### 插件基本设置

- **数据库类型**：选择`Zotero（debug-bridge）`​
- **使用itemKey作为索引**：勾选

![PixPin_2025-06-29_17-15-07](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-15-07-20250629171517-0pk1bqt.png)

### Zotero安装debug-bridge 插件

> 参考： **[Run Javascript in Zotero](https://www.yuque.com/chentaotao-cf9fr/gthfy4/clqahv57w5ugmdev)**

**安装** **debug-bridge** **插件，插件地址：**​**[https://github.com/retorquere/zotero-better-bibtex/releases/tag/debug-bridge](https://github.com/retorquere/zotero-better-bibtex/releases/tag/debug-bridge)**

> 这个插件的作用是作为Zotero与外部应用程序的通信桥梁，外部程序可以通过HTTP接口与Zotero进行数据交互，允许第三方应用程序访问Zotero的数据和功能

菜单Tools—>Developer—>Run Javascript，运行如下代码（其中CTT为运行外部代码密码）：

![PixPin_2025-06-29_17-13-32](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-13-32-20250629171333-c8yqsu4.png)

Zotero 7在执行Javascript窗口，粘贴如下代码，点击执行

```js
Zotero.Prefs.set("extensions.zotero.debug-bridge.password","CTT",true);
```

![PixPin_2025-06-29_18-53-16](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_18-53-16-20250629185320-zw3cnyc.png)

在文献引用插件的设置里，也设置

- 「debug-bridge插件密码」为`CCT`​

  ![PixPin_2025-06-29_17-12-47](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-12-47-20250629171249-hodxqto.png)
- 「插入文献时使用的搜索面板」设置为`Siyuan`​

  ![PixPin_2025-06-29_17-21-00](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-21-00-20250629172103-0lobvcc.png)

  这样斜杆菜单「**插入文献引用**」调出的引用搜索面板就是在思源内部的搜索面板，搜索更快更稳定

  ![PixPin_2025-06-29_17-21-26](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-21-26-20250629172128-iz0jcel.png)

  ![PixPin_2025-06-29_17-20-42](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-20-42-20250629172045-zgfc2ia.png)

### 插件模板设置

#### 引用链接模板

我目前就设置了两个

- 作者-year：`({{shortAuthor}}, {{year}})`​

  ![PixPin_2025-06-29_17-17-02](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-17-02-20250629171706-53tv852.png)
- 标题：`{{title}}`​

  ![PixPin_2025-06-29_17-17-43](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-17-43-20250629171746-izfh1c0.png)​​​

插件之后引用文献后，之后右键菜单更换引用模板

![PixPin_2025-06-29_17-18-53](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-18-53-20250629171906-hgtbff9.png)

#### 文献内容模板设置

我这边只设置了「**文献内容文档标题模板**」为`《{{title}}》({{year}})`​

![PixPin_2025-06-29_17-24-53](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-24-53-20250629172454-4ccllmn.png)

这样我的文献笔记标题都是文献名字+年份

![PixPin_2025-06-29_17-26-31](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-26-31-20250629172637-zqgujg5.png)

至于「文献内容模板」我设置为`空`​，因为文献基础信息我会存储在思源笔记数据库里，文献笔记的模板可以调用思源笔记模板自动生成，这两个设置都在设置的第三栏「数据」里设置。

#### 文献笔记模板设置

这个插件过去为了同时在笔记里同步文献的基础信息并记录个人笔记，需要定义用户数据区域，用户数据区域存放个人笔记，其他部分可以存储文献基础信息

不过目前有了数据库之后，其实可以把整个文档当成用户数据区域，文献的基础信息就用数据库存储了

![PixPin_2025-06-29_17-28-55](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-28-55-20250629172856-zywrp8q.png)我的文献笔记模板如下：

```markdown
标题翻译：

## 文章摘要

- **研究的背景是什么**

  -
- **之前研究已经做过什么了**

  -
- **领域未解决的问题是什么？**

  -
- **作者是如何解决问题的**

  -
- **主要发现**

  -
- **研究创新点**

  -

## 作者背景


## 文章背景介绍


## 主要结果


## 可学习的研究方法


## 读完文献我学习了什么知识和概念，我有什么问题


## 本文总结、创新点与不足


## 论文结构和写作思路


## 与哪些已经读过的文献相关？与哪些自己感兴趣的主题笔记有关吗？


## 对我的课题有关吗？对我的课题有帮助吗？
```

如何在思源笔记创建这个模板

- 方法一：手动创建

  - 思源笔记的模板文件夹目录在工作空间/data/templates ，在这个文件夹新建`阅读文献模板.md`​，编写模板
- 方法二：直接导出

  - 在思源创建“阅读文献模板”这个笔记，编写好模板，直接导出即可

插件使用这个模板，把用户数据模板路径设置为`/data/templates/科研/阅读文献模板.md`​

#### 用思源笔记的数据库管理文献

思源笔记的数据库功能可以对文献进行筛选、排序，非常适合记录文献的基础信息和管理文献

![PixPin_2025-06-29_18-38-19](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_18-38-19-20250629183827-huv7k24.png)

我的数据库目前有12列

1. Block
2. 已读
3. Tag
4. 图片
5. 价值评分
6. 发表期刊
7. 通讯作者
8. 第一作者
9. 发表日期
10. 链接
11. Zotero URL
12. 总结和备注

其中下面这几列是可以通过插件，在引用的时候，自动把文献笔记插入数据库，同时填充内容的

- 发表期刊
- 通讯作者
- 第一作者
- 发表日期
- 链接
- Zotero URL

目前插件设置数据库模板比较麻烦，如果不懂编程的朋友，可以照着我的数据库，同样新建一样的列，然后把模板里的数据库列id替换为自己数据库对应的列id即可。

我的数据库属性模板如下

> 数据库列id和列名称的对应关系：
>
> - id: 20240104153321-cpzzkjn, 发表日期，列类型：日期
> - id: 20240225205034-qfeljra, 通讯作者，列类型：多选
> - id: 20240104153158-p1epwj9, 第一作者, 列类型： 多选
> - id: 20240104153236-i9v8625, 发表期刊, 列类型：select
> - id: 20241211174024-qbev7nn, Zotero URL, 列类型：url
> - id: 20240104153434-hjpc1fl, 链接, 列类型：url

```json
[
  {
    "keyID": "20240104153321-cpzzkjn",
    "value": {
      "date": {
        "content": {{ entry.issued && !isNaN(new Date(entry.issued))  ? new Date(entry.issued).getTime() : (year ? new Date(jsonObject.year, 0, 1).getTime() : '') }},
        "isNotEmpty": {{ year ? 'true' : 'false' }},
        "isNotTime": {{ year ? 'true' : 'false' }}
      }
    }
  },
  {
    "keyID": "20240225205034-qfeljra",
    "value": {
      "mSelect": [{
        "content": "{{ authorString ? authorString.split(', ').pop():'' }}",
        "color": "{{(Math.floor(Math.random() * 13) + 1).toString()}}"
      }]
    }
  },
  {
    "keyID": "20240104153158-p1epwj9",
    "value": {
      "mSelect": [{
        "content": "{{ authorString ? authorString.split(', ')?.[0]:'' }}",
        "color": "{{(Math.floor(Math.random() * 13) + 1).toString()}}"
      }]
    }
  },
  {
    "keyID": "20240104153236-i9v8625",
    "value": {
      "mSelect": [
        {
          "content": "{{ containerTitle? containerTitle: '' }}",
          "color": "{{(Math.floor(Math.random() * 13) + 1).toString()}}"  
        }
      ]
    }
  },
  {
    "keyID": "20241211174024-qbev7nn",
    "value": {
      "url": {
        "content": "{{ zoteroSelectURI }}"
      }
    }
  },
  {
    "keyID": "20240104153434-hjpc1fl",
    "value": {
      "url": {
        "content": "{{ DOI ? 'https://doi.org/'+DOI : (URL ? URL : '') }}"
      }
    }
  }
]
```

## 在思源笔记里如何引用Zotero文献

1. 方法一：Zotero选中文献后，斜杆菜单选择`引用Zotero中选中的文献`​，直接插入文献引用

    ![PixPin_2025-06-29_18-23-59](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_18-23-59-20250629182402-ig1e3g9.png)
2. 斜杆菜单选择`插入文献引用`​，搜索文献进行引用

    ![PixPin_2025-06-29_17-21-26](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-21-26-20250629172128-iz0jcel.png)

    ![PixPin_2025-06-29_17-20-42](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-29_17-20-42-20250629172045-zgfc2ia.png)
3. 直接用`[[`​来引用：如果一篇文献已经通过文献引用插件在思源笔记创建了笔记文档，在思源笔记引用这篇笔记文档，其实就是引用文献，导出word文档，笔记引用也会变为文献引用格式。

​​

## 我是如何记文献笔记

仅供参考

### 💡记Figure笔记

个人现阶段觉得，对文章内容的总结，很大程度上只需要对Figure进行总结就行了。

思源笔记支持笔记快捷分栏，我会把Figure放在左侧，右侧记Figure中每个子图讲了什么，我有哪些问题？

![PixPin_2024-12-14_10-48-13](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-14_10-48-13-20241214104816-imvjhwe.png)

### 💡记概念笔记

读每篇文献，你都能遇到新的概念新的知识，也能遇到之前了解过的概念。

记这些概念笔记，我会用 **「卡片笔记法」的概念**来记笔记，一个概念新建一个笔记，这样当我遇到文献又提到这个概念，我就可以继续完善这个笔记，而不是<span data-type="text" style="color: var(--b3-font-color1);">反反复复记同一个概念，但是这些笔记零散地在各处</span>，没有得到有效整合，这样不利于知识积累和复用。

我觉得双链笔记的双链功能在文献笔记里能体现出很有用的功能，但凡有一个文章，提到了这个概念，我就在文献笔记里引用这个概念笔记，这样打开概念笔记，你就能看到不同文章对这个概念的研究。

阅读完一篇文献，对这些引用的卡片概念笔记进行完善，把反链笔记整理进正文，

一个概念笔记积累的多了，最后这条概念笔记将会成为你的简易综述笔记，成为你独有的知识财富。

![PixPin_2024-12-14_11-30-08](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-14_11-30-08-20241214113015-hwrlmj1.png)

![PixPin_2024-12-14_16-40-20](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-14_16-40-20-20241214164033-1xfsjoi.png)

### 💡手动构建独属于自己的知识网络

不同文献笔记、不同概念笔记之间的相互引用，将会构建出独属于自己的知识网络，将零散的知识点连接成网络，形成系统化的知识框架，有助于把握研究领域全貌。

笔记软件里显示的笔记双链引用网络结构是自发形成的，个人认为不能过于依赖自动化生成的知识网络，因为这是自己是不熟悉的，没有仔细梳理出结构的，是不属于自己的。

于是，除了文献笔记、概念笔记，我还会手动创建一条条主题笔记，把我感兴趣的主题的相关信息进行汇总整理，进行更深入地学习与思考，这些主题笔记，才是独属于我的第二大脑。

现阶段AI可以很方便对一篇文献进行总结，也可以很快就罗列出一个领域的知识框架，但是就算AI描述地再正确，再详细，都只是没有进入自己大脑的信息，把信息处理为自己的资料，内化为自己的知识，最后再将知识辅助到实践，实际去应用，才是阅读和学习的最终目的，才能真正帮助个人成长。

知识管理上的一个常见误区便是，信息的积累并不等同于知识的掌握，记录笔记的行为也不等同于知识记忆的形成。

在这个方面上，AI只是工具，辅助我们更快阅读和记笔记，而不能替代个人思考、替代创建个人知识网络的步骤。

![PixPin_2024-12-14_15-28-46](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-14_15-28-46-20241214152849-2m4qgki.png)

![PixPin_2024-12-14_15-46-55](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-14_15-46-55-20241214154700-7yo3fvc.png)

## 思源笔记如何写论文

之前写过分享：号外！从此用思源笔记写论文不再是梦，思源笔记和Zotero终于实现完美联动

思源笔记可以引用zotero文献后，可以直接导出带引用格式的文献

搭配上我写的word模板[https://github.com/Achuan-2/pandoc_word_template](https://github.com/Achuan-2/pandoc_word_template)，可以直接从思源笔记导出一份格式还可以的论文初稿文档

1. 在思源笔记引用zotero文献

    ![PixPin_2025-06-03_23-20-19](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-03_23-20-19-20250603232020-ljbx1t9.png)
2. 用插件来导出word

    ![PixPin_2025-06-03_23-26-37](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-03_23-26-37-20250603232701-1ok04qd.png)
3. 查看导出的word：只需要点击zotero的Refresh按钮，更新zotero引用，就可以获得一份带文献引用的word文档

    ![PixPin_2025-06-03_23-20-16](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-03_23-20-16-20250603232017-qyo3sf6.png)

‍
