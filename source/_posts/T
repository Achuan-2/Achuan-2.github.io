---
title: 统计分析丨T检验
date: '2024-04-25 11:19:54'
updated: '2024-07-29 16:36:28'
excerpt: >-
  T检验是一种用于比较数据集均值差异的统计方法，包括单样本t检验、配对样本t检验和独立样本t检验。可通过MATLAB、Python和R等工具实现t检验。如果数据不符合正态分布，可考虑使用非参数分析。多余两组数据时，可采用多重比较方法。
tags:
  - Matlab
categories:
  - 统计分析
permalink: /post/T Test.html
comments: true
toc: true
---



## 总结

T检验是一种用于比较数据集均值差异的统计方法，包括单样本t检验、配对样本t检验和独立样本t检验。可通过MATLAB、Python和R等工具实现t检验。如果数据不符合正态分布，可考虑使用非参数分析。多余两组数据时，可采用多重比较方法。

## 什么是T检验

T检验是由威廉·戈塞特（William Sealy Gosset）在20世纪初提出的，他使用“学生”（Student）这一化名，因此T检验又常被称为“学生T检验”。T检验的基本思想是通过计算两个独立样本的平均值差异的统计显著性，来判断这两个样本是否来自具有相同均值的两个总体。

### T检验的分类

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/image-20240728133646-11lq28m.png)​

T检验根据使用场景可以分为三类：

1. 单样本t检验(One-sample t-test)

    1. **用途**：比较单个样本的均值与已知总体均值的差异。
    2. **假设**：样本来自正态分布的总体。
    3. **例子**：

        * 从某厂生产的零件中随机抽取若干件，检验其某种规格的均值是否与要求的规格相等（双侧检验）
        * 在某偏远地区随机抽取若干健康男子，检验其脉搏均数是否高于全体健康男子平均水平（单侧检验）
        * 检验某一线城市全体高三学生视力水平是否比全国全体高三学生视力水平低（单侧检验）
        * 检验睁眼和闭眼的静息态脑电信号功率间的差值均值是否为零。
    4. **公式**：

        $$
        t = \frac{\bar{X} - \mu_0}{s / \sqrt{n}}
        $$

        其中，$\bar{X}$是样本均值，$\mu_0$是已知总体均值，$s$是样本标准差，$n$是样本大小。
2. 配对样本t检验(Paired Samplest-test)

    1. **用途**：用于比较同一组样本在两个不同条件下的均值是否显著不同
    2. **假设**：假设两个条件下的数据是成对的，即每个观察值在两个条件下都有对应。另外，假设**成对差值符合正态分布**。
    3. **例子**：

        * 同一受试对象的两个部分接受不同的处理（如对于一批血清样本，将其分为两个部分，利用不同的方法接受某种化合物的检验，检验结果的差异）
        * 同一受试对象的自身前后对照（如检验癌症患者术前、术后的某种指标的差异）
        * 同一受试者睁眼条件下静息态脑电信号功率的均值与闭眼条件下脑电信号的功率的均值是否具有显著的差异
    4. **公式**：

        $$
        t = \frac{\bar{d}}{s_d / \sqrt{n}}
        $$

        其中，$\bar{d}$是配对差值的均值，$s_d$是配对差值的标准差，$n$是配对数。
3. 独立样本t检验(Independent Samples t-test)

    1. **用途**：比较两个独立样本的均值是否显著不同
    2. **假设**：假设两组数据是独立的，即一个组的观察值不会受到另一个组的影响。，另外，假设两组数据符合**正态分布**和**方差齐性**。
    3. **例子**

        * 检验两工厂生产同种零件的规格是否相等（双侧检验）
        * 为研究某种治疗儿童贫血新药的疗效，以常规药作为对照，治疗一段时间后，检验施
        * 以新药的儿童血红蛋白的增加量是否比常规药的大（单侧检验）
        * 检验两种药物对治疗高血压的效果，检验两组药物的降压水平是否相等（双侧检验）
        * 检验男性被试和女性被试（或者正常人和病人）在睁眼条件下静息态脑电信号功率的均值是否具有显著差异（双侧检验）
    4. **公式**：

        $$
        t = \frac{\bar{X}_1 - \bar{X}_2}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}
        $$

        其中，$\bar{X}_1$和$\bar{X}_2$是两个样本的均值，$s_p$是合并标准差，$n_1$和$n_2$是两个样本的大小。

‍

### 如果数据不符合正态分布，该怎么办？

**如果样本量很小，就难以检验正态性**。在这种情况下，您需要对所分析的数据有一定的理解。比如，对于考试分数数据，如果清楚分数差异的潜在分布是符合正态分布的。即使是很小的样本量，讲师也可能会采用 *t* 检验并做出正态性假设。

如果您知道潜在测量值不是正态分布的，该怎么办？或者，如果样本量较大并且正态性检验被拒绝，该怎么办？在这种情况下，您可以使用非参数分析。这种类型的分析不需要假设数据来自特定的分布。

* 对于单样本 *t*­ 检验和配对 *t*­ 检验，可以使用Wilcoxon 符号秩检验替代。
* 对于独立双样本 *t*­ 检验，可以使用Wilcoxon 秩和检验替代。

### 如果有两个以上的组，该怎么办？

请使用多重比较方法。 多重比较方法包括：**方差分析 (ANOVA)** ，用于检验所有配对差异的 **Tukey-Kramer 检验**，用于将组间均值与总体均值进行比较的**均值分析 (ANOM)** ，或用于将每组均值与对照均值进行比较的 **Dunnett’s 检验**。

## 用代码实现t检验

* Matlab

  * **单一样本t检验**：

    ```matlab
    [h, p, ci, stats] = ttest(data, mu);
    ```
  * **配对样本t检验**：

    ```matlab
    [h, p, ci, stats] = ttest(data1, data2);
    ```
  * **独立样本t检验**：

    ```matlab
    [h, p, ci, stats] = ttest2(data1, data2);
    ```
* Python

  * **单一样本t检验**：

    ```python
    from scipy.stats import ttest_1samp
    t_stat, p_value = ttest_1samp(data, mu)
    ```
  * **独立样本t检验**：

    ```python
    from scipy.stats import ttest_ind
    t_stat, p_value = ttest_ind(data1, data2)
    ```
  * **配对样本t检验**：

    ```python
    from scipy.stats import ttest_rel
    t_stat, p_value = ttest_rel(data1, data2)
    ```
* R

  * **单一样本t检验**：

    ```r
    t_test <- t.test(data, mu = mu)
    ```
  * **配对样本t检验**：

    ```r
    t_test <- t.test(data1, data2, paired = TRUE)
    ```
  * **独立样本t检验**：

    ```r
    t_test <- t.test(data1, data2)
    ```

### 单一样本t检验

假设我们有一组学生的期末考试成绩，并且学校规定的平均成绩为90分。我们想知道这组学生的成绩是否显著高于或低于学校的平均水平。

#### MATLAB

```matlab
% 生成模拟数据：学生期末考试成绩
% 这些数据代表一组学生在期末考试中的成绩，学校规定的平均成绩是90分
data = [85, 88, 90, 87, 93, 86, 88]; % 样本数据
mu = 90; % 学校规定的平均成绩

% 执行单一样本t检验
[h, p, ci, stats] = ttest(data, mu);

% 显示结果
disp(['t-statistic: ', num2str(stats.tstat)]);
disp(['p-value: ', num2str(p)]);

% 根据p值判断检验结果
if p < 0.05
    disp('样本均值与总体均值有显著差异');
else
    disp('样本均值与总体均值无显著差异');
end
```

#### Python

```python
import scipy.stats as stats

# 生成模拟数据：学生期末考试成绩
# 这些数据代表一组学生在期末考试中的成绩，学校规定的平均成绩是90分
data = [85, 88, 90, 87, 93, 86, 88]  # 样本数据
mu = 90  # 学校规定的平均成绩

# 执行单一样本t检验
t_stat, p_value = stats.ttest_1samp(data, mu)

# 显示结果
print(f't-statistic: {t_stat}, p-value: {p_value}')

# 根据p值判断检验结果
if p_value < 0.05:
    print('样本均值与总体均值有显著差异')
else:
    print('样本均值与总体均值无显著差异')
```

#### R

```r
# 生成模拟数据：学生期末考试成绩
# 这些数据代表一组学生在期末考试中的成绩，学校规定的平均成绩是90分
data <- c(85, 88, 90, 87, 93, 86, 88) # 样本数据
mu <- 90 # 学校规定的平均成绩

# 执行单一样本t检验
t_test <- t.test(data, mu = mu)

# 显示结果
print(t_test)

# 根据p值判断检验结果
if (t_test$p.value < 0.05) {
    print('样本均值与总体均值有显著差异')
} else {
    print('样本均值与总体均值无显著差异')
}
```

### 配对样本t检验

假设我们有一组学生的期中和期末考试成绩，我们想比较这些学生在两个时间点的成绩是否有显著差异。

#### MATLAB

```matlab
% 生成模拟数据：学生期中与期末考试成绩
% 这些数据代表一组学生在期中和期末考试中的成绩
data1 = [85, 88, 90, 87, 93, 86, 88]; % 期中考试成绩
data2 = [88, 90, 91, 89, 94, 87, 90]; % 期末考试成绩

% 执行配对样本t检验
[h, p, ci, stats] = ttest(data1, data2);

% 显示结果
disp(['t-statistic: ', num2str(stats.tstat)]);
disp(['p-value: ', num2str(p)]);

% 根据p值判断检验结果
if p < 0.05
    disp('期中和期末考试成绩有显著差异');
else
    disp('期中和期末考试成绩无显著差异');
end
```

#### Python

```python
import scipy.stats as stats

# 生成模拟数据：学生期中与期末考试成绩
# 这些数据代表一组学生在期中和期末考试中的成绩
data1 = [85, 88, 90, 87, 93, 86, 88]  # 期中考试成绩
data2 = [88, 90, 91, 89, 94, 87, 90]  # 期末考试成绩

# 执行配对样本t检验
t_stat, p_value = stats.ttest_rel(data1, data2)

# 显示结果
print(f't-statistic: {t_stat}, p-value: {p_value}')

# 根据p值判断检验结果
if p_value < 0.05:
    print('期中和期末考试成绩有显著差异')
else:
    print('期中和期末考试成绩无显著差异')
```

#### R

```r
# 生成模拟数据：学生期中与期末考试成绩
# 这些数据代表一组学生在期中和期末考试中的成绩
data1 <- c(85, 88, 90, 87, 93, 86, 88) # 期中考试成绩
data2 <- c(88, 90, 91, 89, 94, 87, 90) # 期末考试成绩

# 执行配对样本t检验
t_test <- t.test(data1, data2, paired = TRUE)

# 显示结果
print(t_test)

# 根据p值判断检验结果
if (t_test$p.value < 0.05) {
    print('期中和期末考试成绩有显著差异')
} else {
    print('期中和期末考试成绩无显著差异')
}
```

### 独立样本t检验

**进行独立双样本t检验之前，应该进行方差齐性检验（homogeneity of variance test），即检查两组样本的总体方差是否相同**。方差齐性检验本身也是一种假设检验，通用的方法有Hartley检验、Bartlett检验和Leyene检验。

假设我们有两班学生的期末考试成绩，我们想比较这两班学生的成绩是否有显著差异。

#### MATLAB

```matlab
% 生成模拟数据：两班学生期末考试成绩
% 班级1的成绩
data1 = [85, 88, 90, 87, 93, 86, 88];
% 班级2的成绩
data2 = [78, 82, 84, 80, 85, 81, 79];

% 执行独立样本t检验
[h, p, ci, stats] = ttest2(data1, data2);

% 显示结果
disp(['t-statistic: ', num2str(stats.tstat)]);
disp(['p-value: ', num2str(p)]);

% 根据p值判断检验结果
if p < 0.05
    disp('两班学生的成绩有显著差异');
else
    disp('两班学生的成绩无显著差异');
end
```

补充：方差检验

```matlab
clc;clear;close all;
[num,txt,raw] = xlsread('Resting State.xlsx');
 
%% indenpendent two sample ttest
idx=num(:,5);
x=num(:,1);
x_M=x(idx==1);
x_F=x(idx==0);
% 方差齐性检验，即检验两组样本的总体方差是否相同
[p3,stats3] = vartestn(x,idx,...
    'TestType','LeveneAbsolute','Display','off');
disp('Independent t-test with Eyes open:');
disp(['Levene’s test: p = ',num2str(p3,'%0.2f')]);%方差检验方法：Levene检验
if p3<0.05
    disp('Equal variances not assumed') %方差不相同
    [h4,p4,ci4,stats4]=ttest2(x_M,x_F,...
        'Vartype','unequal');                               
else
    disp('Equal variances assumed'); %方差相同
    [h4,p4,ci4,stats4]=ttest2(x_M,x_F);
end
disp(['t = ',num2str(stats4.tstat,'%0.2f')]);
disp(['df = ',num2str(stats4.df,'%0.2f')]);
disp(['p = ',num2str(p4,'%0.2f')]);
```

#### Python

```python
import scipy.stats as stats

# 生成模拟数据：两班学生期末考试成绩
# 班级1的成绩
data1 = [85, 88, 90, 87, 93, 86, 88]
# 班级2的成绩
data2 = [78, 82, 84, 80, 85, 81, 79]

# 执行独立样本t检验
t_stat, p_value = stats.ttest_ind(data1, data2)

# 显示结果
print(f't-statistic: {t_stat}, p-value: {p_value}')

# 根据p值判断检验结果
if p_value < 0.05:
    print('两班学生的成绩有显著差异')
else:
    print('两班学生的成绩无显著差异')
```

#### R

```r
# 生成模拟数据：两班学生期末考试成绩
# 班级1的成绩
data1 <- c(85, 88, 90, 87, 93, 86, 88)
# 班级2的成绩
data2 <- c(78, 82, 84, 80, 85, 81, 79)

# 执行独立样本t检验
t_test <- t.test(data1, data2)

# 显示结果
print(t_test)

# 根据p值判断检验结果
if (t_test$p.value < 0.05) {
    print('两班学生的成绩有显著差异')
} else {
    print('两班学生的成绩无显著差异')
}
```

## 问题笔记

* 独立样本t检验和配对样本t检验的区别

  * **独立样本t检验**：用于比较两个独立样本的均值是否存在显著差异。这两个样本来自两个不同的群体，且样本之间互不相关。
  * **配对样本t检验**：用于比较两个相关样本的均值是否存在显著差异。这两个样本来自同一个群体，但在不同条件或时间点下进行测试。
* **独立样本t检验**的条件为什么需要均值的分布符合正态分布

  独立样本t检验的公式依赖于**t分布**，该分布是假设样本均值的分布接近正态分布时推导出来的。如果样本均值的分布不符合正态分布，那么t分布的应用就不再有效，进而影响检验的准确性。正因为此，在使用t检验时，我们通常希望样本均值的分布符合正态分布。

  对于小样本量（通常指$n < 30$），样本均值的分布可能不能很好地近似正态分布，因此我们需要原始数据本身来自正态分布。在这种情况下，我们通常需要进行正态性检验（如Shapiro-Wilk检验）来确保数据符合要求。

  **当样本量较大时（通常n≥30），** 根据中心极限定理，**即使原始数据不完全符合正态分布，样本均值的抽样分布会近似服从正态分布，所以t检验仍然可以得到相对可靠的结果**。
* t检验与u检验、卡方检验的区别

  |检验类型|用途|假设条件|数据类型|
  | ----------| --------------------| --------------------| ---------------|
  |T检验|比较均值|正态分布，方差相等|连续变量|
  |U检验 **(Mann-Whitney U Test)**|比较分布|无需正态分布|连续/有序变量|
  |卡方检验|检验独立性和适配性|预期频数\>5|分类变量|

## 参考资料

* [Student&apos;s t-test - Wikipedia](https://en.wikipedia.org/wiki/Student%27s_t-test)
* [配对 t 检验 | 统计学简介 | JMP](https://www.jmp.com/zh_cn/statistics-knowledge-portal/t-test/paired-t-test.html)
* [双样本 t 检验 | 统计学简介 | JMP](https://www.jmp.com/zh_cn/statistics-knowledge-portal/t-test/two-sample-t-test.html)
* [单样本 t 检验 | 统计学简介 | JMP](https://www.jmp.com/zh_cn/statistics-knowledge-portal/t-test/one-sample-t-test.html)

‍
