---
title: git 删除文件的所有提交历史
date: '2025-03-05 19:08:12'
updated: '2025-03-05 19:12:09'
excerpt: >-
  场景：git不小心上传了一个大文件，导致无法上传repo到Github，需要把这个大文件的git历史全部删除，仅仅靠`git rm -r --cached
  --ignore-unmatch` 和`.gitignore`只会删除索引文件，git历史中依然有文件的提交历史，占用空间，需要想办法彻底删除
categories:
  - 编程笔记
permalink: /post/git-deletes-all-commit-history-of-a-file-t2tqq.html
comments: true
toc: true
---





场景：git不小心上传了一个大文件，导致无法上传repo到Github，需要把这个大文件的git历史全部删除，仅仅靠`git rm -r --cached --ignore-unmatch`​ 和`.gitignore`​只会取消文件跟踪，git历史中依然有文件的提交历史，占用空间，需要想办法彻底删除，否则无法push

​![git 删除文件的所有提交历史](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/git%20%E5%88%A0%E9%99%A4%E6%96%87%E4%BB%B6%E7%9A%84%E6%89%80%E6%9C%89%E6%8F%90%E4%BA%A4%E5%8E%86%E5%8F%B2-20250305192349-sykem3c.svg)​

## ​`git rm -r --cached --ignore-unmatch`​ ❌

* 这个只会取消文件跟踪，但是文件依然会存在于之前commit历史中

## ​`git filter-branch`​ ✅

删除指定文件/文件夹

```bash
git rm -r --cached --ignore-unmatch 文件1.md
git commit -m "🔥"
git filter-branch --force --index-filter \
'git rm -r --cached --ignore-unmatch 文件1.md' \
--prune-empty --tag-name-filter cat -- --all
```

> 注意，需要先运行git rm -r --cached --ignore-unmatch，并git commit，否则git 这个命令会把文件和文件历史全部删除，不保留工作区的文件

## ​`git-filter-repo`​🙂

参考：[git-filter-repo/Documentation/converting-from-filter-branch.md](https://github.com/newren/git-filter-repo/blob/main/Documentation/converting-from-filter-branch.md#removing-a-file)

安装filter-repo

```bash
pip install  git-filter-repo
```

删除历史操作

```bash
git rm -r --cached --ignore-unmatch 文件1.md
git commit -m "🔥"
git filter-repo --invert-paths --path 文件1.md

# 会丢失远端操作需要重新绑定remote 仓库，需要重新绑定，并强力删除
git remote add origin https://github.com/Achuan-2/vscode-git--.git
git push origin --all --force
```
