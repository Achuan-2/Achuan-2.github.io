---
title: 让GPT给我写了一个自动签到脚本丨GLaDOS每日自动签到油猴脚本
date: '2024-11-27 04:56:53'
updated: '2024-11-27 05:04:24'
excerpt: |-
  GLaDos每天签到可以给积分，只要天天签到，就能一直白嫖很长时间，可惜我是一个很忙的人（懒），经常记不得签到。

  于是就让GPT给我写了一个油猴脚本，每天只要我打开网页，就能自动打开GlaDOs的签到页面进行签到。
tags:
  - JS
categories:
  - 编程笔记
permalink: >-
  /post/i-asked-gpt-to-write-a-automatic-sign-in-script-gun-glados-automatically-signed-the-oil-monkey-script-every-day-nrjrd.html
comments: true
toc: true
---



## 背景

GLaDos每天签到可以给积分，只要天天签到，就能一直白嫖很长时间，可惜我是一个很忙的人（懒），经常记不得签到。

于是就让GPT给我写了一个油猴脚本，每天只要我打开网页，就能自动打开GlaDOs的签到页面进行签到。

自从我用了这个油猴脚本后，已经连续20天签到啦哈哈哈哈。

​![PixPin_2024-11-27_04-59-31](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-11-27_04-59-31-20241127045933-5upm0jd.png)​

## 油猴脚本

> 理论上说，只要修改签到页面的地址和签到按钮的识别方案，就能适用于任何需要签到的网站

```js
// ==UserScript==
// @name         GLaDOS每日自动签到（新窗口）
// @namespace    http://tampermonkey.net/
// @version      0.3
// @description  每天自动在新窗口打开GLaDOS签到页面并点击签到按钮
// @match        https://glados.rocks/console/checkin
// @match        *://*/*
// @grant        GM_setValue
// @grant        GM_getValue
// @grant        GM_openInTab
// ==/UserScript==

(function() {
    'use strict';

    // 如果是在签到页面
    if (location.href === 'https://glados.rocks/console/checkin') {
        setTimeout(() => {
            const checkinButton = document.querySelector('button.ui.positive.button');
            if (checkinButton) {
                checkinButton.click();
                console.log('GLaDOS签到成功!');
                // 延迟关闭标签页
                setTimeout(() => {
                    window.close();
                }, 5000);
            }
        }, 5000);
        return;
    }

    // 在其他页面检查是否需要签到
    const today = new Date().toDateString();
    const lastCheckin = GM_getValue('GlaDOSlastCheckinDate', '');

    if (today !== lastCheckin) {
        GM_setValue('GlaDOSlastCheckinDate', today);
        setTimeout(() => {
            GM_openInTab('https://glados.rocks/console/checkin', { active: false, insert: true });
        }, 2000);
    }
})();

```
