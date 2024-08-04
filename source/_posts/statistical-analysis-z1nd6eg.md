---
title: '@统计分析'
date: '2024-08-04 11:21:06'
updated: '2024-08-04 11:21:07'
excerpt: >-
  T检验是一种用于比较数据集均值差异的统计方法，包括单样本t检验、配对样本t检验和独立样本t检验。t检验的前提是要求样本服从正态分布或近似正态分布，当样本量大于30的时候，可以认为数据近似正态分布，对于小样本，可以利用一些变换（取对数、开根号、倒数等等）试图将其转化为服从正态分布的数据。如果小样本数据不符合正态分布，可考虑使用非参数分析。当多于两组数据进行比较差异时，可采用多重比较方法。
tags:
  - Matlab
categories:
  - 统计分析
permalink: /post/statistical-analysis-z1nd6eg.html
comments: true
toc: true
---



## 数据库

|主键|单选|
| ---------------------------------------------------------| ----|
|参数检验和非参数检验方法||
|Matlab 绘制显著性差异||
|什么是假设检验||
|方差解释率 Variance Explained Ratio||
|Friedman’s test||
|K-S 检验||
|卡方检验||
|Kruskal-Wallis test||
|假设检验丨Wilcoxon rank sum test （Wilcoxon 秩和检验）||
|假设检验丨Wilcoxon Signed Rank Test（Wilcoxon符号秩检验）||
|假设检验丨sign test（符号检验）||
|假设检验丨z检验||
|T 检验||

‍

## 在学的课程

* [ ] [【统计学速成课】Statistics - [45集全/中英双语] - Crash Course Statistics](https://www.bilibili.com/video/BV1B7411v73M/?p=2&amp;spm_id_from=333.999.top_right_bar_window_history.content.click&amp;vd_source=b4a1fcb6dce305e26d8d16d9cbb71304)：吃饭碎片时间可以看看
* [ ] [所有参数检验和非参数检验方法及matlab程序 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/503135440)

‍

‍

## 检验方法学习笔记

​![image](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/image-20240424122504-1478zas.png)​

​![image](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/image-20240424122527-zrhe5kk.png)

[Statistics and Machine Learning Toolbox Documentation - MathWorks 中国](https://ww2.mathworks.cn/help/stats/index.html?s_tid=CRUX_lftnav)

[所有参数检验和非参数检验方法及matlab程序 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/503135440)

* 参数检验

  * T检验 ：T检验是一种用于比较数据集均值差异的统计方法，包括单样本t检验、配对样本t检验和独立样本t检验。t检验的前提是要求样本服从正态分布或近似正态分布，当样本量大于30的时候，可以认为数据近似正态分布，对于小样本 **，** 可以利用一些变换（取对数、开根号、倒数等等）试图将其转化为服从正态分布的数据。如果小样本数据不符合正态分布，可考虑使用非参数分析。当多于两组数据进行比较差异时，可采用多重比较方法。[ttest](https://ww2.mathworks.cn/help/stats/ttest.html)（**单样本t检验**、**配对样本t检验**）丨[ttest2](https://ww2.mathworks.cn/help/stats/ttest2.html)（**独立样本t检验**）
  * 假设检验丨z检验

    * [假设检验、Z检验与T检验 - 人工智能遇见磐创 - 博客园 (cnblogs.com)](https://www.cnblogs.com/panchuangai/p/13215244.html)
    * [z 检验 - MATLAB ztest - MathWorks 中国](https://ww2.mathworks.cn/help/stats/ztest.html)
    * 和t检验区别：

      1. [样本容量](https://wiki.mbalib.com/wiki/%E6%A0%B7%E6%9C%AC%E5%AE%B9%E9%87%8F)不同：Z检验适用于大[样本](https://wiki.mbalib.com/wiki/%E6%A0%B7%E6%9C%AC)（样本容量大于30）情况下的假设检验，而T检验适用于[小样](https://wiki.mbalib.com/wiki/%E5%B0%8F%E6%A0%B7)本（样本容量小于30）情况下的假设检验。
      2. [方差](https://wiki.mbalib.com/wiki/%E6%96%B9%E5%B7%AE)已知与未知：Z检验要求[总体](https://wiki.mbalib.com/wiki/%E6%80%BB%E4%BD%93)方差已知，而T检验则允许总体方差未知，通过[样本方差](https://wiki.mbalib.com/wiki/%E6%A0%B7%E6%9C%AC%E6%96%B9%E5%B7%AE)的估计来进行假设检验。
  * [方差分析（ANOVA）分类、应用举例及matlab代码_anova方差分析-CSDN博客](https://blog.csdn.net/weixin_46271668/article/details/124021730)
* 非参数检验

  * sign test符号检验：用于检验**两个配对样本**之间的中位数差异。它特别适用于数据不满足正态分布的情况，因此不需要对数据进行分布假设。Wilcoxon符号秩检验要求数据是连续的并且是对称分布的，而sign test没有对称分布要求，数据也可以是有序的数据。[signtest](https://ww2.mathworks.cn/help/stats/signtest.html)
  * Wilcoxon Signed Rank Test丨Wilcoxon符号秩检验：用于检验**两个配对样本**之间的中位数差异，常作为配对样本t检验的非参数替代方法。[signrank](https://ww2.mathworks.cn/help/stats/signrank.html)
  * 假设检验丨Wilcoxon rank sum test （Wilcoxon 秩和检验）：也称为Mann-Whitney U Test，是一种非参数检验，用于比较**两组独立样本**的分布是否相同，特别是用于检验两组样本的中位数是否存在显著差异。[ranksum](https://ww2.mathworks.cn/help/stats/ranksum.html)​
  * 卡方检验

    * [卡方独立性检验｜说人话的统计学_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1AF411o7bf/?spm_id_from=333.999.0.0&vd_source=b4a1fcb6dce305e26d8d16d9cbb71304)
    * [How can I perform a chi-square test to determine how statistically different two proportions are in Statistics Toolbox 7.2 (R... - MATLAB Answers - MATLAB Central (mathworks.cn)](https://ww2.mathworks.cn/matlabcentral/answers/96572-how-can-i-perform-a-chi-square-test-to-determine-how-statistically-different-two-proportions-are-in)
  * Kruskal-Wallis test：又叫H检验，非参数的假设检验方法，是 Mann-Whitney U test的扩展，用于检验**三组或以上**样本中是否至少有一组存在显著不同。与方差分析（ANOVA）和t检验相比，它们对数据的分布特征没有前置要求，且可以应用于顺序性变量的分析。[kruskalwallis](https://ww2.mathworks.cn/help/stats/kruskalwallis.html)
  * K-S 检验
  * Friedman’s test
* 正态分布检验

  * [正态性检验方法——K-S检验和S-W检验的区别 - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/news/483912)

    **当分析小于50行的小样本数据时**，我们倾向于看S-W检验得到的正态性检验结果；

    **当分析大于50行的大样本数据时**，我们倾向于看K-S检验得到的正态性检验结果；

    **当数据量大于5000行时**，SPSS只会显示K-S检验这一种检验方法。
  * jbtest, lillietest与kstest的比较:

    (1) jbtest与lillietest均是检验样本是否来自正态分布, 而kstest可检验样本来自任意指定的分布;

    (2) jbtest是利用偏度峰度来检验, 适用于大样本; 而对于小样本, 则用lillietest来检验;

    (3) lillietest与kstest的检验原理均是用x的经验分布函数与一个有相同均值与方差的正态分布的分布函数进行比较, 不同的是lisllietest中正态分布的参数是由x估计得来, 而kstest中正态分布的参数是事先指定的

### inbox

‍

* matlab 实现shaprio wilk test

  [Shapiro-Wilk and Shapiro-Francia normality tests. - File Exchange - MATLAB Central (mathworks.cn)](https://ww2.mathworks.cn/matlabcentral/fileexchange/13964-shapiro-wilk-and-shapiro-francia-normality-tests)
* ![Clip_2024-08-03_22-26-49](https://raw.githubusercontent.com/Achuan-2/Picbed/pic/assets/Clip_2024-08-03_22-26-49-20240803222656-cwg4s17.png)​
* |matlab 函数|检验方法||
  | ----------------------------| -------------------------------| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  |​[`ttest`](https://ww2.mathworks.cn/help/stats/ttest.html)​|单样本和配对样本 t 检验|使用单样本 t 检验返回原假设的检验决策，该原假设假定 x 中的数据来自均值等于零且方差未知的正态分布。备择假设是总体分布的均值不等于零。如果检验在 5% 的显著性水平上拒绝原假设，则结果 h 为 1，否则为 0。|
  |​[`ttest2`](https://ww2.mathworks.cn/help/stats/ttest2.html)​|双样本 t 检验||
  |​[`signtest`](https://ww2.mathworks.cn/help/stats/signtest.html)​|Sign test||
  |​[`signrank`](https://ww2.mathworks.cn/help/stats/signrank.html)​|Wilcoxon signed rank test||
  |​[`ranksum`](https://ww2.mathworks.cn/help/stats/ranksum.html)​|威尔科克森秩和检验||
  |​[`kruskalwallis`](https://ww2.mathworks.cn/help/stats/kruskalwallis.html)​|Kruskal-Wallis test||
  |​[`friedman`](https://ww2.mathworks.cn/help/stats/friedman.html)​|Friedman’s test||
  |​[`multcompare`](https://ww2.mathworks.cn/help/stats/multcompare.html)​|Multiple comparison test||
  |​[`sampsizepwr`](https://ww2.mathworks.cn/help/stats/sampsizepwr.html)​|Sample size and power of test||
  |​[`ztest`](https://ww2.mathworks.cn/help/stats/ztest.html)​|z 检验||

  ‍
* 所进行的t检验是**双尾**的。也可以指定参数 **“Tail”为”left“或者“right”** ，使其进行对应的左尾或者右尾的t检验。
* 参数检验和非参数检验方法
* Matlab 绘制显著性差异
* 什么是假设检验
* 方差解释率 Variance Explained Ratio
* [t-检验（t-test）的应用举例及matlab代码 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/503033997)
* [Matlab绘制柱状图（含显著性差异*） - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/493488833)
* [方差分析（ANOVA）分类、应用举例及matlab代码 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/503071438)
* [所有参数检验和非参数检验方法及matlab程序 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/503135440)

## 分布

* 超几何分布

## 回归

* 回归分析中回归一词的来源
* Matlab 回归的函数好多呀

  * [ployfit Polynomial curve fitting](https://ww2.mathworks.cn/help/matlab/ref/polyfit.html)
  * [fitglm 创建广义线性回归模](https://ww2.mathworks.cn/help/stats/fitglm.html)
  * [glmfit-Fit generalized linear regression model](https://ww2.mathworks.cn/help/stats/glmfit.html?requestedDomain=cn)
  * [regress-多重线性回归](https://ww2.mathworks.cn/help/stats/regress.html?requestedDomain=cn)

    * 要计算具有常数项（截距）的模型的系数估计值，请在矩阵 `X`​ 中包含一个由 1 构成的列。
  * smothspline

## 统计分析软件有哪些？

无需编程

* SPSS
* origin
* Stata

  小巧便携，功能够用，但是有时候图做的不是很好看。
* GraphPad Prism

编程

* Python + Matplotlib/Seaborn
* MATLAB
* R语言 + ggplot2

云平台

* CNSknowall

## 资源

[Statistics and Machine Learning Toolbox Documentation - MathWorks 中国](https://ww2.mathworks.cn/help/stats/index.html?s_tid=CRUX_lftnav)

[Visualize-ML/Book5_Essentials-of-Probability-and-Statistics: Book_5_《统计至简》 | 鸢尾花书：从加减乘除到机器学习；上架！ (github.com)](https://github.com/Visualize-ML/Book5_Essentials-of-Probability-and-Statistics/tree/main)

‍
