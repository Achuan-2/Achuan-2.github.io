---
title: VSCode 设置了代理，但是Git Push依然失败，如何解决
date: '2024-11-16 12:33:40'
updated: '2024-11-16 12:33:42'
tags:
  - VSCode
categories:
  - 软件工具
permalink: >-
  /post/vscode-has-set-an-agent-but-git-push-is-still-failed-how-to-solve-z2mhi0b.html
comments: true
toc: true
---



‍

## 问题

VSCode 设置了代理，但是Git Push依然失败

```json
{
  "http.proxy": "http://127.0.0.1:7890",
  "http.proxyStrictSSL": false,
  "http.proxyAuthorization": null, // 根据实际情况决定是否需要此行，有时可能需要移除或设置为特定的认证头信息
  "http.proxySupport": "on",
}
```

于是我之前一直都是在VSCode里用Git Bash终端来push的，因为在Git Bash的`.bashrc`​设置了代理

## 解决

原来vscode 也是调用 git 的服务，设置插件代理是没用的，需要单独设置git全局代理

```matlab
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```

这样就能解决了

另外也有人说让clash开Tun模式，不过我暂时不懂Tun模式是什么，以后有空可以折腾折腾

‍

‍

## 参考

* [vscode 设置了 clash 的代理，但是相关的 git 操作，还是报错 fatal: unable to access - V2EX](https://hk.v2ex.com/t/1012596)
