---
title: AI+MCP+Pubmed：自动搜索和总结文献，快速生成综述
date: '2025-04-10 11:55:45'
updated: '2025-04-10 11:55:46'
excerpt: "我自己用Pubmed搜索文献，常常会因为搜索条件不合适而找不到相关的文献，一些复杂的搜索条件自己写，需要想各种同义词，添加逻辑运算符，很麻烦\n\t\n现在，通过MCP服务器，ai生成文献搜索条件后，ai会自己就在Pubmed完成搜索操作，搜索之后，还可以再自动进行翻译、总结等，可以大大减少自己的负担\n\t\n相比目前的各个AI自带的网页搜索功能，这种方法获取到的文献是最可靠的，避免AI编造不存在的文献，也能获取到最新的文献，还可以通过添加期刊、年份的要求，获取特定时间特定期刊的文献。"
categories:
  - 研究生的自我修养
permalink: >-
  /post/ai-mcp-pubmed-automatically-search-and-summarize-literature-quickly-generate-reviews-fztog.html
comments: true
toc: true
---





> 我自己用Pubmed搜索文献，常常会因为搜索条件不合适而找不到相关的文献，一些复杂的搜索条件自己写，需要想各种同义词，添加逻辑运算符，很麻烦
>
> 现在，通过MCP服务器，ai生成文献搜索条件后，ai会自己就在Pubmed完成搜索操作，搜索之后，还可以再自动进行翻译、总结等，可以大大减少自己的负担
>
> 相比目前的各个AI自带的网页搜索功能，这种方法获取到的文献是最可靠的，避免AI编造不存在的文献，也能获取到最新的文献，还可以通过添加期刊、年份的要求，获取特定时间特定期刊的文献。

![PixPin_2025-04-09_22-23-13](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_22-23-13-20250409222316-2l2rxs8.png)

## MCP项目地址

[andybrandt/mcp-simple-pubmed: MCP server for searching and querying PubMed medical papers/research database](https://github.com/andybrandt/mcp-simple-pubmed)

## 配置

安装mcp-simple-pubmed

```matlab
conda create -n simple-pubmed python=3.10
pip install mcp-simple-pubmed
```

在AI客户端（Claude、Cursor、VSCode、cherry studio等）配置mcp服务器

```matlab
{
  "mcpServers": {
    "simple-pubmed": {
      "command": "C:\\Users\\Achuan-2\\miniforge3\\envs\\simple-pubmed\\python",
      "args": [
        "-m",
        "mcp_simple_pubmed"
      ],
      "env": {
        "PUBMED_EMAIL": "your-email@example.com",
        "PUBMED_API_KEY": "your-api-key" 
      }
    }
  }
}
```

在cherry studio的配置

![PixPin_2025-04-09_20-23-39](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_20-23-39-20250409202343-0vyfrfy.png)

## pubmed的调用频率

标准请求速率限制为每秒 3 次。

如果需要，可以注册Pubmed账号获取 API 密钥，这将提供每秒 10 次的请求次数。

[https://account.ncbi.nlm.nih.gov/settings/](https://account.ncbi.nlm.nih.gov/settings/)

![PixPin_2025-04-09_20-13-46](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_20-13-46-20250409201347-4w2efy1.png)

## 个人调用mcp-simple-pubmed的Prompt

1️⃣ 当用户搜索相关文献时，根据用户输入的主题，使用`search-pubmed`​tool，搜索相关文献

查询要求：

* query参数要求使用英文翻译，查询条件需要符合pubmed规范

  * 尽可能使用逻辑运算符AND、OR、NOT，以及同义词，来组合查询词，以查到更多的相关文章。
  * 除非一些专有名词，否则不要用AND+词组的方式进行查询，尽量用AND/OR+单词的形式进行组合，避免关键词没有命中，比如吸引子用attractor而不用attractor dynamics，因为很多文章可能只会用attractor这个单词；
  * 一些条件比如data anlysis不要添加到搜索条件，只添加与科研主题和具体分析方法有关的搜索条件
* max_result：用户没有要求的话，默认为20

查询后向用户展示你的query参数

之后输出文章，文章输出要求有论文标题、PMID、论文摘要、发表期刊、发表日期、作者

* 标题使用英文+中文翻译
* 摘要使用中文翻译
* PMID用链接包裹，可以直接跳转到对应网页

输出的结果整理为符合markdown规范的笔记

如果查询的结果很少，请调整query，删除某些条件，或者把词组改为单词，重新查询

2️⃣当用户具体要查看或总结某篇文章的内容时，使用`get_paper_fulltext`​ tool来获取文献全文，如果输入的是文章标题，请先使用`search-pubmed tool`​获取PMID，再获取全文  
3️⃣当用户要求生成综述时，先用`search-pubmed`​ tool 搜索相关文献，再使用 `get_paper_fulltext`​ tool获取搜索到的文献全文，最终总结成综述，用PMID标注引文

## 示例

### 搜索相关文献

搜索关于小鼠钙成像并使用吸引子理论来分析数据的文章，找到了15篇

![PixPin_2025-04-09_20-14-34](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_20-14-34-20250409201437-b1pk5rf.png)

![PixPin_2025-04-09_20-14-53](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_20-14-53-20250409201501-177vobk.png)

### 总结单篇文章

总结Encoding of female mating dynamics by a hypothalamic line attractor这篇文献的result和研究方法，使用 get_paper_fulltext 工具

![PixPin_2025-04-09_20-15-30](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_20-15-30-20250409201531-cihvgpy.png)

### 总结多篇文献

用列表的方式整理不同文章是在哪些脑区、用了什么吸引子，使用吸引子得到哪些结论的

![PixPin_2025-04-09_20-38-24](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-04-09_20-38-24-20250409203828-zhfw73b.png)
