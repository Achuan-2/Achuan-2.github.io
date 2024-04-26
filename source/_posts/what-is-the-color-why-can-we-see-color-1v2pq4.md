---
title: 颜色是什么？为什么我们能看到颜色？
date: '2023-11-19 10:33:06'
updated: '2023-11-19 10:33:08'
excerpt: 你看到的颜色是物体还是物体反射的光，为什么相机仅凭光就可以记录图像，光带有信息吗？
tags:
  - 摄影
  - 成像原理
categories:
  - 光学笔记
permalink: /post/what-is-the-color-why-can-we-see-color-1v2pq4.html
comments: true
toc: true
abbrlink: bbfb0abc
---



你看到的颜色是物体还是物体反射的光，为什么相机仅凭光就可以记录图像，光带有信息吗？

牛顿在思考为什么物体具有不同颜色这个问题上，通过棱镜实验将白光分解为七种颜色的光，解释是<span style="font-weight: bold;" data-type="strong">因为物体会反射白光中的不同颜色的光，我们看到的一切都是光</span>。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311191033475.png "光波会色散成一组可观察到的电磁波谱")​

那<span style="font-weight: bold;" data-type="strong">光是什么，光为什么具有颜色</span>？麦克斯韦通过麦克斯韦方程推导发现光和电磁波速度相同，认为<span style="font-weight: bold;" data-type="strong">光是一种电磁波，电磁波是电磁辐射能量在空间的传递现象，所以不同颜色是不同的电磁辐射</span>：当波长为 650nm 的电磁波射入你的眼睛，那么你就看到了红色，当波长为 570nm 的电磁波射入你的眼睛，那么你就看到了黄色。人肉眼可见的电磁波辐射波长范围是380nm-750nm。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311191033495.png "光是一种肉眼可以看见（接受）的电磁波（可见光谱）")​

可一个白炽灯可以发射的光谱范围完全覆盖了人肉眼可见的波长区域，并且灯泡发射的黑色光能量最高，那为什么我们看到的灯泡不是黑色的？这是因为，虽然白炽灯发射的辐射能量在可见光范围的波长都存在，但眼睛对于不同波长的光敏感不同，即使灯丝发射的辐射在可见范围内是750nm的黑色光波能量最高，但黑色的敏感度很低，所以在敏感度的加权下就显得不明显——所以实际上<span style="font-weight: bold;" data-type="strong">颜色是按照人类对光的敏感度加权之后的电磁波谱</span>。

‍

眼睛中有两种与视觉有关的细胞，<span style="font-weight: bold;" data-type="strong">视杆细胞和视锥细胞</span>，其中视杆细胞和黑暗低光照有关，视锥细胞与色彩感觉有关。视锥细胞则有3种，这3种细胞对不同波长的光的响应程度是不一样的，从而被命名为S、M、L，方便对应短、中、长波长敏感的视锥细胞。同一种锥体对不同波长的光敏感不同，所以颜色实际上可以用L、M、S的各自敏感度来表示（L，M，S），也就是说，在数学上，我们的眼睛将颜色从光谱无限维度的空间降低到三维空间，即三种锥细胞曲线下的面积数值。光是一种电磁波，颜色是人能感觉到的波谱，这显然是复杂的。那么从现在开始，从眼睛感觉出发，从降维之后看到的世界开始，颜色是简单的，视锥细胞可以把任何光谱颜色变成三个数字组成的数组，这就是描述颜色方法——LMS色彩空间。这也就是说， <span style="font-weight: bold;" data-type="strong">「颜色」，是生物体对光波的解读。宇宙本身是没有「颜色」这种概念的，宇宙只有不同波长的光波，仅此而已。</span>

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311191033645.png "三种细胞对光波的敏感度")​

为了方便在屏幕上重现看到的颜色，人们往往使用RGB三维颜色空间来表示颜色，红、绿、蓝是光三原色，之所以三基色能够模拟多种色彩<span style="font-weight: bold;" data-type="strong">并不是物理原因，而是生理原因——</span> 是因为人眼的三种视锥细胞分别对红，黄绿，蓝紫的光线特别敏感，通过搭配三种固定波长的光我们可以合成其他颜色的光（注意，三种细胞并不是分别对红色、绿色和蓝色最敏感）。需要注意的是，<span style="font-weight: bold;" data-type="strong">这种三原色组成的颜色只对「人」有效。由于其他的动物锥形感光细胞与人类不一致，因此表达效果会有偏差。</span> 此外，仅靠RGB三种波长是无法匹配出435nm到540nm之间的任何光的，比如纯青色是无法在屏幕中展示的，也就是看到的纯青色只是一种近似的替代而已，事实上没有显示设备能完全还上面所有的自然色域。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311191033371.png "屏幕的色域")​

​![image](http://127.0.0.1:6806/assets/image-20230609015558-i3k7nks.png "RGB")​

而对于美术专业和印刷行业的人，他们更习惯用CMYK表示颜色，即利用色料的三原色混色原理（青色+品红+黄色），加上黑色油墨来表示颜色。RGB是「<span style="font-weight: bold;" data-type="strong">叠加型原色</span>」，而CMYK是「<span style="font-weight: bold;" data-type="strong">消减型原色</span>」，这个模型的原理是通过仿真自然界实际上是通过反射光波长让我们看到颜色的。红色的纸为什么是红色的？因为它把其他颜色的波长吸收了，只反射了红色的波长。白色纸是因为没有吸收任何波长，全部反射，最终所有光波进入你的眼睛，看到了白色；黑色纸吸收了所有波长，没有反射，因此没有任何光波进入你的眼睛，看到的是黑色 <span style="font-weight: bold;" data-type="strong">。</span> 假设要配出黄颜色，对于屏幕来说，红光+绿光就可以了，如果要打印出来呢 <span style="font-weight: bold;" data-type="strong"> ？</span> 如果直接用红绿的墨水去配色可以吗？ 红墨水之所以是红的是因为它吸收了蓝和绿波长，绿墨会吸收红蓝反射绿，两者混在一起，红墨的红会被绿墨吸收一部分，绿墨的绿会被红墨吸收一部分，难以印出明亮的颜色。那么我们换一种思路，使得每种油墨吸收一种反射两种呢？这样就得到：只吸收红反射蓝绿的油墨就是青色（C），只吸收绿反射红蓝的就是品红（M），只吸收蓝反射红绿的就是黄色（Y）。这时，如果把青墨和品红墨相加，蓝色都不被两种墨吸收所以反射最强。这样通过CMY不同的组合就能组合出其他颜色， 而黑色墨是负责把亮的颜色调暗的。

​![image](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311191033832.png "CMKY")​

## Ref

* [颜色是什么——你看到的颜色是物体还是物体反射的光？_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1pF411s7E3/?spm_id_from=333.337.search-card.all.click&vd_source=b4a1fcb6dce305e26d8d16d9cbb71304)
