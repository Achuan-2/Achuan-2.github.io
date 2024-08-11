---
title: 假设检验丨Wilcoxon 秩和检验 (Mann-Whitney U检验)
date: '2024-07-20 22:14:14'
updated: '2024-08-11 19:20:04'
excerpt: >-
  Wilcoxon Rank Sum Test（威尔科克森秩和检验），也称为Mann-Whitney
  U检验，是一种**非参数检验方法**，用于比较两组独立样本的分布差异。与t检验不同，Wilcoxon Rank Sum
  Test不假设数据来自正态分布，因此在样本量较小且不确定数据分布的情况下尤为有用。
categories:
  - 统计分析
permalink: /post/Wilcoxon Rank Sum Test, Mann-Whitney U Test, 曼-惠特尼U检验.html
comments: true
toc: true
---



## 什么是Wilcoxon秩和检验

### 基本概念

Wilcoxon Rank Sum Test（威尔科克森秩和检验），也称为Mann-Whitney U检验，是一种**非参数检验方法**，用于比较两组独立样本的分布差异。与t检验不同，Wilcoxon Rank Sum Test不假设数据来自正态分布，因此在样本量较小且不确定数据分布的情况下尤为有用。

Wilcoxon秩和检验通常用于以下情况：

1. **独立样本的比较**：例如两个不同群体在某个变量上的表现比较。Wilcoxon秩和检验<u>不要求两个样本的数量必须相等</u>。即使样本大小不同，这种检验仍然有效。
2. **数据类型**：观察变量为<u>连续变量</u>(不满足正态分布或方差不齐或分布未知)或<u>等级变量</u>。

### Wilcoxon秩和检验的步骤

1. 提出原假设和备择假设：

    * $H_0$：两组样本来自相同的分布
    * $H_1$：两组样本来自不同的分布
2. **数据合并与排序**：将两个样本的数据合并，并对所有数据进行排序。
3. **计算秩次和**：为每个数据点赋予秩次，并分别计算每个样本的秩次和$W_1$ 和 $W_2$，得到较小样本组的秩和$W$。
4. **计算检验统计量**：根据秩次和计算检验统计量，计算$p$值，得出结论。

    * **对于小样本**（$n < 20$） **，使用U统计量计算p值**

      $$
      U_1 = W_1- \frac{n_1(n_1 + 1)}{2}
      $$

      $$
      U_2 = W_2- \frac{n_2(n_2 + 1)}{2}
      $$

      U 统计量取较小的那个：

      $$
      U = \min(U_1, U_2)
      $$

      其中，$n_1$ 和 $n_2$ 分别是两组样本的大小。

      U统计量计算p值，需要计算所有可能的秩和组合产生的U值，计算量比较大

      也可以根据alpha值和样本数量查表：[Mann-Whitney Table | Real Statistics Using Excel (real-statistics.com)](https://real-statistics.com/statistics-tables/mann-whitney-table/)
    * **对于大样本**（$n > 20$） **，使用z 统计量来计算 p 值。**

      $$
      z={\frac {U-m_{U}}{\sigma _{U}}}
      $$

      其中 $m_U$ 和 $σ_U$ 是 U 的均值和标准差，近似为标准正态偏差，其显著性可以在正态分布表中检查。mU 和 σU 的值为

      $$
      m_{U}={\frac {n_{1}n_{2}}{2}}
      $$

      $$
      \sigma_{U}={\sqrt {n_{1}n_{2}(n_{1}+n_{2}+1) \over 12}}
      $$

      在存在并列排名的情况下，标准差的公式更为复杂。σ 应该按如下方式进行调整：

      $$
      \sigma _{\text{ties}}={\sqrt {{n_{1}n_{2}(n_{1}+n_{2}+1) \over 12}-{n_{1}n_{2}\sum _{k=1}^{K}(t_{k}^{3}-t_{k}) \over 12n(n-1)}}}
      $$

      根据z值，可以根据标准正态分布获得pvalue。

## 用代码实现Wilcoxon秩和检验

假设周董分别在上海和广州开五场演唱会，大家纷纷购买这些演唱会的门票。由于购买的人太多了，能买到票的概率其实并不高。现在我想知道，在上海和广州买到票的概率是否相同。下面是两个城市不同场买到票的概率：

​![Clip_2024-08-11_13-00-03](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/Clip_2024-08-11_13-00-03-20240811130007-8e8k93c.png)​

> 例子来源于：[Wilcoxon秩和检验｜说人话的统计学_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Aw411w7CG/?spm_id_from=333.999.0.0)

### MATLAB

**使用函数：**​[ranksum](https://ww2.mathworks.cn/help/releases/R2024b/stats/ranksum.html)

```matlab
[p, h, stats] = ranksum(x, y,'alpha',0.05,'method',
exact','tail',both);
```

* 参数：

  * ​`x`​：第一个样本（向量）
  * ​`y`​：第二个样本（向量）
  * ​**​`alpha`​**​:

    * 这是显著性水平，默认值为0.05。它表示检验中接受或拒绝原假设的临界值。如果你不指定`'alpha'`​参数，`ranksum`​ 函数会默认使用0.05。
  * ​**​`method`​**​:

    * ​`'exact'`​: 该选项要求 `ranksum`​ 函数使用精确计算方法来确定 p 值。这种方法通常在样本量较小时使用。
    * 你还可以使用 `'approximate'`​ 选项，它基于正态分布来近似计算 p 值，通常在样本量较大时使用。
  * ​**​`tail`​**​:

    * ​`'both'`​: 双尾检验。这意味着你要测试两个样本分布是否不相等。
    * ​`'right'`​: 右尾检验，测试 x 样本的分布是否比 y 样本更大。
    * ​`'left'`​: 左尾检验，测试 x 样本的分布是否比 y 样本更小。
* 返回值：

  * ​`p`​：p值
  * ​`h`​：假设检验结果（1表示拒绝原假设，0表示不能拒绝原假设）
  * ​`stats`​：包含额外统计信息的结构体

    * ranksum :秩和检验统计量的值
    * zval:z 统计量的值（当 'method' 为 'approximate' 时计算）

**示例：**

```matlab
% 定义数据
shanghai = [16.0, 28.5, 22.7, 28.1, 38.6];
guangzhou = [32.5, 35.5, 40.2, 28.1, 31.6];

% 进行Wilcoxon秩和检验
[p, h, stats] = ranksum(shanghai, guangzhou);

% 输出结果
fprintf('p值: %.4f\n', p);
fprintf('检验统计量: %.4f\n', stats.ranksum);


if h == 1
    disp('拒绝原假设，两个城市买到票的概率存在显著差异。');
else
    disp('不能拒绝原假设，没有足够证据表明两个城市买到票的概率存在显著差异。');
end

```

### Python (scipy.stats模块)

**使用的函数：**​[ranksums](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.ranksums.html)

```python
from scipy import stats
statistic, p_value = ranksums(x, y, alternative='two-sided', *, axis=0, nan_policy='propagate', keepdims=False)
```

**示例；**

```python
from scipy import stats
import numpy as np

# 定义数据
shanghai = np.array([16.0, 28.5, 22.7, 28.1, 38.6])
guangzhou = np.array([32.5, 35.5, 40.2, 28.1, 31.6])

# 进行Wilcoxon秩和检验
statistic, p_value = stats.ranksums(shanghai, guangzhou)

# 输出结果
print(f"p值: {p_value:.4f}")
print(f"Z统计量: {statistic:.4f}")

if p_value < 0.05:
    print("拒绝原假设，两个城市买到票的概率存在显著差异。")
else:
    print("不能拒绝原假设，没有足够证据表明两个城市买到票的概率存在显著差异。")

```

### R

使用函数：[wilcox.test function - RDocumentation](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/wilcox.test)

```r
wilcox.test(x, y = NULL,
            alternative = c("two.sided", "less", "greater"),
            mu = 0, paired = FALSE, exact = NULL, correct = TRUE,
            conf.int = FALSE, conf.level = 0.95, …)
```

**示例：**

```r
# 定义数据
shanghai <- c(16.0, 28.5, 22.7, 28.1, 38.6)
guangzhou <- c(32.5, 35.5, 40.2, 28.1, 31.6)

# 进行Wilcoxon秩和检验
result <- wilcox.test(shanghai, guangzhou,paired = FALSE)

# 输出结果
cat("p值:", format(result$p.value, digits=4), "\n")
cat("W统计量:", result$statistic, "\n")

if (result$p.value < 0.05) {
  cat("拒绝原假设，两个城市买到票的概率存在显著差异。\n")
} else {
  cat("不能拒绝原假设，没有足够证据表明两个城市买到票的概率存在显著差异。\n")
}

```

## 问题

* 为什么在秩和检验里面，要比较<u>正负秩和</u>的绝对值，而不是直接比较<u>正负差值</u>的绝对值呢？

  * 因为wilcoxon配对符号秩检验是在不服从<u>正态分布</u>的前提下使用的，因此关注的是数据的相对位置的差异，而不是数据本身的具体差异；又因为其原数据分布不服从正态分布，**研究相对位置的差异有助于增强对异常值稳定性**，更适合不依赖于总体分布类型的非参数统计。
* Wilcoxon秩和检验和Mann-Whitney U检验、Wilcoxon符号秩检验关系

  * **Wilcoxon秩和检验**是检验两组独立数据是否来自具有相同中位数的连续分布，检验它们是否有显著差异，零假设是他们的中位数一致。
  * **Wilcoxon秩和检验等效Mann-Whitney U检验**
  * **Wilcoxon符号秩检验用于配对样本的检验。**

‍
