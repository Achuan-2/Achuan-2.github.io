---
title: Cursor 0.45.14 卸载不完全
date: '2025-07-24 17:16:13'
updated: '2025-07-24 18:04:42'
permalink: /post/cursor-04514-uninstalled-incompletely-1bmg9x.html
comments: true
toc: true
---



第一次见到这么恶心的软件，堪比360！

之前尝试安装过Cursor，后面觉得还是VSCode Copilot更好用，就卸了，结果发现Cusor卸载不干净，一直存在`Cursor 0.45.14`这个版本，哪怕我安装了版本，再卸载也卸载不掉

![PixPin_2025-07-24_17-39-30](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-39-30-20250724173934-3hwl9cz.png)

而且搜了下，也不是只有我一个人遇到这个问题

> [https://lewinblog.com/blog/page/2025/250306-AI-IDEs.md](https://lewinblog.com/blog/page/2025/250306-AI-IDEs.md#cursor-%E5%8D%B8%E8%BD%BD%E4%B8%8D%E5%AE%8C%E5%85%A8)
>
> 由于我的试用许可已经到期并且不再打算使用 Cursor，因此我决定卸载它。
>
> 但是我在 windows 应用管理器中看到有两个 Cursor 应用，一个叫`Cursor`，一个叫`Cursor 0.45.14`，我卸载了前者之后，发现后者依然留存、并且无法在 windows 应用管理器中卸载。
>
> 我只能手动删除了软件的本地目录。然后还要手动去注册表搜索相关项目。于是我发现在注册表里 Cursor 又留下了很多屎：所有的代码文件后缀关联被修改了，还留下很多隐含的注册表项。
>
> 我再回忆起之前我在试用阶段观察到多次 Cursor 强制更新，其中曾经出现过自动强制更新之后程序无法运行的情况。技术力堪忧啊。
>
> 这一切让我洁癖属性发狂。请问这是什么流氓软件做派？！堪比 360！据此，我对Cursor的评价降低为“谨慎使用”。

> [can&apos;t Uninstall old version in windows · Issue #2829 · cursor/cursor](https://github.com/cursor/cursor/issues/2829)
>
> ![PixPin_2025-07-24_17-20-26](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-20-26-20250724172028-2d2tm17.png)

为了删除Cursor在注册表留下的那些垃圾，找了好久，终于看到Advanced Uninstaller详细介绍了如何彻底卸载Cursor

[Cursor 0.45.14 version 0.45.14 by Cursor AI, Inc. - How to uninstall it](https://www.advanceduninstaller.com/Cursor-0_45_14-3218752eb4be1ece6c66ef775e4bab43-application.htm)

![PixPin_2025-07-24_17-23-49](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-23-49-20250724172350-xtm5oaj.png)

安装Advanced Uninstaller后，它会查找Cursor遗留下的脏东西（也会误查找一些其他软件的文件，所以需要核对下）

![PixPin_2025-07-24_17-31-12](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-31-12-20250724173112-ue7jmt5.png)

把注册表的这些东西删掉之后，如果安装的应用就找不到了

![PixPin_2025-07-24_17-30-58](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-30-58-20250724173100-7i66mv8.png)

不过我目前打开markdown的选择文件里，依然还有Cursor的脏东西

![PixPin_2025-07-24_17-43-26](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-43-26-20250724174345-pmjcd99.png)

> 注：坚果云貌似也是一个毒瘤

![PixPin_2025-07-24_17-44-38](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-44-38-20250724174439-zaz8rmp.png)

用Advanced Uninstaller跑了一下注册表清理

![PixPin_2025-07-24_17-44-59](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-44-59-20250724174502-lyz7h9b.png)

终于消失了

‍

![PixPin_2025-07-24_17-59-24](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-07-24_17-59-24-20250724175928-3spld71.png)
