---
title: Matlab 后台异步执行函数
date: '2023-11-25 01:43:19'
updated: '2023-11-25 22:01:00'
permalink: /post/matlab-background-asynchronous-execution-function-z1zmis9.html
comments: true
tags:
  - Matlab
  - 编程
categories:
  - 其他笔记
toc: true
excerpt: >-
  当在 MATLAB 中运行普通代码时，必须等待该代码完成运行，然后才能运行其他代码。


  其实Matlab 目前的多线程编程已经优化的挺好的，看到有些文章使用 Timer 计时器函数曲线救国，以实现多任务后台同时运行，然而 Timer
  只是单线程定时执行函数，只是可以指定什么时候执行什么任务，当一个任务运行的时候依然是串行方式，并不是真正的异步，是依然会堵塞主线程的
abbrlink: f8409cde
---



当在 MATLAB 中运行普通代码时，必须等待该代码完成运行，然后才能运行其他代码。

其实Matlab 目前的多线程编程已经优化的挺好的，看到有些文章使用 Timer 计时器函数曲线救国，以实现多任务后台同时运行，然而 Timer 只是单线程定时执行函数，只是可以指定什么时候执行什么任务，当一个任务运行的时候依然是串行方式，并不是真正的异步，是依然会堵塞主线程的

现在2021b起就自带backgroundPool后台池，自动扩展线程，结合parfeval可以在后台异步执行函数，不干扰主线程。网上这方面资料貌似还比较少，但是真的好用。

> Matlab 文档：[后台处理 - MATLAB &amp; Simulink - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/background-processing.html?s_tid=CRUX_lftnav)

## parfeval 异步后台运行函数

* 文档：[parfeval](https://ww2.mathworks.cn/help/matlab/ref/parfeval.html)

  F = parfeval(backgroundPool,fcn,n,X1,...,Xm)  

  F = parfeval(fcn,n,X1,...,Xm)
* ​`parfeval`​​ 和 `parfevalOnAll`​​ 的区别

  * ​`parfeval`​​​​ 请求在并行池中的工作线程上异步执行。您可以使用 `cancel`​​​​ 取消执行。它只是把它发给任何一个worker。
  * 使用 `parfevalOnAll`​​​​ 在所有工作线程上执行一个函数，使用场景有限，一般用于删除、关闭所有worker的指定任务。
* ​`F = parfeval(fcn,n,X1,...,Xm)`​​​  和 `F = parfeval(backgroundPool,fcn,n,X1,...,Xm)`​​​，不加backgroundPool和加了有什么区别

  这语法是Matlab 2021b加的，不加pool就是自动开启pool，如果没有Parallel Computing Toolbox 就是按正常串行运行函数

  Starting in R2021b, you can now run [`parfeval`](https://ww2.mathworks.cn/help/parallel-computing/parallel.pool.parfeval.html)​​​ in serial with no pool. This behavior allows you to share parallel code that you write with users who do not have Parallel Computing Toolbox.

  When you use the syntax `parfeval(fcn,n,X1,...,Xm)`​​​, MATLAB tries to use an open parallel pool if you have Parallel Computing Toolbox. If a parallel pool is not open, MATLAB will create one if automatic pool creation is enabled.

  If parallel pool creation is disabled or if you do not have Parallel Computing Toolbox, the function is evaluated in serial. In previous releases, MATLAB threw an error instead.
* pareval 和 parfor

  * pareval的主要功能是后台异步运行函数，可以让耗时长的函数在后台慢慢跑；parfor主要是用于前台加快循环运算

    ```matlab
    % 普通单线程运行
    n = 200;
    A = 500;
    a = zeros(n);
    tic
    for i = 1:n
        a(i) = max(abs(eig(rand(A))));
    end
    toc % Elapsed time is 24.068519 seconds.

    % 并行计算
    delete(gcp('nocreate'))
    parpool('Threads')
    n = 200;
    A = 500;
    a = zeros(n);
    tic
    parfor i = 1:n
        a(i) = max(abs(eig(rand(A))));
    end
    toc % Elapsed time is 4.168100 seconds.
    ```

## backgroundPool 后台运行函数（支持多线程）

* backgroundPool 是基于线程的吗？能调用几个线程？

  * backgroundPool就是基于线程运行代码。线程数和计算机最大核心数有关系，如果没有Parallel Computing Toolbox，backgroundPo调用一个线程，如果有Parallel Computing Toolbox，backgroundPool能调用计算机的最大核心数。需要注意的是，后台的一个线程只能同时跑一个任务，任务数大于线程数就会堵塞。.[（Ref）](https://ww2.mathworks.cn/help/matlab/matlab_prog/asynchronous-functions.html#mw_6b0d4b53-ccf6-4df0-a900-96df2f505b14)
  * 获取backgroundPool有多少可用workers

    ```matlab
    >> backgroundPool().NumWorkers

    ans =

         8

    ```
  * 具体测试

    * 正常同步运行代码：

      ```matlab
      % 同步执行多个任务 
      tic
      disp(task(1,"Normal"))
      disp(task(2,"Normal"))
      disp(task(3,"Normal"))
      toc


      function output = task(taskID,poolType)
          pause(5);
          output = sprintf('Task %d is done in %s at %s', taskID, poolType,datetime('now'));
      end
      ```

      Task 1 is done in Normal at 2023-11-25 14:12:19  
      Task 2 is done in Normal at 2023-11-25 14:12:24  
      Task 3 is done in Normal at 2023-11-25 14:12:29
    * 使用backgroundPool异步运行：

      ```matlab
      b(1:3) = parallel.FevalFuture;
      for i = 1:3
          b(i) = parfeval(backgroundPool, @task, 1, i, 'backgroundPool'); % 以参数i调用 task 函数并进行后台计算
      end
      afterEach(b, @disp, 0);

      function output = task(taskID,poolType)
          pause(5);
          output = sprintf('Task %d is done in %s at %s', taskID, poolType,datetime('now'));
      end
      ```

      Task 2 is done in backgroundPool at 2023-11-25 14:13:03  
      Task 3 is done in backgroundPool at 2023-11-25 14:13:03  
      Task 1 is done in backgroundPool at 2023-11-25 14:13:03
* backgroundPool 能后台保存文件吗？

  * ✅ 后台保存图像

    ```matlab
    img = imread('cameraman.tif');
    f = parfeval(backgroundPool, @imwrite, 0, img, 'test_backgroundPool.jpg');
    afterEach(f,@done,0);
    disp("Waiting for imwrite")

    function done(~)
        disp("done")
    end
    ```
  * ✅ 后台保存表格

    ```Matlab
    m = zeros(512,512);
    f = parfeval(backgroundPool, @writematrix, 0, m, 'test.csv');
    afterEach(f,@done,0);
    disp("Waiting for imwrite")
    ```
  * ✅ 后台调用txt

    * fopen

      ```Matlab
      m = zeros(512,512);
      f = parfeval(backgroundPool, @writetext, 0,'./test.txt', 'Hello Matlab');
      afterEach(f,@done,0);
      disp("Waiting for imwrite")


      function done(~)
          disp("done")
      end

      function writetext(fullpath,str)
          fid = fopen(fullpath, 'w');
          fprintf(fid, str);
          fclose(fid);
      end

      ```
    * writelines

      ```Matlab
      m = zeros(512,512);
      f = parfeval(backgroundPool, @writelines, 0, 'Hello Matlab','./test.txt');
      afterEach(f,@done,0);
      disp("Waiting for imwrite")


      function done(~)
          disp("done")
      end
      ```
* 注意：backgroundPool 后台运行的函数如果有disp，并不会显示到主线程

  ```Matlab
  b(1:8) = parallel.FevalFuture;
  for i = 1:8
      b(i) = parfeval(backgroundPool, @task, 1, i, 'backgroundPool'); % 以参数i调用 task 函数并进行后台计算
  end

  function output = task(taskID,poolType)
      pause(5);
      fprintf('Task %d is done in %s at %s', taskID, poolType,datetime('now'));
  end
  ```

  可以添加`afterEach(f, @disp, 0);`​来显示
* backgroundPool 是Matlab 2021b才出的功能，backgroundPool的作用是什么，parfeval本身不是支持后台运行任务吗

  * 我的想法

    * 更轻便：当MATLAB基于进程的并行池第一次启动时，通常需要几秒钟的时间，基于线程的并行池会快些，需要指定线程或进程个数，而backgroundPool会根据需要自行扩展后台线程数，backgroundPool会更轻便。
    * 基于线程：backgroundPool 基于线程，并不占用基于进程的并行池.
    * > 疑惑：暂时没觉得parfeval调用基于线程的并行池和调用backgroundPool有什么区别
      >
  * 举例（我的电脑核心数为8）

    * 8个基于进程的并行池和8个后台池都同时执行完成了所有任务

      ```Matlab
      delete(gcp('nocreate'))
      pool=parpool('Processes')

      % 并行池后台异步执行多个任务
      f(1:8) = parallel.FevalFuture;
      for i = 1:8
          f(i) = parfeval(pool, @task, 1, i, 'parpool'); % 以参数i调用 task 函数并进行并行计算
      end

      afterEach(f, @disp, 0);


      b(1:8) = parallel.FevalFuture;
      for i = 1:8
          b(i) = parfeval(backgroundPool, @task, 1, i, 'backgroundPool'); % 以参数i调用 task 函数并进行后台计算
      end

      afterEach(b, @disp, 0);

      function output = task(taskID,poolType)
          pause(5);
          output = sprintf('Task %d is done in %s at %s', taskID, poolType,datetime('now'));
      end

      ```

      Task 4 is done in parpool at 2023-11-25 11:41:46  
      Task 2 is done in parpool at 2023-11-25 11:41:46  
      Task 3 is done in parpool at 2023-11-25 11:41:46  
      Task 5 is done in parpool at 2023-11-25 11:41:46  
      Task 8 is done in parpool at 2023-11-25 11:41:46  
      Task 6 is done in parpool at 2023-11-25 11:41:46  
      Task 1 is done in parpool at 2023-11-25 11:41:46  
      Task 7 is done in parpool at 2023-11-25 11:41:46  
      Task 1 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 7 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 5 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 2 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 6 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 3 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 4 is done in backgroundPool at 2023-11-25 11:41:46  
      Task 8 is done in backgroundPool at 2023-11-25 11:41:46
    * 8个基于线程的并行池和8个后台池同时运行，后台池只能抢到一个线程，等到基于线程的并行池的任务全部完成，后台池才能用其他的线程执行任务

      ```Matlab
      delete(gcp('nocreate'))
      pool=parpool('Threads')

      % 并行池后台异步执行多个任务
      f(1:8) = parallel.FevalFuture;
      for i = 1:8
          f(i) = parfeval(pool, @task, 1, i, 'parpool'); % 以参数i调用 task 函数并进行并行计算
      end

      afterEach(f, @disp, 0);


      b(1:8) = parallel.FevalFuture;
      for i = 1:8
          b(i) = parfeval(backgroundPool, @task, 1, i, 'backgroundPool'); % 以参数i调用 task 函数并进行后台计算
      end

      afterEach(b, @disp, 0);


      function output = task(taskID,poolType)
          pause(5);
          output = sprintf('Task %d is done in %s at %s', taskID, poolType,datetime('now'));
      end


      ```

      Task 7 is done in parpool at 2023-11-25 11:48:19  
      Task 6 is done in parpool at 2023-11-25 11:48:19  
      Task 3 is done in parpool at 2023-11-25 11:48:19  
      Task 4 is done in parpool at 2023-11-25 11:48:19  
      Task 8 is done in parpool at 2023-11-25 11:48:19  
      Task 2 is done in parpool at 2023-11-25 11:48:19  
      Task 5 is done in parpool at 2023-11-25 11:48:19  
      Task 1 is done in backgroundPool at 2023-11-25 11:48:19  
      Task 1 is done in parpool at 2023-11-25 11:48:19  
      Task 2 is done in backgroundPool at 2023-11-25 11:48:24  
      Task 3 is done in backgroundPool at 2023-11-25 11:48:24  
      Task 7 is done in backgroundPool at 2023-11-25 11:48:24  
      Task 8 is done in backgroundPool at 2023-11-25 11:48:24  
      Task 5 is done in backgroundPool at 2023-11-25 11:48:24  
      Task 4 is done in backgroundPool at 2023-11-25 11:48:24  
      Task 6 is done in backgroundPool at 2023-11-25 11:48:24

## 获取后台运行结果

​`fetchOutputs`​、`fetchNext`​手动获取后台结果，`afterEach`​、`afterAll`​后台运行完成自动执行函数获取结果

* 手动获取后台结果

  * fetchOutputs：运行完之后获取结果，虽然能后台运行，但是如果没处理完，你直接fetchOutputs，就会卡住

    ```matlab
    f = parfeval(backgroundPool,@test_pause,1,10);


    fetchOutputs(f)

    function a = test_pause(t)
        pause(t);
        a =5;
    end
    ```
  * [fetchNext](https://ww2.mathworks.cn/help/matlab/ref/parallel.fevalfuture.fetchnext.html)：Retrieve next unread outputs from `Future`​ array

    * 多次运行一个函数，直到找到令人满意的结果。在这种情况下，当结果大于0.95时，取消 F。（好像和while没差，可能就是在处理的过程中还能后台产生值，更快一些）

      ```matlab
      N = 100;
      for idx = N:-1:1
          F(idx) = parfeval(backgroundPool,@rand,1); % Create a random scalar
      end

      result = NaN; % No result yet
      for idx = 1:N
          [~, thisResult] = fetchNext(F);
          if thisResult > 0.95
              result = thisResult;
              % Have all the results needed, so break
              break;
          end
      end
      % With required result, cancel any remaining futures
      cancel(F)
      result
      ```
    * 请求几个任务，并在等待完成后更新进度条。

      ```matlab
      N = 100;
      for idx = N:-1:1
          % Compute the rank of N magic squares
          F(idx) = parfeval(backgroundPool,@rank,1,magic(idx));
      end 
      % Build a waitbar to track progress
      h = waitbar(0,'Waiting for FevalFutures to complete...');
      results = zeros(1,N);
      for idx = 1:N
          [completedIdx,thisResult] = fetchNext(F);
          % Store the result
          results(completedIdx) = thisResult;
          % Update waitbar
          waitbar(idx/N,h,sprintf('Latest result: %d',thisResult));
      end
      delete(h)
      ```
* 运行完之后自动获取结果：afterEach 和 afterAll 区别

  * afterEach：[Run function after each function finishes running in the background - MATLAB afterEach - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/parallel.future.aftereach.html)

    B = afterEach(A,fcn,n)  
    B = afterEach(A,fcn,n,PassFuture=true)

    ```matlab
    f = parfeval(backgroundPool,@test_pause,1,10);
    afterEach(f,@disp,0);


    for i = 1:5
        f(i) = parfeval(backgroundPool,@rand, 1, 1);
    end
    afterEach(f,@disp,0);

    ```

    > PassFuture=true作用
    >
    > * 表示回调函数fcn的输入参数是Future数组中的每个Future元素，而不是执行函数的输出结果。这样做的意义是，即使某次执行中发生了错误，也不会影响回调函数的执行
    >
  * afterAll：[Run function after all functions finish running in the background - MATLAB afterAll - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/parallel.future.afterall.html)

    例子：每次完成任务后更新进度条，全部任务完成后关闭进度条

    ```Matlab
    w = waitbar(0,'Please wait ...');
    N = 20;
    w.UserData = [0 N];
    for i = 1:N
        delay = rand;
        f(i) = parfeval(backgroundPool,@pause,0,delay);
    end
    afterEach(f,@(~)updateWaitbar(w),0);
    afterAll(f,@(~)delete(w),0);

    function updateWaitbar(w)
        % Update a waitbar using the UserData property.

        % Check if the waitbar is a reference to a deleted object
        if isvalid(w)
            % Increment the number of completed iterations 
            w.UserData(1) = w.UserData(1) + 1;

            % Calculate the progress
            progress = w.UserData(1) / w.UserData(2);

            % Update the waitbar
            waitbar(progress,w);
        end
    end
    ```

## DataQueue

> 可以把其他线程发过来的数据展示到当前进程，比如使用imshow自动展示后台处理的图片、对工业相机拍摄的图像后台处理后实时展示。不过貌似对f使用afterEach就好了，有什么场景需要用这个吗？

例子

```Matlab
% 创建一个 DataQueue 对象，用于接受后台线程的data，执行处理函数 
q = parallel.pool.DataQueue;
afterEach(q,@showImage);

% 后台模糊图像
img = imread('cameraman.tif');
f = parfeval(backgroundPool,@blurImage,1,q,img);


% 用来模糊图像，并将结果发送到 DataQueue
function blurred_img = blurImage (q,img)

    blurred_img = imgaussfilt (img, 2); % 使用高斯滤波模糊图像
    send (q, blurred_img); % 将模糊后的图像发送到 DataQueue end
end


% 用来接收 DataQueue 的数据，并显示图像 
function showImage (data) 
    figure;
	imshow (data);
	title ('Blurred Image'); 
end
```

函数

* send(q,data) 将值为 data 的数据项发送到队列 q。

  * [将数据发送到 DataQueue 或 PollableDataQueue - MATLAB send - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/parallel.pool.dataqueue.send.html)
* ​`afterEach`​
* poll ：Retrieve data from `PollableDataQueue`​​

  * [Retrieve data from PollableDataQueue - MATLAB poll - MathWorks 中国](https://ww2.mathworks.cn/help/matlab/ref/parallel.pool.pollabledataqueue.poll.html)

‍
