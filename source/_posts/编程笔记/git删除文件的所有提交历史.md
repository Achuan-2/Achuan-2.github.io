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





场景：git不小心上传了一个大文件，导致无法上传repo到Github，需要把这个大文件的git历史全部删除，仅仅靠`git rm -r --cached --ignore-unmatch`​ 和`.gitignore`​只会删除索引文件，git历史中依然有文件的提交历史，占用空间，需要想办法彻底删除

## ​`git rm -r --cached --ignore-unmatch`​ ❌

* 这个只会删除文件跟踪，但是文件依然会存在于之前commit历史中

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

删除指定文件夹

```bash
git filter-branch --force --index-filter \
'git rm -r --cached --ignore-unmatch 文件' \
--prune-empty --tag-name-filter cat -- --all
```

## ​`git-filter-repo`​🙂

参考：[git-filter-repo/Documentation/converting-from-filter-branch.md at main · newren/git-filter-repo](https://github.com/newren/git-filter-repo/blob/main/Documentation/converting-from-filter-branch.md#removing-a-file)

安装filter-repo

```bash
pip install r git-filter-repo
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
