---
title: 用 Matlab 绘制钙成像热图，并使用kmeans聚类
date: '2023-10-27 21:47:18'
updated: '2023-11-01 14:02:16'
tags:
  - Matlab
categories:
  - 技术博客
comments: true
toc: true
---



得逐渐学习怎么分析实验数据了呢

## 用 Matlab 绘制钙成像热图，并使用kmeans聚类

总结下几个难点

1. kmeans每次聚类效果不一样，发现可以通过设置start解决
2. 聚类完且绘制完热图如何显示神经元所属的标签，找到了slandarer大佬写的SClusterBlock函数，可以指定分组bar的位置，还能返回分组bar每个类别的中心位置方便加上文字标签
3. 我想要自由移动分组bar和colorbar，但发现调到右边很容易就在figure上不显示了，思考了下发现，原来在Matlab中，figure就像一个画布，axes则是通过Position指定在画布上画的位置，所有axes加起来，宽度不能超过1，高度不能超过1，否则就会有图像可能超出找不到。更简单的方式是先绘图，然后在figure窗口更改axes位置，生成代码。领悟到这点，以后就可以通过组合axes，更自由绘图了呢

关于钙荧光信号的聚类，最简单粗暴的就是kmeans了吧，但看到有文章用回归模型来聚类，不太懂，了解下

​![clusterpng](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311011402328.png)​

​![cluster2](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311011402954.png)

​![cluster](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311011402280.png)​​

```matlab
% 生成随机的神经元钙信号数据
data = readtable('suite2p_ROI_data_added_columns.csv','ReadVariableNames',true) % csv有header
cells = data(data.is_cell == 1,:)
cells_activity = cells(:, 2:1200)



% 使用k-means算法进行聚类
numClusters = 5;  % 聚类数量
data_t  = table2array(cells_activity);
[idx, centroids] = kmeans(data_t, numClusters,'Start', ones(5,1199));

class_name = string(1:numClusters);

[sortedResult, sortedIdx] = sort(idx);

sortedNeuronData = data_t(sortedIdx, :);


% 可视化聚类结果
fig=figure('Position',[100,100,800,800]);
axMain=axes('Parent',fig);
axMain.Position=[0.06,.1,.80,.80];
P=axMain.Position;
imagesc(axMain,sortedNeuronData);
axMain.YAxisLocation='left'; 
colormap(sky);
cb = colorbar('Location','eastoutside');
set(cb,"Position",cb.Position+[0.12,0,0,-0.6]);
xlabel('Frame');
ylabel('Neurons');
title('calcium imaging heatmap');

axBlockL=axes('Parent',fig);
axBlockL.Position=[0.86,P(2),P(3)/20,P(4)];
[X,Y]=SClusterBlock(sortedResult,'Orientation','left','Parent',axBlockL);
for i=1:length(X)
    text(axBlockL,X(i),Y(i),class_name(i),'FontSize',17,'HorizontalAlignment','center','FontName','Cambria')
end

```

## 根据聚类效果画每个cluster的平均图

```matlab
% 绘制每个cluster 钙信号平均图
ColorList=...
    [0.5529    0.8275    0.7804
    1.00 0.07 0.65
    0.7451    0.7294    0.8549
    0.9843    0.5020    0.4471
    0.5020    0.6941    0.8275
    0.9922    0.7059    0.3843
    0.7020    0.8706    0.4118
    0.9882    0.8039    0.8980
    0.8510    0.8510    0.8510
    0.7373    0.5020    0.7412
    0.8000    0.9216    0.7725
    1.0000    0.9294    0.4353];

fig_signal = figure();
ax_signal = axes('Parent',fig_signal);
hold(ax_signal,"on");
for i_cluster = 1:numClusters
    % find indeces of traces where cluster label equals to Ki
    i_signal = data_t(labels == i_cluster,:);
    % calculate average activity trace for cluster Ki
    md  = mean(i_signal , 1);
    s = std(i_signal,1) 
    % ！注意，这里进行了标准化,方便看每类神经元的活动normalize so that each trace is between 0 and 1
    md= rescale(md)

  
    % plot
    xs = 1:length(md);

    %fill([xs fliplr(xs)], [md+i_cluster-1-s fliplr(md+i_cluster-1+s)],[0.2,0.2,0.2],"FaceAlpha",0.15,'EdgeColor','none');
    plot(xs,md+i_cluster-1,'Color',ColorList(i_cluster,:),'LineWidth',1.5)
end

ax_signal.YTick=[];
ax_signal.YLim=[0,numClusters];
title('Average activity of each cluster');
xlabel("Frame");
for i_cluster = 1:numClusters
    text(-46.5, i_cluster-0.5, ['c',num2str(i_cluster)]);
end
```

‍

​![average](https://raw.githubusercontent.com/Achuan-2/PicBed/pic/assets/202311011402172.png)​

## Ref

* [First steps for presentation and analysis of calcium imaging data - FocalPlane (biologists.com)](https://focalplane.biologists.com/2022/09/06/first-steps-for-presentation-and-analysis-of-calcium-imaging-data/)

‍
