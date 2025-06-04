---
created: '2023-11-01 14:13:34'
updated: '2023-11-01 14:54:29'
title: matlab 如何调用 python 代码
permalink: siyuan://blocks/20231101141334-phd1gv6
categories: []
---





![PixPin_2025-05-24_10-54-13](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-05-24_10-54-13-20250524105422-jx93k64.png)

在数据分析、数据建模、科学计算的领域，Matlab 和 Python 一直是两大热门选择。不少人在两者之间犹豫不决，甚至争论不休：到底哪个更强大？哪个更适合自己的需求？

但是小孩子才做选择！其实，Matlab 完全可以直接调用 Python，让你鱼和熊掌兼得！既能保留 Matlab 在界面交互上的优势，又能调用 Python 丰富的第三方库来处理数据。

比如Matlab在科研绘图上有优势，可以把绘图文件保存为fig格式，后面需要修改样式不需要重跑代码，可以打开fig文件，直接修改配色、字体、宽高等样式，所以用代码来进行科研绘图我会选择Matlab而不是Python（此外.mat保存数据也很舒服，还能预览每个mat有什么，.npy就没那么方便）。但是一些最新的数据降维算法只有python有，而matlab没有（比如matlab就没有官方的umap降维方法，第三方实现又说不准靠不靠谱），这时候其实不用纠结，要不要用python绘图。matlab可以调用python的这些库，直接出结果，之后再用matlab来画图。

再比如，matlab开发一个GUI界面非常傻瓜，我用matlab快速开发了一个连接硬件的app，但是后面想加一个功能，可以调用ai模型对采集的数据进行识别分类，这个模型python有现成的库和模型，我懒得用matlab重写，也懒得折腾matlab直接调用Pytorch模型，因为还要自己写处理代码才能得到想要的结果（这个话题后面我会分享），就可以直接调用python现成的调用模型出结果的代码，直接得到数据。

除此之外，

- matlab可以编译C/C++代码为mex文件来直接调用，以及调用动态库.dll
- 可以调用java包，比如matlab可以通过调用java包ImarisLib.jar来操控imaris软件（见[为了统一imaris 3d重建后的视角，我写了一个插件））](https://mp.weixin.qq.com/s/E-tS6fNbyycsMIznmGi7ug)
- 可以调用COM接口：许多企业软件（如 Microsoft Excel、Word、Outlook）和其他第三方工具通过 COM 接口暴露功能，MATLAB 可以通过 COM 自动化与这些软件交互，实现数据交换、自动化操作等。

  一个例子：Matlab如何通过 COM 接口与 Excel 交互，将数据写入excel表，并直接在excel创建图表展示

  ```matlab
  % 创建 Excel COM 对象
  excel = actxserver('Excel.Application');
  excel.Visible = true; % 使 Excel 窗口可见，便于观察

  % 创建一个新的工作簿
  workbook = excel.Workbooks.Add;

  % 选择第一个工作表
  worksheet = workbook.Worksheets.Item(1);

  % 假设有一些数据需要写入 Excel
  data = rand(5, 3); % 随机生成一个 5x3 的矩阵作为示例数据
  columnHeaders = {'Column1', 'Column2', 'Column3'};

  % 写入列标题
  for col = 1:length(columnHeaders)
      colLetter = char('A' + col - 1);  % 转换数字为列字母 (A, B, C, ...)
      worksheet.Range([colLetter '1']).Value = columnHeaders{col};
  end

  % 写入数据到 Excel
  worksheet.Range('A2:C6').Value = data;

  % 创建一个简单的图表
  chart = worksheet.ChartObjects.Add(300, 20, 400, 300);
  chart.Chart.SetSourceData(worksheet.Range('A1:C6'));



  % 取消连接
  delete(excel);

  ```

  ![PixPin_2025-05-24_11-18-00](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-05-24_11-18-00-20250524111803-yvsnnzg.png)

在胶水语言能力上，个人觉得Matlab是不比python差的。

好啦其他不多说了，下面详细介绍Matlab 如何调用 Python 代码

> 其实python也能调用matlab的，比如VSCode的matlab插件就是用python的matlab engine实现一些功能的，但是对于数据分析方面，个人不太需要python调用matlab，就不展开讲了。

## Matlab 配置Python环境

### 使用pyenv来配置Matlab调用哪个python.exe

pyenv的官方文档：[pyenv](https://ww2.mathworks.cn/help/matlab/ref/matlab.pyclient.pythonenvironment.html)

我用的是conda，所以选择某个conda环境

```matlab
pyenv('Version', "C:\Users\Achuan-2\miniforge3\envs\MPM\python.exe",ExecutionMode = 'OutOfProcess')
```

> ⚠️这里需要注意Python版本是否符合Matlab需求
>
> matlab 2023b只支持python 3.9+
>
> 其他Matlab版本对Python的版本要求见：[Versions  of Python Compatible with MATLAB Products by Release - MATLAB &amp; Simulink (mathworks.cn)](https://ww2.mathworks.cn/support/requirements/python-compatibility.html)

### 测试python环境是否配置好

运行一个简单的 Python 命令以验证配置是否正确：

```matlab
pyrun('print("Hello from Python!")')
```

### 如何切换python环境

直接切换，无需重新启动 MATLAB

```matlab
terminate(pyenv)
pyenv('Version', "C:\Users\Achuan-2\miniforge3\envs\MPM\python.exe",ExecutionMode = 'OutOfProcess')
```

## Matlab 运行python代码

### pyrun：运行python语句

> pyrun一般没有太多实际使用价值，建议主要用pyrunfile

文档：[pryrun](https://ww2.mathworks.cn/help/matlab/ref/pyrun.html)

语法：`outvars = pyrun(code,outputs,pyName=pyValue)`​

输入参数

- outputs 指定输出结果
- pyName = pyValue，指定code里的变量值

#### 语法示例

##### 执行多行 Python 语句

```matlab
pyrun(["greeting = 'hello'", "print(greeting)"])
```

相当于python代码

```python
greeting = "hello"
print(greeting)
```

##### 从 Python 列表中创建 MATLAB 变量

```matlab
mllist = pyrun("days = ['Monday','Tuesday','Wednesday','Thursday','Friday']","days")
```

```matlab
mllist = 

  Python list with values:

    ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']

    Use string, double or cell function to convert to a MATLAB array.

```

##### 将参数传递给 Python 运算符

此示例使用指定的输入值在 Python 解释器中执行语句 `a = b*c`​。

```matlab
pyrun("a = b*c", b = 5, c = 10)
```

变量 `a`​、`b`​ 和 `c`​ 仅存在于 Python 命名空间中。不过，`pyrun`​再一次调用，这些变量依然是可以使用的。

```matlab
md = pyrun("d = a+c", "d")
```

```matlab
md = 60
```

### pyrunfile：运行python脚本文件

文档：[pryrun](https://ww2.mathworks.cn/help/matlab/ref/pyrun.html)

​`pyrunfile`​ 是 MATLAB 提供的一个函数，用于直接运行 Python 脚本文件（`.py`​ 文件）。它允许 MATLAB 用户在 MATLAB 环境中调用 Python 代码，并获取 Python 脚本的输出结果。

#### 语法简介

**语法**：

- ​`pyrunfile(file)`​：直接运行某个python脚本
- ​`pyrunfile(file input)`​：运行需要命令行参数的python脚本
- ​`outvars = pyrunfile(file,outputs)`​：运行需要返回值的python脚本
- ​`outvars = pyrunfile(file,outputs,pyName=pyValue)`​：将 MATLAB 参数传递给 Python 脚本，这样不需要在python硬编码值

参数解释

- ​`file`​：Python 脚本文件的路径（可以是相对路径或绝对路径，文件扩展名 .py 可省略）。
- ​`input`​：脚本需要的命令行参数。
- ​`outputs`​：指定要从 Python 脚本中返回的变量名，可以是一个字符串（单个变量）或字符串数组（多个变量）
- ​`outvars`​：返回的变量值。如果返回单个变量，直接存储在 `outvars`​ 中；如果返回多个变量，`outvars`​ 是一个结构体，字段名对应变量名。
- ​`pyName=pyValue`​：传递给 Python 脚本的变量名和值对，支持多个名称-值对。。

#### 四种语法例子

##### 直接执行 Python 脚本文件

- 使用以下语句创建 Python 脚本 hello.py：

  ```python
  greeting = "hello"
  print(greeting)
  ```
- 在 MATLAB 命令行中显示输出。

  ```matlab
  pyrunfile("hello.py")
  ```

  ```matlab
  hello
  ```

##### 将命令行参数传递给 Python 脚本

创建一个 Python 脚本并传递一个字符串。

使用以下语句创建 `greeting.py`​：

```python
import sys
greeting = sys.argv[1]
print(greeting)
```

向该脚本传递一个字符串并显示输出。

```matlab
pyrunfile("greeting.py 'hello world'")
```

```matlab
hello world
```

##### 将 Python 变量返回给 MATLAB

从 MATLAB 运行一个 Python 脚本，并将该脚本生成的变量返回给 MATLAB。

创建 Python 脚本 `makeList.py`​：

```python
l = ['A', 'new', 'list']
```

运行该脚本以创建列表，并将其结果以 `data`​ 变量的形式返回给 MATLAB。

```
data = pyrunfile("makeList.py", "l")
```

```matlab
data = 
  Python list with no properties.

    ['A', 'new', 'list']
```

##### 将 MATLAB 参数传递给 Python 脚本

调用可以接受输入参数的 Python 脚本。

创建 Python 脚本 `addac.py`​。该脚本接受输入参数 `x`​ 和 `y`​，并返回变量 `z`​。

```python
def add(a,c):
    b = a+c
    return b

z = add(x,y)
```

传递 `x`​ 和 `y`​ 的值。以 MATLAB 变量 `res`​ 形式返回变量 `z`​。

```matlab
res = pyrunfile("addac.py","z",x=3,y=2)
```

```matlab
res = 5
```

#### 我的使用例子：调用python的umap库对数据降维，然后保存为excel，方便matlab再读取

新建`run_umap.py`​

```python
from sklearn.datasets import load_digits
import matplotlib.pyplot as plt
import umap
import pandas as pd
import numpy as np

# sklearn内置的Digits Data数字手写识别数据库加载
digits = load_digits()
fig, ax_array = plt.subplots(20, 20)
axes = ax_array.flatten()
for i, ax in enumerate(axes):
    ax.imshow(digits.images[i], cmap='gray_r')
plt.setp(axes, xticks=[], yticks=[], frame_on=False)
plt.tight_layout(h_pad=0.5, w_pad=0.01)
plt.show()

# 使用umap降至2维并绘制散点图
reducer = umap.UMAP(random_state=42)
embedding = reducer.fit_transform(digits.data)
print("Embedding shape:", embedding.shape)

# 将embedding矩阵和对应的标签保存到DataFrame
df = pd.DataFrame({
    'UMAP_1': embedding[:, 0],
    'UMAP_2': embedding[:, 1],
    'Target': digits.target
})

# 保存到Excel文件
output_file = 'digits_umap_embedding.xlsx'
df.to_excel(output_file, index=False)
print(f"Embedding data has been saved to {output_file}")

# 绘制散点图
plt.scatter(embedding[:, 0], embedding[:, 1], c=digits.target, cmap='Spectral', s=5)
plt.gca().set_aspect('equal', 'datalim')
plt.colorbar(boundaries=np.arange(11)-0.5).set_ticks(np.arange(10))
plt.title('UMAP projection of the Digits dataset')
plt.show()

```

matlab运行此代码

```matlab
pyrunfile("run_map.py")
```

加载的手写数据集

![PixPin_2025-05-24_00-02-29](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-05-24_00-02-29-20250524000231-iwlpon7.png)

umap降维结果

![PixPin_2025-05-24_00-01-22](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-05-24_00-01-22-20250524000126-l9wafb4.png)

保存的excel

![PixPin_2025-05-24_00-02-01](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-05-24_00-02-01-20250524000208-unq0cip.png)

## Matlab 调用Python模块

### 调用 py内置模块

调用方式`py.模块.函数()`​

例子：创建python的字典

```matlab
py_dict = py.dict(key1=1, key2=2);
py_dict{'key1'} = 2
```

```matlab
py_dict = 

  Python dict with no properties.

    {'key1': 2.0, 'key2': 2.0}
```

例子，

利用python的os.path.basename根据文件路径直接获取文件名

```matlab
filePath = 'C:\Users\John\Documents\report.txt';
fileName = py.os.path.basename(filePath); % report.txt
fileName = string(fileName); % 转化为matlab的string类型，便于后面操作
```

在matlab里，也有import函数，可以简化操作，直接用basename就可以调用了

```matlab
import py.os.path.basename
filePath = 'C:\Users\John\Documents\report.txt';
fileName = basename(filePath);
fileName = string(fileName); 
```

### 调用自定义模块

**调用用户定义的 Python 模块官方文档**：[https://ww2.mathworks.cn/help/matlab/matlab_external/call-user-defined-custom-module.html](https://ww2.mathworks.cn/help/matlab/matlab_external/call-user-defined-custom-module.html)

如果模块在当前文件夹，直接运行

```matlab
mymodule= py.importlib.import_module('mymodule');
```

如果模块不在当前文件夹，将模块所在的文件夹添加到 Python 搜索路径。

```matlab
if count(py.sys.path,'mymodule_path') == 0
    insert(py.sys.path,int32(0),'mymodule_path');
end
```

注意：**自定义模块修改代码后需要重新加载**

重载代码

```matlab
clear classes
mymodule= py.importlib.import_module('mymodule');
py.importlib.reload(mymodule);
```

#### 一个简单例子

创建add_numbers.py

```python
def add_numbers(num1, num2):
    """
    这是一个计算两个数字之和的函数
    
    参数:
        num1 (int/float): 第一个数字
        num2 (int/float): 第二个数字
        
    返回:
        int/float: 两个数字的和
    """
    result = num1 + num2
    return result

```

导入函数

```matlab
add_numbers= py.importlib.import_module('add_numbers');
```

直接运行函数

```matlab
py.add_numbers.add_numbers(1,2)
```

## matlab和python的数据存储差异

### **MATLAB 与 Python 数据类型映射**

MATLAB 和 Python 的数据类型并不是一一对应的，但 MATLAB 提供了一个默认的映射机制来自动转换数据类型。以下是常见的 MATLAB 数据类型与 Python 数据类型的对应关系：

|MATLAB 数据类型|Python 数据类型|说明|
| --------------------| -----------------| ----------------------------------------------------------|
|​`double`​（标量或数组）|​`float`​ 或 `numpy.ndarray`​|MATLAB 的双精度浮点数映射为 Python 的浮点数或 NumPy 数组|
|​`single`​（标量或数组）|​`float`​ 或 `numpy.ndarray`​|单精度浮点数类似 double 的处理|
|​`int8`​, `int16`​, `int32`​, `int64`​|​`int`​ 或 `numpy.ndarray`​|整数类型映射为 Python 整数或 NumPy 数组|
|​`uint8`​, `uint16`​, `uint32`​, `uint64`​|​`int`​ 或 `numpy.ndarray`​|无符号整数类似有符号整数的处理|
|​`logical`​（布尔值）|​`bool`​ 或 `numpy.ndarray`​|布尔值映射为 Python 的布尔值或 NumPy 数组|
|​`char`​（字符数组）|​`str`​|MATLAB 字符串映射为 Python 字符串|
|​`string`​（字符串）|​`str`​|MATLAB 字符串映射为 Python 字符串|
|​`cell`​（单元数组）|​`list`​|MATLAB 单元数组映射为 Python 列表|
|​`struct`​（结构体）|​`dict`​|MATLAB 结构体映射为 Python 字典|
|​`table`​|​`pandas.DataFrame`​|MATLAB 表格映射为 Pandas 数据框（需安装 Pandas）|

**注意**：

- 如果 MATLAB 数组是多维数组，通常会转换为 `numpy.ndarray`​。
- 对于复杂数据类型（如嵌套结构体或单元数组），转换可能会受到限制，需要手动处理。

### 图像数据转ndarray

图像数据比较特殊，需要单独转换

把matlab读入的图像数据转为python的ndarray数据

数据转化代码

```matlab
function result = mat2nparray(matarray)
    %mat2nparray Convert a Matlab array into an nparray
    %   Convert an n-dimensional Matlab array into an equivalent nparray  
    data_size=size(matarray);
    if length(data_size)==1
        % 1-D vectors are trivial
        result=py.numpy.array(matarray);
    elseif length(data_size)==2
        % A transpose operation is required either in Matlab, or in Python due
        % to the difference between row major and column major ordering
        transpose=matarray';
        % Pass the array to Python as a vector, and then reshape to the correct
        % size
        result=py.numpy.reshape(transpose(:)', int32(data_size));
    else
        % For an n-dimensional array, transpose the first two dimensions to
        % sort the storage ordering issue
        transpose=permute(matarray,length(data_size):-1:1);
        % Pass it to python, and then reshape to the python style of matrix
        % sizing
        result=py.numpy.reshape(transpose(:)', int32(fliplr(size(transpose))));
    end
end

```
