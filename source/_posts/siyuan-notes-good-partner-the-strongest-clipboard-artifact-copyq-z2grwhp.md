---
title: 思源笔记好搭档|最强剪贴板神器——CopyQ
date: '2023-12-16 17:45:29'
updated: '2023-12-16 20:02:17'
excerpt: >-
  之前一直很馋 utools 的剪贴板插件，可以对图片、文本进行分类，我最喜欢的剪贴板工具是
  CopyQ，一直觉得它很强大，却不知道该如何实现这个功能，一直以为不行，还傻傻去 GitHub 提了个 feature
  request，后来得到热心大佬的分享，观摩（抄袭）了他的 repo，突然发现自己过去是真的不会用
  CopyQ，所以写下这篇分享，记录目前的用法，也分享给不了解不熟悉 CopyQ 的朋友们。
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



> 前排：之前一直很馋 utools 的剪贴板插件，可以对图片、文本进行分类，我最喜欢的剪贴板工具是 CopyQ，一直觉得它很强大，却不知道该如何实现这个功能，一直以为不行，还傻傻去 GitHub 提了个 feature request，后来得到热心大佬的分享，观摩（抄袭）了他的 repo，突然发现自己过去是真的不会用 CopyQ，所以写下这篇分享，记录目前的用法，也分享给不了解不熟悉 CopyQ 的朋友们。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002297.png)​

CopyQ 官方网站：[CopyQ (hluk.github.io)](https://hluk.github.io/CopyQ/)

## 特色功能总结

* 可以同时保存文本、图片、文件等复制数据
* 支持搜索、筛选剪贴板
* 具备多标签页功能，可以通过拖拽实现 item 的所属标签页改动。
* 支持设置剪贴板数据，可以放在 Onedrive、Synology Drive 等同步盘进行多端同步
* 支持指定文本编辑器，我将其设置为 Sublime Text3（类似于 VSCode 编辑器），利用强大的编辑器能力来处理复制的文本
* 支持设置命令和动作，可以调用 copyq 自带命令，能用 JS 编写命令，也可以用 python 写命令。你可以通过命令设置筛选图片、文件，去除复制文本的换行、使 Copy 具有复制文件、预览图片文件的能力等等额外功能
* 支持导出全部配置数据（包括标签页、外观主题、命令等），便于分享和备份配置。

‍

## 个人配置

### 布局设置

* 隐藏工具栏和工具栏文本标签
* 显示标签树（标签页会以树形展示在页面左侧）和显示标签页条目计数

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002640.png)​

### 设置文本编辑器为 sublime text3

* 先在<u>系统变量的 Path</u> 下增加 Sublime Text3 的安装路径，比如我的配置 `C:\Program Files\Sublime Text 3`​，添加完之后需要<span style="font-weight: bold;" data-type="strong">重启电脑。</span>
* 然后在 copy 的【历史面板】设置外部编辑器

  ```bash
  subl --wait %1
  ```

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002477.png)​

效果预览：

​![CopyQ 打开 sumlime](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002284.webp)​

### 设置标签页存放路径用于同步

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002688.png)​

> ⚠️ 如果发现设置了路径，标签页数据并没有同步到指定路径，可以试着更改标签页名再更改回来

## 干货：添加自定义命令

如何添加命令：【文件】-【命令/全局快捷键】

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002669.png)​

命令面板支持添加/删除命令，选择命令是自动执行、还是需要菜单点击，还是按快捷键执行

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002433.png)​​

建议前往 Github 的这个仓库 →[GFDGIT/CopyQ_lazy](https://github.com/GFDGIT/CopyQ_lazy/tree/main)，观摩大佬的配置。

下面是我自己目前主要使用的命令，可以复制后在命令面板点击【粘贴命令】加到自己的 CopyQ

### 复制为纯文本

```bash
[Command]
Name=\x590d\x5236\x4e3a\x7eaf\x6587\x672c
Command="
    copyq:
    var text = input()
    copy(text)
    copySelection(text)
    "
Input=text/plain
InMenu=true
HideWindow=true
Icon=\xf0ea
Shortcut=ctrl+shift+c
```

‍

### 去除换行

```bash
[Command]
Name=\x53bb\x9664\x6362\x884c
Command="
    copyq print %1 |python -c ' 
    import sys 
    text = sys.stdin.read()
    trimmed_lines = [line.strip() for line in text.splitlines()]
    single_line = \" \".join(trimmed_lines)
    print(single_line ,end=\"\")'|copyq: 
    add(input())"
InMenu=true
```

### 筛选图片、文件、URL 等

```ini
[Command]
Name=\x7b5b\x9009
Command="
    copyq:
    var image = {
        [mimeText]: '\x56fe\x7247 ---------------- I',
        [mimeIcon]: '\xf302',
        filter: '(^image/.*)|(?=^file\\:.*\\.(png|jpe?g|bmp|svg|gif)$)',
        shortcut: 'i'
    }

    var file = {
        [mimeText]: '\x6587\x4ef6  ---------------- F',
        [mimeIcon]: '\xf15b',
        filter: '(?=^file://)',
        shortcut: 'f'
    }

    var url = {
        [mimeText]: 'URL ---------------- U',
        [mimeIcon]: '\xf0c1',
        filter: '^(?=(https?|ftps?|smb|mailto)://)',
        shortcut: 'u'
    }

    var html = {
        [mimeText]: 'HTML',
        [mimeIcon]: '\xf121',
        filter: '^text/html$',
        shortcut: 'h'
    }

    var PhoneMail = {
        [mimeText]: '\x624b\x673a\x53f7/\x90ae\x7bb1',
        [mimeIcon]: '\xe527',
        filter: '(^0{0,1}(13[0-9]|15[7-9]|153|156|18[7-9])[0-9]{8}$)|(^([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$)',
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
    }"
InMenu=true
Icon=\xf0b0
Shortcut=shift+f, f, i, u
```

​​![CopyQ 筛选](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002514.webp)​​

### 支持复制文件

```ini
[Command]
Name=\x590d\x5236/\x7c98\x8d34\x6587\x4ef6\x652f\x6301
Command="
    // \x4e0d\x652f\x6301\x526a\x5207\x64cd\x4f5c
    var originalFunction = global.clipboardFormatsToSave
    global.clipboardFormatsToSave = function() {
        return originalFunction().concat([
            mimeUriList,
            'x-special/gnome-copied-files',
            'application/x-kde-cutselection',
        ])
    }"
IsScript=true
Icon=\xf0c1
```

​![CopyQ 支持复制文件](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312162002693.webp)​

‍

### 支持预览图片文件

```ini
[Command]
Name=\x9884\x89c8\x56fe\x7247\x6587\x4ef6
Command="
    copyq:
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
        path = path.replace(/^file:\\/+(.*)/, '$1')
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
        tryShowImage(mimeText)
        || tryShowImage(mimeUriList)
    }

    function hasImage() {
        var formats = dataFormats()
        for (var i in formats) {
            if (formats[i].match(/^image\\//)) {
                return true
            }
        }
        return false
    }"
Display=true
Icon=\xf1c5
```

​​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202312161953411.png)​​

​​
