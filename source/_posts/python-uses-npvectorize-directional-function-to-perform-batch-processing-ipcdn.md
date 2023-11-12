---
title: Python 使用 np.vectorize 向量化函数，进行批量处理
date: '2023-11-07 17:34:25'
updated: '2023-11-12 18:31:33'
comments: true
toc: true
except: >-
  通常情况下，NumPy
  能够直接对数组执行元素级操作，这就是所谓的"向量化"操作。但有时候，如果你有一个在标量上定义的函数，你可能想要将其应用到整个数组上，而不是对数组中的每个元素进行循环操作。`np.vectorize`
  函数允许你在 NumPy 数组上以向量化的方式应用一个普通的 Python 函数。这使得你可以用一种更简洁和有效的方式处理整个数组，而不需要显式地编写循环。
tag: Python
categories: 技术博客
---



> 通常情况下，NumPy 能够直接对数组执行元素级操作，这就是所谓的"向量化"操作。但有时候，如果你有一个在标量上定义的函数，你可能想要将其应用到整个数组上，而不是对数组中的每个元素进行循环操作。​`np.vectorize`​​ 函数允许你在 NumPy 数组上以向量化的方式应用一个普通的 Python 函数。这使得你可以用一种更简洁和有效的方式处理整个数组，而不需要显式地编写循环。

## 需求

我需要记录图像上 roi 位置，为了让 roi 能够重叠，我选择用 numpy 创建一个二维字符串数组，每个 roi 用编号来表示，roi 所在位置就会填入对应编号，如果 roi 位置存在重叠，则用逗号隔开。

具体示例如下

```python
import numpy as np

matrix = np.zeros((3, 3), dtype=object)


matrix[:,:] ='1'
matrix[1:3,1:3] ='2,3'
matrix[1,1] ='1,2'

print(matrix)
```

> [[['1' '1' '1']
> ['1' '1,2' '2,3']
> ['1' '2,3' '2,3']]

> ℹ numpy创建字符串矩阵最好用object，不要用str、U3、U5这种，否则只会固定字符串长度，一旦超过就会被截取，用object可能比str占用内存小，运行速度快！
>
> * [numpy 数组的字符串元素类型和内存分配，引发的字符串长度问题](https://zhuanlan.zhihu.com/p/556852726)
> * [python - What does dtype=object mean while creating a numpy array? - Stack Overflow](https://stackoverflow.com/questions/29877508/what-does-dtype-object-mean-while-creating-a-numpy-array)

## 问题

如何使用 Python 代码，能够提取指定 ROI 的位置呢，这样就可以提取单个 roi 的 mask 进行后续处理了

## 解决

使用 `np.vectorize`​ 可以向量化函数，使函数能对每个元素执行，并返回值。

所以就可以这样写：

```python
def contains_value(cell, value):
    return value in cell.split(',')

# 将函数转换为能够处理numpy数组的函数
contains_value_vectorized = np.vectorize(contains_value)

# 应用函数到整个矩阵上，查找'1'
result_1 = contains_value_vectorized(matrix, '1')

# 应用函数到整个矩阵上，查找'2'
result_2 = contains_value_vectorized(matrix, '2')


result_3 = contains_value_vectorized(matrix, '3')

print(result_1)
print(result_2)
print(result_3)
```

> [[ True  True  True]
> [ True  True False]
> [ True False False]]
>
> [[False False False]
> [False  True  True]
> [False  True  True]]
>
> [[False False False]
> [False False  True]
> [False  True  True]]
