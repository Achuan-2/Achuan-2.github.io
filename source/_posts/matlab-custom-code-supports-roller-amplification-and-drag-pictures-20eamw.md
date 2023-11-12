---
title: Matlab 自定义代码支持滚轮放大和拖动图片
date: '2023-11-12 15:21:13'
updated: '2023-11-12 18:20:43'
comments: true
toc: true
tag: Matlab
categories: 技术博客
---



Matlab 虽然自带的imshow也支持鼠标滚轮放大缩小，鼠标左键拖动放大的图片调整视野，但是一旦把menubar给关了，就丢失了zoom和pan的功能，最离谱的是——zoom和pan还只能开一个，开了zoom就不能开pan。所以打算自己撸一个同时支持鼠标滚轮放大图片和左键拖动图片的功能。

## 实现方案

具体实现功能

* 鼠标滚轮放大/缩小图片
* 鼠标左键长按拖拽图片
* 鼠标左键双击恢复图片

### 鼠标滚轮放大图片

比较简单，监听Figure的鼠标滚轮事件WindowScrollWheelFcn，根据滚动值event.VerticalScrollCount来判断滚动方向进行放大或缩小

```matlab
function im_zoom(self,~,event)

    currentPosition = self.ax.CurrentPoint;
    x = currentPosition(1,1);
    y = currentPosition(1,2);
    if x >= self.ax.XLim(1) && x <= self.ax.XLim(2) && y >= self.ax.YLim(1) && y <= self.ax.YLim(2)
        if event.VerticalScrollCount > 0
            scale = 1.1;
        else
            scale = 1/1.1;
        end
        xlim_range = get(self.ax, 'xlim');
        ylim_range = get(self.ax, 'ylim');
        % 进行放大缩小
        set(self.fig,'Pointer','crosshair'); % change mouse point
        self.ax.XLim = (xlim_range - x) * scale + x; % 能保证鼠标滚动时，即使放大缩小，鼠标所在的位置还在原来的位置，保持不变
        self.ax.YLim = (ylim_range - y) * scale + y;
    end
end
```

### 鼠标拖拽图片

会复杂一点，

1. 鼠标左键点击，ax.UserData.status设置为'axes_paning'（默认情况为'idle'），并记录当前鼠标位置

    ```matlab
    function im_pan_start(self)
        self.ax.UserData.status = 'axes_paning';
        self.ax.UserData.previous_point = self.ax.CurrentPoint;
        set(self.fig,'Pointer','fleur'); % change mouse point
    end
    ```
2. 监听鼠标移动事件，根据鼠标移动的位置，来更新ax的XLim和YLim，实现平移效果为了只有鼠标按住左键才能拖动，只有ax.UserData.status为'axes_paning'时，才进行平移。

    ```matlab
    function fig_motion(self,~,~)
        currentPosition = self.ax.CurrentPoint;
        x = currentPosition(1,1);
        y = currentPosition(1,2);
        if x >= self.ax.XLim(1) && x <= self.ax.XLim(2) && y >= self.ax.YLim(1) && y <= self.ax.YLim(2)
            switch self.ax.UserData.status
                case  "axes_paning"
                    self.im_panning()
                otherwise
                    return
            end
        end
    end
    ```
3. 当鼠标左键抬起后，将ax.UserData.status设置为'idle'，使得fig_motion功能失效

    ```matlab
    function im_pan_stop(self)
        self.ax.UserData.status = 'idle';
        set(self.fig,'Pointer','arrow'); % recover mouse point
    end
    ```

### 鼠标左键双击恢复图片

* 载入图片时，记录ax原始的XLim和YLim

  ```matlab
  self.ax.XLim = self.ax.UserData.origin_xlim;
  self.ax.YLim = self.ax.UserData.origin_ylim;
  ```
* 左键双击时，恢复为原始的XLim和YLim

  ```matlab
  function fig_click(self,src,~)
      set(self.fig,'Pointer','arrow');
      switch src.SelectionType
          case 'open' % Double Click
              % Double Click to restore origin xlim and ylim
              self.im_zoom_restore()
      end
  end

  function im_zoom_restore(self)
      self.ax.XLim = self.ax.UserData.origin_xlim;
      self.ax.YLim = self.ax.UserData.origin_ylim;
  end
  ```

## 全部代码

```matlab
classdef FigureManualZoom < handle
    properties
        fig;
        ax;
    end


    methods
        % Class Constructor
        function self = FigureManualZoom()
            self.fig = figure("Name",'Test',"NumberTitle","off",'Menubar','none','Position',[10,10,408,408]);
            self.set_fig_center(self.fig);
            self.fig.WindowButtonDownFcn = @self.fig_click;
            self.fig.WindowScrollWheelFcn = @self.im_zoom;
            self.fig.WindowButtonMotionFcn = @self.fig_motion;
            self.fig.WindowButtonUpFcn = @self.fig_click_done;
            self.ax = axes('Parent',self.fig);
            im = imread("cellpose_test.tif");
            im_size = size(im);
            imshow(im,[],'parent',self.ax,'border','tight','initialmagnification','fit');
            self.ax.UserData.status = 'idle';
            self.ax.UserData.previous_point = [];
            self.ax.UserData.origin_xlim = [0 im_size(2)];
            self.ax.UserData.origin_ylim = [0 im_size(2)];
            self.ax.XLim = self.ax.UserData.origin_xlim;
            self.ax.YLim = self.ax.UserData.origin_ylim;
        end
    end
  
    % Custom Methods
    methods
        % Put fig in the center of current screen
        function set_fig_center(~, fig)
            %SET_FIG_CENTER: 

            % Get the screen size
            screenSize = get(0, 'ScreenSize');

            % Get the size of the Figure
            figSize = get(fig, 'Position');

            % Calculate the position for centering the Figure
            centeredPosition = [(screenSize(3) - figSize(3)) / 2, (screenSize(4) - figSize(4)) / 2, figSize(3:4)];

            % Set the position of the Figure
            set(fig, 'Position', centeredPosition);
        end
      
        % Listening for mouse click events
        function fig_click(self,src,~)
            set(self.fig,'Pointer','arrow');
            switch src.SelectionType
                case 'normal' % Left Click
                    self.im_pan_start();
                case 'open' % Double Click
                    % Double Click to restore origin xlim and ylim
                    self.im_zoom_restore()
                case 'alt' % Ctrl + Left Click / Right Click
                    return
                case 'extend' % Shift + Left Click
                    return
                otherwise
                    return
            end
        end

        % Listening for mouse click completion events
        function fig_click_done(self,~,~)
            self.im_pan_stop();
        end

        % Listening for mouse movement events
        function fig_motion(self,~,~)
            currentPosition = self.ax.CurrentPoint;
            x = currentPosition(1,1);
            y = currentPosition(1,2);
            if x >= self.ax.XLim(1) && x <= self.ax.XLim(2) && y >= self.ax.YLim(1) && y <= self.ax.YLim(2)
                switch self.ax.UserData.status
                    case  "axes_paning"
                        self.im_panning()
                    otherwise
                        return
                end
            end
        end

        function im_zoom_restore(self)
            self.ax.XLim = self.ax.UserData.origin_xlim;
            self.ax.YLim = self.ax.UserData.origin_ylim;
        end
        function im_pan_start(self)
            self.ax.UserData.status = 'axes_paning';
            self.ax.UserData.previous_point = self.ax.CurrentPoint;
            set(self.fig,'Pointer','fleur'); % change mouse point
        end
        function im_pan_stop(self)
            self.ax.UserData.status = 'idle';
            set(self.fig,'Pointer','arrow'); % recover mouse point
        end

      
        % Drag the image with the left mouse button
        function im_panning(self)

            % get mouse position in UIaxes
            current_position = self.ax.CurrentPoint;

            % get current location (in pixels)
            % get current XY-limits
            xlim_range = get(self.ax, 'xlim');
            ylim_range = get(self.ax, 'ylim');
            % find change in position
            delta_points = current_position - self.ax.UserData.previous_point;

            % Adjust limits
            set(self.ax, 'Xlim', xlim_range - delta_points(1));
            set(self.ax, 'Ylim', ylim_range - delta_points(3));

            % save new position
            self.ax.UserData.previous_point = get(self.ax, 'CurrentPoint');
        end

        % Mouse wheel zooms in and out of images
        function im_zoom(self,~,event)

            currentPosition = self.ax.CurrentPoint;
            x = currentPosition(1,1);
            y = currentPosition(1,2);
            if x >= self.ax.XLim(1) && x <= self.ax.XLim(2) && y >= self.ax.YLim(1) && y <= self.ax.YLim(2)
                if event.VerticalScrollCount > 0
                    scale = 1.1;
                else
                    scale = 1/1.1;
                end
                xlim_range = get(self.ax, 'xlim');
                ylim_range = get(self.ax, 'ylim');
                % 进行放大缩小
                set(self.fig,'Pointer','crosshair'); % change mouse point
                self.ax.XLim = (xlim_range - x) * scale + x; % 能保证鼠标滚动时，即使放大缩小，鼠标所在的位置还在原来的位置，保持不变
                self.ax.YLim = (ylim_range - y) * scale + y;
            end
        end
    end
end
```

## Ref

* [danyalejandro/imgzoompan: A MatLab code add-on that provides mouse zoom &amp; pan functionality for 2D images. (github.com)](https://github.com/danyalejandro/imgzoompan)
