---
title: 2024.04.27 stellar主题更新 v1.28.0 及装修
date: '2024-04-27 12:33:25'
updated: '2024-04-27 13:30:44'
permalink: /post/20240427-stellar-theme-update-v1280-and-decoration-zanvt4.html
comments: true
toc: true
excerpt: >-
  stellar
  主题有段时间大改样式，当时没时间更新主题。感觉现在主题比较稳定了，终于找到时间把主题更新一下。由于stellar经过作者大改，我之前的很多的自定义样式都失效了。所以又折腾了一上午，重新美化了一下。
tags:
  - 折腾
  - Hexo博客搭建
---





stellar 主题有段时间大改样式，当时没时间更新主题。感觉现在主题比较稳定了，终于找到时间把主题更新一下。由于stellar经过作者大改，我之前的很多的自定义样式都失效了。所以又折腾了一上午，重新美化了一下。

## 目前的博客样式

​![Clip_2024-04-27_12-14-58](https://fastly.jsdelivr.net/assets/Clip_2024-04-27_12-14-58-20240427121503-vlzsk3v.png "主页")​

​![Clip_2024-04-27_11-19-05](https://fastly.jsdelivr.net/assets/Clip_2024-04-27_11-19-05-20240427111907-krckfdm.png "文章内")​

## 之前的历史快照

​![image](https://fastly.jsdelivr.net/assets/image-20230926104442-ig83unh.png "2023.09.26")​

​![image](https://fastly.jsdelivr.net/assets/image-20231105162526-h0wksqr.png "2023.11.05")​

## 代码更改记录

### Markdown图片title标题失效

Markdown 的完整图片语法是 `![anchor text](img_src "title")`​，一些笔记软件像语雀、思源笔记目前都是支持解析title作为图片标题的，一些hexo主题如butterfly应该也是支持的（也是我提的建议）。

stellar之前是接受了我的[pull request](https://github.com/xaoxuu/hexo-theme-stellar/commit/4be3e6e123b7d22f00d5a4d419c954bb2557cf67)，可以解析Markdown的图片title语法作为图片标题，

但现在直接把解析Markdown标题的删掉了（见[issue讨论](https://github.com/xaoxuu/hexo-theme-stellar/issues/340)，[代码改动](https://github.com/xaoxuu/hexo-theme-stellar/commit/e92cb81296e34e85d54bf26f35b6eda83d78b534)）。

作为基本只用Markdown语法写博客的人来说，实在太不友好了，所以又把删掉的代码给加了回来。

> 现在我基本是使用「[思源笔记](https://github.com/siyuan-note/siyuan)」来管理笔记和写博客，思源笔记有一个「[发布工具](https://github.com/terwer/siyuan-plugin-publisher)」插件，可以很便捷的把思源笔记里的文章上传到各个平台，非常省心，再结合思源笔记的数据库功能可以很方面的管理发布的文章
>
> ​![Clip_2024-04-27_12-43-28](https://fastly.jsdelivr.net/assets/Clip_2024-04-27_12-43-28-20240427124338-tlz4y8f.png "发布工具")​
>
> ​![Clip_2024-04-27_13-02-42](https://fastly.jsdelivr.net/assets/Clip_2024-04-27_13-02-42-20240427130249-xfw7ivx.png "用思源笔记的数据库来管理博客文章")​

### 添加分类 widget

这样在主页就知道自己文章有多少分类了

​![Clip_2024-04-27_13-04-40](https://fastly.jsdelivr.net/assets/Clip_2024-04-27_13-04-40-20240427130443-v5nfsi9.png)​

1. 在 `/themes/stellar/layout/_partial/widgets/`​ 下新建 `categories.ejs`​，填入以下内容：

    ```js
    <% function layoutCategoriesDiv() { var el='' ; if (site.categories===undefined || site.categories.length===0) { return
        el; } var opts=Object.assign({}, item); delete opts['title']; delete opts['layout']; opts.class='category ' ;
        el+=`<widget class="widget-wrapper${scrollreveal(' ')} categories-widget">`;

        if (item.title) {
        el += '<div class="widget-header categories-header dis-select">';
            el += '<span class="name">' + item.title + '</span>';
            el += '</div>';
        }

        el += '<div class="widget-body">';
            // Generate categories list
            site.categories.each(function(category) {
            el += `<div class="${opts.class}">`;
                el += `<svg class="category-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round">
                    <path d="M18 10h-5" opacity=".5" />
                    <path d="M10 3h6.5c.464 0 .697 0 .892.026a3 3 0 0 1 2.582 2.582c.026.195.026.428.026.892"
                        opacity=".5" />
                    <path
                        d="M2 6.95c0-.883 0-1.324.07-1.692A4 4 0 0 1 5.257 2.07C5.626 2 6.068 2 6.95 2c.386 0 .58 0 .766.017a4 4 0 0 1 2.18.904c.144.119.28.255.554.529L11 4c.816.816 1.224 1.224 1.712 1.495a4 4 0 0 0 .848.352C14.098 6 14.675 6 15.828 6h.374c2.632 0 3.949 0 4.804.77c.079.07.154.145.224.224c.77.855.77 2.172.77 4.804V14c0 3.771 0 5.657-1.172 6.828C19.657 22 17.771 22 14 22h-4c-3.771 0-5.657 0-6.828-1.172C2 19.657 2 17.771 2 14z" />
                </svg>`;
                el += `<a href="${url_for(category.path)}">${category.name} (${category.length})</a>`;
                el += `</div>`;
            });
            el += '</div>';
        el += '</widget>'; // Close widget-wrapper
        return el;
        }
        %>
        <%- layoutCategoriesDiv() %>
    ```
2. 在 `themes/stellar/source/css/_layout/widgets/`​ 下新建 `categories.styl`​ 文件，填入以下内容：

    ```css
    // categories widget 样式
    .widget-wrapper.categories-widget .widget-body {
        border-radius: $border-card;
        padding: 12px 20px;
        background: var(--alpha50); // 这里设置背景
        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1); // 添加阴影效果
      }

    // 每个分类的样式
    .category
      line-height: 1.5
      margin: 8px 0
      display: flex // 使用flex布局来确保图标和文本在同一行
      align-items: center // 垂直居中对齐

    .category-icon
      width: 16px
      height: 16px
      vertical-align: middle
      margin-right: 8px

    .category a
      display: inline-block // 链接以行内块方式显示
      word-break: break-word
      color: var(--text-p2)
      font-family: system-ui
      font-weight: 300
      font-size: 16px
      text-decoration: none
      &:hover
        color: $color-hover
        text-decoration: underline

    // Variables
    $color-hover = #0366d6


    ```

> 参考：[Stellar 主题中添加分类索引 Widget - 宇宙尽头的餐馆 (flyalready.cn)](https://www.flyalready.cn/Stellar%20%E4%B8%BB%E9%A2%98%E4%B8%AD%E6%B7%BB%E5%8A%A0%E5%88%86%E7%B1%BB%E7%B4%A2%E5%BC%95%20Widget)

### 随机文章按钮

创建 `themes/stellar/scripts/helpers/random.js`​ ，增加以下代码：

```js
hexo.extend.filter.register('after_render:html', function (data) {
    const posts = []
    hexo.locals.get('posts').map(function (post) {
        if (post.random !== false) posts.push(post.path)
    })
    data += `<script>var posts=${JSON.stringify(posts)};function toRandomPost(){ var randomPath = posts[Math.floor(Math.random()*posts.length)]; var encodedPath = encodeURIComponent(randomPath); window.open('/' + encodedPath, "_self"); };</script>`
    return data
})
```

> 参考：[Hexo Stellar 主题装修笔记 - 宇宙尽头的餐馆 (flyalready.cn)](https://www.flyalready.cn/Hexo%20Stellar%20%E4%B8%BB%E9%A2%98%E8%A3%85%E4%BF%AE%E7%AC%94%E8%AE%B0/#%E9%9A%8F%E6%9C%BA%E6%96%87%E7%AB%A0%E8%B7%B3%E8%BD%AC)
>
> 备注：文章路径需要用`encodeURIComponent`​来编码，否则如果文章路径里有连字符，没有在前面加上域名地址，导致打开识别

### 增强标签显示

现在相比于分类我可能会更喜欢用标签，因为一篇文章可以打多个标签。我在思源笔记里管理笔记也是用管理链接的方式而弃用了文档树分类，所以标签更符合我管理笔记的习惯。stellar默认在文章列表只显示分类，对我来说就有点难受了。

#### 主页文章列表添加标签

修改`themes/stellar/layout/_partial/main/post_list/post_card.ejs`​

```js
// cat
if (post.categories && post.categories.length > 0) {
  if (post.layout === 'post' && post.categories && post.categories.length > 0) {
    var cats = [];
    if (post.categories) {
      post.categories.forEach((cat, i) => {
        cats.push(cat.name);
      });
    }
    if (cats.length > 0) {
      let cat = cats.shift();
      el += '<span class="cap breadcrumb"' + category_color(cat) + '>';
      el += icon('default:category')
      el += `<span>${cat}</span>`
      el += '</span>';
    }
  }
}
  if (post.sticky) {
  el += `<span class="pin">${icon('default:pin')}</span>`
}
el += '</div>';
// cat tags
el += '<div style="margin: 4px 0px;">';
if (post.tags && post.tags.length > 0) {
  el += '<span class="cap tags">';

  el += post.tags.map(tag => `<span style="background-color: var(--tag-bg-color); padding: 0px 6px; margin: 0px 5px 0px 0px;border-radius: 5px; color: var(--tag-text-color); line-height: 1.5;">#<span>${tag.name}</span></span>`).join('');

  el += '</span>';
}

el += '</div>';
el += '</article>';
return el;
```

自定义样式

```css
/* 默认的浅色模式颜色 */
:root {
    --tag-bg-color: #F2EEFD;
    --tag-text-color: #835EEC;
  }
  
  /* 暗黑模式下的颜色 */
  @media (prefers-color-scheme: dark) {
    :root {
      --tag-bg-color: #282433;
      --tag-text-color: #A28BF2;
    }
  }
  

#post-meta {
  font-size: 12px; 
  color: var(--text-p4); /* 或 --text-p2，设置为灰色 */
}
```

#### 在文章页面添加标签显示

在 `layout/_partial/main/navbar/article_banner.ejs`​ 文件中，找到

```js
// 3.left.top: 面包屑导航
  el += `<div class="flex-row" id="breadcrumb">`
    // 首页
    el += `<a class="cap breadcrumb" href="${url_for(config.root)}">${__("btn.home")}</a>`
    if (theme.wiki.tree[page.wiki]) {
      el += partial('breadcrumb/wiki')
    } else if (page.layout == 'post') {
      el += partial('breadcrumb/blog')
    } else {
      el += partial('breadcrumb/page')
    }
  // end 3.left.top
  el += `</div>`

```

并在后面添加：

```js
// 在这里添加标签代码
 if (page.layout == "post" && page.tags && page.tags.length > 0) {
   el += '<div id="tag">'; // 将标签容器的创建移动到条件内部
   el += ' <span>&nbsp标签：</span>';
   el += list_categories(page.tags, {
     class: "cap breadcrumb",
     show_count: false,
     separator: '&nbsp; ',
     style: "none"
   });
   el += '&nbsp</div>';
 }
 
```

> 参考：[Hexo Stellar 主题装修笔记 - 宇宙尽头的餐馆 (flyalready.cn)](https://www.flyalready.cn/Hexo%20Stellar%20%E4%B8%BB%E9%A2%98%E8%A3%85%E4%BF%AE%E7%AC%94%E8%AE%B0/#%E5%9C%A8%E6%96%87%E7%AB%A0%E9%A1%B5%E9%9D%A2%E6%B7%BB%E5%8A%A0%E6%A0%87%E7%AD%BE%E6%98%BE%E7%A4%BA)

### 自定义css

#### 文章内更新日期始终显示

```css
/* 文章内更新日期始终显示 */
.bread-nav div#post-meta span.updated {
    visibility: visible !important;
}
```

#### 自定义滚动条样式

```css
/* from https: //github.com/weekdaycare/weekdaycare.github.io/blob/main/css/scrollbar.css */

/* 滚动条 */
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-track {
    background-color: rgba(200, 155, 155, 0);
    border-radius: 2em;
}

::-webkit-scrollbar-thumb {
    background-color: #c3c0c1 !important;
    /* background-image: -webkit-linear-gradient(45deg,
            rgba(255, 255, 255, 0.4) 25%,
            transparent 25%,
            transparent 50%,
            rgba(255, 255, 255, 0.4) 50%,
            rgba(255, 255, 255, 0.4) 75%,
            transparent 75%,
            transparent) !important; */
    border-radius: 2em;
}

::-webkit-scrollbar-corner {
    background-color: transparent;
}

[data-theme="dark"] ::-webkit-scrollbar-thumb {
    background-color: #1f1f1f !important;
}
```

#### 限制代码块的最大高度

```css
.md-text .highlight {
    max-height: 800px;
    overflow: auto;
}
```

#### 链接样式优化

```css
/* 文章内链接：为链接使用荧光笔下划线效果 */
/* 文章内链接 */
li:not([class]) a:not([class]),
p:not([class]) a:not([class]),
table a:not([class]) {
  /*color: var(--theme-link);*/
  padding-bottom: 3px; /* 增加底部padding */
  padding-right: 1px;
  margin-right: 2px;
 color: var(--theme-link);
  background: linear-gradient(0, var(--theme-link), var(--theme-link)) no-repeat center bottom / 100% 2px;
}
```

> 参考：[Hexo Stellar 主题装修笔记 - 宇宙尽头的餐馆 (flyalready.cn)](https://www.flyalready.cn/Hexo%20Stellar%20%E4%B8%BB%E9%A2%98%E8%A3%85%E4%BF%AE%E7%AC%94%E8%AE%B0/#%E8%B6%85%E9%93%BE%E6%8E%A5%E6%A0%B7%E5%BC%8F%E8%B0%83%E6%95%B4)
