---
title: JS DOM 操作
date: '2023-11-26 22:19:46'
updated: '2023-11-26 22:19:48'
excerpt: 整理下JS的DOM操作，话说自己的JS一直都徘徊在小白入门水平震荡
tags:
  - Javascript
  - 编程
categories:
  - 其他笔记
permalink: /post/js-dom-operation-1rrvs2.html
comments: true
toc: true
abbrlink: e1318fd7
---



## 获取元素

* get

  * ​`<span style="font-weight: bold;" data-type="strong">getElementById()</span>` ​：返回对拥有指定 <span style="font-weight: bold;" data-type="strong">id</span> 的第一个对象的引用

    ```html
    <div id="myElement">Hello, World!</div>

    <script>
      var element = document.getElementById("myElement");
      console.log(element.textContent); // 输出: Hello, World!
    </script>

    ```
  * ​`<span style="font-weight: bold;" data-type="strong">getElementsByName()</span>` ​：返回带有指定名称 <span style="font-weight: bold;" data-type="strong">name</span> 的对象的集合。返回的是元素的 <span style="font-weight: bold;" data-type="strong">数组</span> ，而不是一个元素（由于 name 不唯一）

    ```html
    <input type="text" name="username">
    <input type="text" name="username">

    <script>
      var elements = document.getElementsByName("username");
      console.log(elements.length); // 输出: 2
    </script>

    ```
  * ​<span style="font-weight: bold;" data-type="strong">`getElementsByTagName()`</span> ​：返回带有指定<span style="font-weight: bold;" data-type="strong">标签名</span>的对象<span style="font-weight: bold;" data-type="strong">集合</span>

    ```html
    <p>Paragraph 1</p>
    <p>Paragraph 2</p>

    <script>
      var paragraphs = document.getElementsByTagName("p");
      console.log(paragraphs.length); // 输出: 2
    </script>

    ```
  * ​`<span style="font-weight: bold;" data-type="strong">getElementsByClassName</span>`​ ：返回文档中所有指定类名的元素集合

    ```js
    // 获取单个类
    var x = document.getElementsByClassName("example");
    // 可以获取同时包含 "example" 和 "color" 类名的所有元素，并修改它的颜色:
    var x = document.getElementsByClassName("example color");
    ```
* query

  * ​<span style="font-weight: bold;" data-type="strong">`querySelector()`</span> ​ ：返回文档中匹配指定 <u>CSS 选择器</u>的<span style="font-weight: bold;" data-type="strong">第一个元素</span>

    ```js
    document.querySelector("p")      //获取文档中第一个 <p> 元素：
    document.querySelector("#demo")     //获取文档中id="demo"的元素
    document.querySelector(".example");   //获取文档中第一个 class="example" 的元素
    document.querySelector("p.example");    //获取文档中 class="example"的第一个 <p> 元素
    ...... 
    // 还可以写CSS的并集选择器、复合选择器等等。按照css规范来实现。

    ```
  * ​<span style="font-weight: bold;" data-type="strong">`querySelectorAll()`</span> ​：返回文档中匹配的 <u>CSS 选择器</u>的 <span style="font-weight: bold;" data-type="strong">所有元素节点列表</span>

    ```html
    <ul>
      <li>Item 1</li>
      <li>Item 2</li>
      <li>Item 3</li>
    </ul>

    <script>
      var listItems = document.querySelectorAll("li");
      console.log(listItems.length); // 输出: 3
    </script>

    ```

> ℹ get 和 query 的区别
>
> getXXXByXXX 获取的是<span style="font-weight: bold;" class="mark">动态</span>集合，querySelector 获取的是<span style="font-weight: bold;" data-type="strong"><span style="font-weight: bold;" class="mark">静态</span></span>集合。
>
> 这句话是的难点在于对静态和动态的理解，<u><span style="font-weight: bold;" data-type="strong">什么是静态，什么是动态？</span></u>
>
> 简单的说就是，<span style="font-weight: bold;" data-type="strong">动态就是</span>​<span style="font-weight: bold;" data-type="strong"><span style="font-weight: bold;" class="mark">选出的元素会随文档改变</span></span>，静态是<span style="font-weight: bold;" class="mark">取出来之后就和文档的改变无关了</span>。
>
> ```html
> <body>
>     <div id="test">
>         <p v-model="aa">text</p>
>         <p>text</p>
>     </div>
> </body>
> <script>
>     var querySelector = document.querySelector('#test')
>     var getElementById = document.getElementById('test')
>     console.log(querySelector === getElementById) // true
>     var querySelectorAll = document.querySelectorAll('p')
>     for(let i=0;i < querySelectorAll.length;i++){
>         querySelector.appendChild(document.createElement('p'))
>     }
>     console.log(querySelectorAll.length) 
>     //值为2,动态添加元素并没有使querySelectorAll发生变化
>   
>     var getElementsByTagName = document.getElementsByTagName('p')
>     for(let i=0;i < 3;i++){
>         getElementById.appendChild(document.createElement('p'))
>     }
>     console.log(getElementsByTagName.length) 
>     //值为4+3=7,每次动态添加元素都使getElementsByTagName发生了变化
> </script>
> ```

> ⚠️ 备注：这两种方法都不能查找伪类元素。

## 创建、插入、删除元素

1. <span style="font-weight: bold;" data-type="strong">创建新元素</span>

    ```js
    var newElement = document.createElement("tagName");
    ```
2. <span style="font-weight: bold;" data-type="strong">插入元素到指定位置</span>

    ```js
    parentElement.appendChild(newElement); // 在子元素末尾插入
    parentElement.insertBefore(newElement, referenceElement); // 在指定元素之前插入
    ```
3. <span style="font-weight: bold;" data-type="strong">删除元素</span>

    ```js
    parentElement.removeChild(childElement);
    ```

## 获取元素自定义属性和文本内容

1. <span style="font-weight: bold;" data-type="strong">获取/设置元素的属性值</span>

    ```js
    // 默认属性的获取
    element.getAttribute('class');
    element.getAttribute('style');
    element.getAttribute('id');
    // 自定义属性的设置和获取
    element.setAttribute('data-custom', 'new value');
    element.getAttribute('data-custom');
    ```

    自定义属性还可以通过`element.dataset['custom']`​获取

    ```js
    element.dataset['custom']
    ```
2. <span style="font-weight: bold;" data-type="strong">获取/设置元素的文本内容</span>

    ```js
    var textContent = element.textContent;
    element.textContent = "new text";
    ```

## 操作元素样式

* <span style="font-weight: bold;" data-type="strong">操作class</span>

  ```js
  // 添加 class
  element.classList.add("class")
  // 移除 class
  element.classList.remove("class")
  // 切换 class，有则移除，无则添加
  element.classList.toggle("class")
  //检测是否存在 class
  element.classList.contains("class")
  ```
* <span style="font-weight: bold;" data-type="strong">直接操作style</span>

  ```js
  element = document.getElementById('myDiv');
  // 直接设置样式
  element.style.color = 'blue';
  element.style.backgroundColor = 'yellow';
  element.style.fontSize = '20px';
  ```
