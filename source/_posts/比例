---
title: 假设检验丨比率 Z 检验
date: '2024-08-04 17:22:40'
updated: '2024-09-21 15:09:34'
categories:
  - 统计分析
permalink: /post/比例 Z 检验.html
comments: true
toc: true
---



## 介绍

比例Z检验主要用于检验样本比例与总体比例是否存在显著差异，或者两个独立样本的比例之间是否存在显著差异。通常，这种检验用于**大样本**（通常样本大小大于30）和**二项式分布数据**。

比例Z检验基于中心极限定理。当样本量足够大时，样本比例的抽样分布近似服从正态分布。

相关笔记：均值Z检验

## **应用场景**

* 单样本比例检验：检验样本比例是否与已知或假设的总体比例显著不同。

  政府决定扶持员工少数民族占比超过15%的公司。一家公司共73人，其中13人是少数民族。则该公司员工少数民族占比是否显著超过政府规定的15%？

  一个推荐系统上线前的预期点击转化率为50%。上线后，曝光用户数为10000，其中5100个用户点击了推荐物品，真实点击转化率为51%，高于预期的50%。但是在曝光用户数为10000的量级上，高于预期1%是否能够说明真实和预期点击转化率有显著差异呢？
* 双样本比例检验：比较两个独立样本的比例是否存在显著差异。

  为了解聚乙二醇400（PEG 400）对儿童功能性便秘的治疗效果，某医生将符合试验条件的216名8岁以上功能性便秘患儿随机分为试验组和对照组，实验组口服PFG400治疗，对照组口服乳果糖治疗。其中试验组105人，两周缓解76人；果乳糖组111人，两周缓解49人。试比较试验组和对照组治疗后便秘的两周缓解率有无差别。

  在一次政治票选中，46%的男性和49%的女性声称他们支持特朗普称为总统。如果该次统计当中包含247名男性和185名女性，那么男性和女性对于特朗普的支持率是否有显著差异？

## 注意事项:

1. 这些检验假设样本量足够大(通常n > 30)。
2. 对于单样本比例检验,还假设np > 5且n(1-p) > 5。
3. 对于两个比例的差异Z检验,假设n1p1 > 5, n1(1-p1) > 5, n2p2 > 5, n2(1-p2) > 5。

如果这些假设不满足,可能需要考虑使用其他方法,如Fisher's exact test或卡方检验。

‍

## 公式

1. 单样本的比例Z检验

    比例的Z检验用于检验样本比例与总体比例是否有显著差异。其公式为:

    $$
    Z = \dfrac{\hat{p} - p}{\sqrt{\dfrac{p(1-p)}{n}}}
    $$

    其中:

    * $\hat{p}$ 是样本比例
    * $p$ 是假设的总体比例
    * $n$ 是样本量
2. 独立双样本的比例Z检验

    用于检验两个独立样本的比例是否有显著差异。其公式为:

    $$
    Z = \frac{(\hat{p}_1 - \hat{p}_2) - (p_1 - p_2)}{\sqrt{\dfrac{\hat{p}_1(1-\hat{p}_1)}{n_1} + \dfrac{\hat{p}_2(1-\hat{p}_2)}{n_2}}}
    $$

    其中:

    * $\hat{p}_1$ 和 $\hat{p}_2$ 分别是两个样本的比例
    * $p_1$ 和 $p_2$ 分别是两个总体的比例
    * $n_1$ 和 $n_2$ 分别是两个样本的样本量

    当原假设为 $H_0: p_1 = p_2$ 时，我们可以使用池化估计：

    $$
    Z = \frac{\hat{p}_1 - \hat{p}_2}{\sqrt{\hat{p}(1-\hat{p})(\frac{1}{n_1} + \frac{1}{n_2})}}
    $$

    其中，$\hat{p} = \frac{x_1 + x_2}{n_1 + n_2}$ 是池化比例估计，$x_1$ 和 $x_2$ 分别是两个样本中具有某特征的个数。

## 代码实现

### matlab实现

用MATLAB实现单样本比例检验和两个比例的差异Z检验。将分别创建两个函数来实现这两种检验。

#### 单样本比例检验

首先,让我们实现单样本比例检验的函数:

```matlab
function [z, p_value] = proportion_z_test(x, n, p0, alpha)
% 单样本比例检验
% 输入:
%   x: 样本中具有某特征的个数
%   n: 样本总量
%   p0: 假设的总体比例
%   alpha: 显著性水平 (默认为0.05)
% 输出:
%   z: z统计量
%   p_value: p值

if nargin < 4
    alpha = 0.05;
end

p_hat = x / n;
se = sqrt(p0 * (1 - p0) / n);
z = (p_hat - p0) / se;

p_value = 2 * (1 - normcdf(abs(z)));

% 输出结果
fprintf('Z统计量: %.4f\n', z);
fprintf('P值: %.4f\n', p_value);
fprintf('在%.2f的显著性水平下:\n', alpha);
if p_value < alpha
    fprintf('拒绝原假设,样本比例与总体比例有显著差异\n');
else
    fprintf('不能拒绝原假设,样本比例与总体比例无显著差异\n');
end

end
```

使用示例:

```matlab
% 例如,在100个样本中,有60个具有某特征,假设总体比例为0.5
[z, p] = proportion_z_test(60, 100, 0.5);
```

#### 两个比例的差异Z检验

现在,让我们实现两个比例的差异Z检验的函数:

```matlab
function [z, p_value] = two_proportion_z_test(x1, n1, x2, n2, alpha)
% 两个比例的差异Z检验
% 输入:
%   x1, x2: 两个样本中具有某特征的个数
%   n1, n2: 两个样本的总量
%   alpha: 显著性水平 (默认为0.05)
% 输出:
%   z: z统计量
%   p_value: p值

if nargin < 5
    alpha = 0.05;
end

p1 = x1 / n1;
p2 = x2 / n2;
p_pooled = (x1 + x2) / (n1 + n2);

se = sqrt(p_pooled * (1 - p_pooled) * (1/n1 + 1/n2));
z = (p1 - p2) / se;

p_value = 2 * (1 - normcdf(abs(z)));

% 输出结果
fprintf('Z统计量: %.4f\n', z);
fprintf('P值: %.4f\n', p_value);
fprintf('在%.2f的显著性水平下:\n', alpha);
if p_value < alpha
    fprintf('拒绝原假设,两个样本的比例有显著差异\n');
else
    fprintf('不能拒绝原假设,两个样本的比例无显著差异\n');
end

end
```

使用示例:

```matlab
% 例如,样本1中100个中有60个具有某特征,样本2中150个中有80个具有某特征
[z, p] = two_proportion_z_test(60, 100, 80, 150);
```

### Python实现

#### **单样本比例检验**

```javascript
# 检验样本合格率与0.38是否有差异
import numpy as np
from statsmodels.stats.proportion import proportions_ztest

counts=200; nobs=500; value=0.38

# 计算z检验统计量及p值
proportions_ztest(counts, nobs, value)
```

#### **双样本比例差异检验**

```javascript
# 两样本合格率是否有差异
import numpy as np
from statsmodels.stats.proportion import proportions_ztest

count1=200; nobs1=500
count2=150; nobs2=500

counts=np.array([count1,count2])
nobs=np.array([nobs1,nobs2])

# 计算z检验统计量及p值
proportions_ztest(counts, nobs)
```

### R

在R中，也可以使用内置函数进行这些检验：

* 对于单样本比例检验，可以使用 `prop.test()`​ 函数。
* 对于两个比例的差异检验，也可以使用 `prop.test()`​ 函数，只需提供两个样本的数据。

例如：

```r
r# 单样本比例检验
prop.test(60, 100, p = 0.5)

# 两个比例的差异检验
prop.test(c(60, 80), c(100, 150))
```

这些内置函数提供了更多的统计信息，如置信区间等，可能在某些情况下更为有用。
