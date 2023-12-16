---
title: 思源笔记好搭档|最强剪贴板神器——CopyQ
date: '2023-12-16 17:45:29'
updated: '2023-12-16 19:47:59'
excerpt: >-
  之前一直很馋utools的剪贴板插件，可以对图片、文本进行分类，我最喜欢的剪贴板工具是CopyQ，一直觉得它很强大，却不知道该如何实现这个功能，一直以为不行，还傻傻去GitHub提了个feature
  request，后来得到热心大佬的分享，观摩（抄袭）了他的repo，突然发现自己过去是真的不会用CopyQ，所以写下这篇分享，记录目前的用法。
tags:
  - 思源笔记
  - CopyQ
categories:
  - 技术博客
permalink: >-
  /post/siyuan-notes-good-partner-the-strongest-clipboard-artifact-copyq-z2grwhp.html
comments: true
toc: true
---



​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161952592.png)​​

CopyQ官方网站：[CopyQ (hluk.github.io)](https://hluk.github.io/CopyQ/)

## 特色功能总结

* 可以同时保存文本、图片、文件等复制数据
* 支持搜索、筛选剪贴板
* 具备多标签页功能，可以通过拖拽实现item的所属标签页改动。
* 支持设置剪贴板数据，可以放在Onedrive、Synology Drive等同步盘进行多端同步
* 支持指定文本编辑器，我将其设置为Sublime Text3（类似于 VSCode 编辑器），利用强大的编辑器能力来处理复制的文本
* 支持设置命令和动作，可以调用copyq自带命令，能用JS编写命令，也可以用python写命令。你可以通过命令设置筛选图片、文件，去除复制文本的换行、使Copy具有复制文件、预览图片文件的能力等等额外功能
* 支持导出全部配置数据（包括标签页、外观主题、命令等），便于分享和备份配置。

‍

## 个人配置

### 布局设置

* 隐藏工具栏和工具栏文本标签
* 显示标签树（标签页会以树形展示在页面左侧）和显示标签页条目计数

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161952772.png)​

### 设置文本编辑器为sublime text3

* 先在<u>系统变量的Path</u>下增加Sublime Text3的安装路径，比如我的配置`C:\Program Files\Sublime Text 3`​，添加完之后需要<span style="font-weight: bold;" data-type="strong">重启电脑。</span>
* 然后在copy的【历史面板】设置外部编辑器

  ```bash
  subl --wait %1
  ```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161952665.png)​

效果预览：

​![CopyQ 打开sumlime](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161952776.webp)​

### 设置标签页存放路径用于同步

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953902.png)​

> ⚠️ 如果发现设置了路径，标签页数据并没有同步到指定路径，可以试着更改标签页名再更改回来

## 干货：添加自定义命令

如何添加命令：【文件】-【命令/全局快捷键】

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953946.png)​

命令面板支持添加/删除命令，选择命令是自动执行、还是需要菜单点击，还是按快捷键执行

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953712.png)​​

建议前往Github的这个仓库→[GFDGIT/CopyQ_lazy](https://github.com/GFDGIT/CopyQ_lazy/tree/main)，观摩大佬的配置。

下面是我自己目前主要使用的命令

‍

### 复制为纯文本

```bash
copyq:
var text = input()
copy(text)
copySelection(text)
```

‍

### 去除换行

```bash
copyq print %1 |python -c ' 
import sys 
text = sys.stdin.read()
trimmed_lines = [line.strip() for line in text.splitlines()]
single_line = " ".join(trimmed_lines)
print(single_line ,end="")'|copyq: 
add(input()) 
```

### 筛选

```js
copyq:
var image = {
    [mimeText]: '图片 ---------------- I',
    [mimeIcon]: '',
    filter: '(^image/.*)|(?=^file\:.*\.(png|jpe?g|bmp|svg|gif)$)',
    shortcut: 'i'
}

var file = {
    [mimeText]: '文件  ---------------- F',
    [mimeIcon]: '',
    filter: '(?=^file://)',
    shortcut: 'f'
}

var url = {
    [mimeText]: 'URL ---------------- U',
    [mimeIcon]: '',
    filter: '^(?=(https?|ftps?|smb|mailto)://)',
    shortcut: 'u'
}

var html = {
    [mimeText]: 'HTML',
    [mimeIcon]: '',
    filter: '^text/html$',
    shortcut: 'h'
}

var PhoneMail = {
    [mimeText]: '手机号/邮箱',
    [mimeIcon]: '',
    filter: '(^0{0,1}(13[0-9]|15[7-9]|153|156|18[7-9])[0-9]{8}$)|(^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$)',
    shortcut: 'p'
}

var filters = [image, file, url, html, PhoneMail]
var selectedFilter = ''
var shortcut = str(data(mimeShortcut))

if (shortcut) {
    for (let f in filters) {
        if (filters[f].shortcut === shortcut) {
            selectedFilter = filters[f].filter
            filter_x(selectedFilter)
            abort()
       }
    }
}

var selectedIndex = menuItems(filters)

if (selectedIndex != -1) {
    selectedFilter = filters[selectedIndex].filter
    filter_x(selectedFilter)
} else {
    filter('')
}

function filter_x(filter_) {
    if (filter() == filter_)
        filter('')
    else
        filter('') & filter(filter_)
}
```

​​![CopyQ 筛选](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953325.webp)​​

### 支持复制文件

```js
var originalFunction = global.clipboardFormatsToSave
global.clipboardFormatsToSave = function() {
    return originalFunction().concat([
        mimeUriList,
        'x-special/gnome-copied-files',
        'application/x-kde-cutselection',
    ])
}
```

​![CopyQ 支持复制文件](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953246.webp)​

‍

### 支持预览图片文件

```js
copyq:
var prefix_reg = /^file:\/+(.*)/
var suffixToMime = {
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'bmp': 'image/bmp',
    'gif': 'image/gif',
    'svg': 'image/svg+xml',
}

function tryShowImage(mime) {
    var path = str(data(mime))
    path = path.replace(prefix_reg, '$1')
    if (!path) 
        return false
    var i = path.lastIndexOf('.')
    if (i == -1)
        return false
    var suffix = path.substring(i + 1)
    var imageMime = suffixToMime[suffix]
    if (imageMime === undefined)
        return false
    var f = new File(path)
    if (!f.openReadOnly())
        return false
    var imageData = f.readAll()
    f.close()
    if (imageData.size() === 0)
        return false
    setData(mimeItemNotes, path)
    setData(imageMime, imageData)
    return true
}

if (!hasImage()) {
    tryShowImage(mimeText) || tryShowImage(mimeUriList)
}

function hasImage() {
    var formats = dataFormats()
    for (var i in formats) {
        if (formats[i].match(/^image\//)) {
            return true
        }
    }
    return false
}
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953411.png)​​

​​
