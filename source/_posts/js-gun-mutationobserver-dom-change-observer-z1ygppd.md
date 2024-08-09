---
title: JS丨MutationObserver（DOM 变动观察器）
date: '2024-08-09 13:07:20'
updated: '2024-08-09 20:36:24'
excerpt: >-
  MutationObserver 可以观察 DOM 元素，并在检测到更改时触发回调。特别适用于监控元素的属性、子节点或者文本内容的变化。这个 API
  提供了一个高效的机制来追踪这些变化，避免了频繁的轮询操作，可以提升代码性能。
tags:
  - JS
categories:
  - 编程笔记
permalink: /post/js-gun-mutationobserver-dom-change-observer-z1ygppd.html
comments: true
toc: true
---



​`MutationObserver`​ 可以观察 DOM 元素，并在检测到更改时触发回调。特别适用于监控元素的属性、子节点或者文本内容的变化。这个 API 提供了一个高效的机制来追踪这些变化，避免了频繁的轮询操作，可以提升代码性能。

## 基本语法

### 1. **创建** **​`MutationObserver`​**​ **实例**

首先，需要创建一个 `MutationObserver`​ 实例，并传入一个回调函数，该回调函数将在监听的 DOM 变化时被调用。回调函数接受两个参数：

* ​`mutationsList`​：一个包含所有发生变化的 `MutationRecord`​ 对象的列表。

  [MutationRecord](https://dom.spec.whatwg.org/#mutationrecord) 对象具有以下属性：

  * ​`type`​ —— 变动类型，以下类型之一：

    * ​`"attributes"`​：特性被修改了，
    * ​`"characterData"`​：数据被修改了，用于文本节点，
    * ​`"childList"`​：添加/删除了子元素。
  * ​`target`​ —— 更改发生在何处：`"attributes"`​ 所在的元素，或 `"characterData"`​ 所在的文本节点，或 `"childList"`​ 变动所在的元素，
  * ​`addedNodes/removedNodes`​ —— 添加/删除的节点，
  * ​`previousSibling/nextSibling`​ —— 添加/删除的节点的上一个/下一个兄弟节点，
  * ​`attributeName/attributeNamespace`​ —— 被更改的特性的名称/命名空间（用于 XML），
  * ​`oldValue`​ —— 之前的值，仅适用于特性或文本更改，如果设置了相应选项 `attributeOldValue`​/`characterDataOldValue`​。
* ​`observer`​：指向 `MutationObserver`​ 实例本身的引用。

```js
const observer = new MutationObserver((mutationsList, observer) => {
    mutationsList.forEach(mutation => {
        console.log(mutation); // 处理每个 MutationRecord的回调函数
    });
});
```

### 2. **配置**​`observe`​选项

在开始观察 DOM 变化之前，需要通过 `observe`​ 方法指定要观察的目标节点和相应的配置选项。

​`config`​ 是一个具有布尔选项的对象，该布尔选项表示“将对哪些更改做出反应”，配置选项包括：：

* ​`childList`​ —— `node`​ 的直接子节点的更改，
* ​`subtree`​ —— `node`​ 的所有后代的更改，
* ​`attributes`​ —— `node`​ 的特性（attribute），
* ​`attributeFilter`​ —— 特性名称数组，只观察选定的特性。
* ​`characterData`​ —— 是否观察 `node.data`​（文本内容），
* ​`attributeOldValue`​ —— 如果为 `true`​，则将特性的旧值和新值都传递给回调（参见下文），否则只传新值（需要 `attributes`​ 选项），
* ​`characterDataOldValue`​ —— 如果为 `true`​，则将 `node.data`​ 的旧值和新值都传递给回调（参见下文），否则只传新值（需要 `characterData`​ 选项）。

```js
const config = {
    childList: true,          // 观察子节点的变化
    attributes: true,         // 观察属性的变化
    characterData: true,      // 观察文本数据的变化
    subtree: true,            // 观察所有后代节点的变化
    attributeOldValue: true,  // 记录属性变化前的值
    characterDataOldValue: true // 记录文本数据变化前的值
};
```

### 3. 开始观察

```js
observer.observe(targetNode, config);
```

### 4. **停止观察**

```javascript
observer.disconnect();
```

### 5. 获取已观察的记录    

返回自上次调用以来的所有 `MutationRecord`​ 对象。

```js
const mutations = observer.takeRecords();

```

## **常见用例**

* 动态内容的更新监控：比如监听笔记软件添加内容等操作，运行特定代码。
* 内容的监听：表单元素的变化监控。
* 属性变化的监听：如按钮状态、样式的变化。

## **示例代码**

监听「**思源笔记代码块更改代码语言高亮**」的操作，对代码语言进行排序

```js
// 函数：监控dom变化
function observeDomChange(targetNode, callback) {
    const config = { childList: true, subtree: true };
    const observer = new MutationObserver((mutationsList) => {
        for (const mutation of mutationsList) {
            // console.log(mutation.target.classList);
            if (mutation.type === 'childList') {
                // console.log(mutation.target.classList);
                callback(mutation);
            }
        }
    });
    observer.observe(targetNode, config);
    // 返回observer，用于停止观察
    // observer.disconnect();
    return observer;
}

// 调用代码
const layoutCenter = document.querySelector('.layout__center');
const observer = observeDomChange(layoutCenter, (mutation) => {
    // 监听代码列表的弹窗事件
    if(mutation.target.classList.contains("protyle-util")) {
        const codeList = mutation.target.querySelector(".b3-list--background");
        if(codeList){
            const firstChild = codeList.firstElementChild;
            sortLangList([...recentlyCodeLang, ...topCodeLang], codeList, firstChild);
            console.log(codeList, 'codeList');
        }
    }

});
```
