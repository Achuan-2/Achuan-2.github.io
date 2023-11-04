---
title: Matlab 有没有像 np.clip 一样的函数，限制数组的最大值和最小值
date: '2023-11-05 01:25:44'
updated: '2023-11-05 01:35:12'
excerpt: 其实用max和min叠加就可以实现，限制数组的最大值和最小值
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
---



其实用max和min叠加就可以实现，限制数组的最大值和最小值

```matlab
 y=min(max(x,x_min),x_max);
```

可以包装为函数

```matlab
function y = clip(x,x_min,x_max)
    arguments
        x
        x_min = min(x,[],'all')
        x_max = max(x,[],'all')
    end
    y=min(max(x,x_min),x_max);
end
```

调用看看

```matlab
>> x = reshape(1:9,3,3)'

x =

     1     2     3
     4     5     6
     7     8     9

>> clip(x,2,7)

ans = 3×3  
     2     2     3
     4     5     6
     7     7     7

```
