---
title: 用Github管理代码项目丨我的版本管理方法
date: '2024-11-16 10:50:10'
updated: '2024-11-16 12:14:49'
excerpt: >-
  现在的代码项目我会创建一个CHANGELOG.md，这个文件我会记录自己每次更新了什么，每个版本新增了什么功能、修复的错误、改进的性能，这样可以记录这个代码项目的版本演变，有个清晰的变更记录。我习惯使用Gitmoji，即emoji用更有趣直观的方式来对每个更改进行分类。可以一眼区分是🐛bug，✨功能改进，还是📝文档完善。


  为了保存每个版本那时的代码，我还会在每次版本发布的时候，打上tag。这样，我在Github就可以保存每个版本的快照，万一有问题，也可以回溯。


  如果有必要也可以创建Release发版，可以写一个Github Action创建步骤，打完标签，就自动发版
tags:
  - Github
categories:
  - 编程笔记
permalink: >-
  /post/use-github-management-code-project-gun-my-version-management-method-jm4fp.html
comments: true
toc: true
---



我习惯用Git来管理自己的代码项目，由于自己过去参与开发思源笔记这个笔记软件的的主题外观，我需要把开发的主题外观代码要放在GitHub上。并且我不仅仅要写代码，更要给每次更改加tag、发版，才能被大家用上、大家才能看到更新。后面渐渐地，自己也有了一点点代码版本管理的心得。

以自己开发的钙信号提取软件为例，介绍下自己目前的代码版本管理方法

​![PixPin_2024-11-16_10-53-20](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-16_10-53-20-20241116105321-5z9gbgx.png)​

​![PixPin_2024-11-16_10-59-55](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-16_10-59-55-20241116105956-loz4otb.png)​

## CHANGELOG.md

现在的代码项目我都会创建一个`CHANGELOG.md`​，这个文件我会记录自己每次更新了什么，每个版本新增了什么功能、修复的错误、改进的性能，这样可以记录这个代码项目的版本演变，有个清晰的变更记录。我习惯使用Gitmoji的方式记录和提交commit，即使用emoji以有趣直观的方式来对每个commit进行分类。可以一眼区分是🐛bug，✨功能改进，还是📝文档完善。

为了方便输入emoji，我会用两个插件

* [mattbierner/vscode-emojisense](https://github.com/mattbierner/vscode-emojisense)：支持在markdown文件里输入`:`​，就有emoji提示，输入`:bug:`​就变为🐛
* [seatonjiang/gitmoji-vscode](https://github.com/seatonjiang/gitmoji-vscode)：可以在Git commit的界面选择emoji，并提供每个emoji的代表意义

​![PixPin_2024-11-16_11-02-45](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-16_11-02-45-20241116110248-m0i0wk4.png)​

## release.sh

为了保存每个版本那时的代码，我还会在每次版本发布的时候，打上tag，git打tag的命令是

```bash
# 打tag
git tag <tagname>
# 提交tag
git push origin --tags
```

为了简便打tag发布到GitHub的流程，我还会创建一个`release.sh`​脚本，运行就自动打上tag，不需要每次都输入代码命令

```bash
# Change directory to the script's directory
cd "$(dirname $0)" 

# Get version from theme.json
version=v1.0.6

# Commit changes
git add .
git commit -m "🔖 $version" 
git push

# 判断 tag 是否存在
if git rev-parse --quiet --verify $version >/dev/null; then
    # 删除本地仓库中的 tag
    git tag -d $version
    # 删除远程仓库中的 tag
    git push origin ":refs/tags/$version"
fi

# 创建新的 tag
git tag $version # Create a tag

# 推送新的 tag 到远程仓库
git push origin --tags 
```

这样，我在Github就可以保存每个版本的快照，万一有问题，也可以回溯

​![PixPin_2024-11-16_11-12-28](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-16_11-12-28-20241116111229-mk3d08y.png)​

## 通过Github Action发布Release

如果有必要也可以创建Release发版，可以写一个Github Action创建步骤，打完标签，就自动发版

Github Action创建步骤

* 在你的项目根目录下，创建一个文件夹`.github/workflows`​。
* 在该文件夹中创建一个新的YAML文件，例如`release.yml`​。

​`release.yml`​的内容

```yml
name: Create Release on Tag

on:
  push:
    tags:
      - 'v*'  # 监听以v开头的标签

jobs:
  release:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Create GitHub Release
      uses: actions/create-release@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tag_name: ${{ github.ref }}
        release_name: ${{ github.ref }}
        draft: false
        prerelease: false
```

自动发版

​![PixPin_2024-11-16_12-04-55](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-16_12-04-55-20241116120500-jhhkqk6.png)​
