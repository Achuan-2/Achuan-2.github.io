---
title: 协程 Coroutine 是什么？Python 的async用法
date: '2023-11-25 22:04:22'
updated: '2023-11-25 22:04:34'
permalink: /post/what-is-corporate-coroutine-python-s-async-usage-zp0b11.html
comments: true
tags:
  - Matlab
  - 编程
categories:
  - 技术博客
toc: true
excerpt: >-
  协程的作用是在执行函数A时可以随时中断去执行函数B，然后中断函数B继续执行函数A（可以自由切换）。
  但这一过程并不是函数调用，这一整个过程看似像多线程，然而协程只有一个线程执行。协程就是一个人干多个活，如果一个任务进行过程中有比较多的等待时间，并不需要自己参与，就可以利用这段时间去干别的事情。
---



* 协程是什么

  * 协程的作用是在执行函数A时可以随时中断去执行函数B，然后中断函数B继续执行函数A（可以自由切换）。 但这一过程并不是函数调用，这一整个过程看似像多线程，然而协程只有一个线程执行。协程就是一个人干多个活，如果一个任务进行过程中有比较多的等待时间，并不需要自己参与，就可以利用这段时间去干别的事情。
* 协程的主要应用场景

  * 协程很适合处理((20231124114842-nvxmq57 "IO密集型程序"))的效率问题，Tornado web 框架、文件下载、网络爬虫等应用。协程能够在 IO 等待时间就去切换执行其他任务，当 IO 操作结束后再自动回调，那么就会大大节省资源并提供性能减少了不必要的等待时间，提高了执行速度。
  * 但需要注意的是<span style="font-weight: bold;" data-type="strong">协程的本质还是个单线程，它不能同时将单个CPU的多个核用上，因此对于CPU密集型程序协程需要和多进程配合，光靠协程没有太大用</span>。比如，要进行大量的计算、逻辑判断，消耗 CPU 资源，比如计算圆周率、对视频进行高清解码等等。
* 协程的例子

  * > “假设有1个洗衣房（进程），里面有10台洗衣机（任务），有一个洗衣工（线程）在负责这10台洗衣机。那么洗衣房就相当于1个进程，洗衣工就相当1个线程。如果有10个洗衣工，就相当于10个线程，1个进程是可以开多线程的。这就是多线程！  
    > <span style="font-weight: bold;" data-type="strong">那么协程呢？</span>  先不急。大家都知道，洗衣机洗衣服是需要等待时间的，如果10个洗衣工，1人负责1台洗衣机，这样效率肯定会提高，但是不觉得浪费资源吗？明明1 个人能做的事，却要10个人来做。只是把衣服放进去，打开开关，就没事做了，等衣服洗好再拿出来就可以了。<span style="font-weight: bold;" data-type="strong">就算很多人来洗衣服，1个人也足以应付了</span>，开好第一台洗衣机，在等待的时候去开第二台洗衣机，再开第三台，……直到有衣服洗好了，就回来把衣服取出来， 接着再取另一台的（哪台洗好先就取哪台，所以协程是无序的）。这就是计算机的协程！洗衣机就是执行的方法。”
    >
  * > 小明同学的妈妈给他早上安排了三件事：
    >
    > 1. 洗衣机洗衣服需要花 15 分钟
    > 2. 电饭煲做饭需要花 20 分钟
    > 3. 做作业需要花 25 分钟
    >
    > 那么请问：小明同学早上完成以上三件事需要花多久？？
    >
    > ——可以接近25分钟完成，因为洗衣服和煮饭只需要按按钮就行了，之后专心去做作业就可以
    >
* IO 密集型的操作是什么

  * I/O是什么：IO是指Input/Output，即输入和输出。以内存为中心：

    * Input指从外部读入数据到内存，例如，把文件从磁盘读取到内存，从网络读取数据到内存等等。
    * Output指把数据从内存输出到外部，例如，把数据从内存写入到文件，把数据从内存输出到网络等等。
  * 计算密集型和IO 密集型

    * 计算密集型的操作：计算密集型任务的特点是要进行大量的计算、逻辑判断，消耗 CPU 资源，比如计算圆周率、对视频进行高清解码等等。
    * IO 密集型的操作：涉及到<span style="font-weight: bold;" data-type="strong">网络、磁盘 IO </span> 的任务都是 IO 密集型任务，这类任务的特点是 CPU 消耗很少，任务的大部分时间都在等待 IO 操作完成（因为 IO 的速度远远低于 CPU 和内存的速度）
* 对协程的疑惑：举的例子，洗衣机、电饭煲都是自己能做事的机器，人只是去启动他，当然可以一个人启动好多台机器，等待结果，但是对于计算机而言，像洗衣这种事情，怎么做到一个线程你后台洗衣服，我前台做煲饭的。

  * 我大概懂了，计算机这种情况就类似于IO密集型程序，CPU消耗很少，主要时间在等IO完成，比如

    * 等待键盘输入
    * 控制打印机打印文件
    * <span style="font-weight: bold;" data-type="strong">从硬盘读取文件、写入文件</span>
    * <span style="font-weight: bold;" data-type="strong">向网络发送请求，查询数据库、等待下载完成</span>
* python 协程代码示例

  * 同步编程 vs 异步编程

    * 同步编程

      ```python
      import time

      def washing1():
          time.sleep(3)  # 第一台洗衣机,
          print('washer1 finished')  # 洗完了

      def washing2():
          time.sleep(8)
          print('washer2 finished')

      def washing3():
          time.sleep(5)
          print('washer3 finished')

      if __name__ == '__main__':
          start_time = time.time()
          washing1()
          washing2()
          washing3()
          end_time = time.time()
          print('总共耗时：{}'.format(end_time-start_time))
      ```

      washer1 finished  
      washer2 finished  
      washer3 finished  
      总共耗时：16.00322961807251
    * 异步编程

      ```python
      import time
      import asyncio

      async def washing1():
          await asyncio.sleep(3)  # 第一台洗衣机,
          print('washer1 finished')  # 洗完了

      async def washing2():
          await asyncio.sleep(8)
          print('washer2 finished')

      async def washing3():
          await asyncio.sleep(5)
          print('washer3 finished')

      if __name__ == '__main__':
          print('start main:')
          start_time = time.time()
          # step1 创建一个事件循环, 将异步函数（协程）加入事件队列
          task_list = [
              washing1(),
              washing2(),
              washing3()
          ]
          # step2 执行事件队列 直到最晚的一个事件被处理完毕后结束
          asyncio.run(asyncio.wait(task_list) )
          end_time = time.time()
          print('-----------end main----------')
          print('总共耗时:{}'.format(end_time-start_time))
      ```

      start main:  
      washer1 finished  
      washer3 finished  
      washer2 finished  
      -----------end main----------  
      总共耗时:8.002010822296143
  * 用代码实现连接并查询数据库的同时，下载一个 APK 文件到本地。([Ref](https://xie.infoq.cn/article/d92c1068b9e50b55cced54708))

    ```python
    import asyncio
    import aiomysql
    import os
    import aiofiles as aiofiles
    from aiohttp import ClientSession

    async def get_app():

        url = "http://www.123.apk"
        async with ClientSession() as session:
            # 网络IO请求，获取响应
            async with session.get(url)as res:
                if res.status == 200:
                    print("下载成功", res)
                    # 磁盘IO请求，读取响应数据
                    apk = await res.content.read()
                    async  with  aiofiles.open("demo2.apk", "wb") as f:
                        # 磁盘IO请求，数据写入本地磁盘
                        await f.write(apk)
                else:
                    print("下载失败")

    async def excute_sql(sql):
        # 网络IO操作：连接MySQL
        conn = await aiomysql.connect(host='127.0.0.1', port=3306, user='root', password='123', db='mysql', )
        # 网络IO操作：创建CURSOR
        cur = await conn.cursor()
        # 网络IO操作：执行SQL
        await cur.execute(sql)
        # 网络IO操作：获取SQL结果
        result = await cur.fetchall()
        print(result)
        # 网络IO操作：关闭链接
        await cur.close()
        conn.close()

    task_list = [get_app(), execute_sql(sql="SELECT Host,User FROM user")]
    asyncio.run(asyncio.wait(task_list))

    ```

    代码逻辑分析：

    * 【step1】`asyncio.run()`​创建了事件循环。`wait()`​方法将 task 任务列表加入到当前的事件循环中； *（注意：必须先创建事件循环，后加入任务列表，否则会报错）*
    * 【step2】事件循环监听事件状态，开始执行代码，先执行列表中的`get_app()`​方法，当代码执行到`async with session.get(url)as res:`​时，<span style="font-weight: bold;" data-type="strong">遇到 await 关键字表示有 IO 耗时操作，线程会将该任务挂起在后台执行</span>，并<span style="font-weight: bold;" data-type="strong">切换到另外一个异步函数</span>​`excute_sql()`​；
    * 【step3】当代码执行到`excute_sql()`​的第一个 IO 耗时操作后，线程会重复先前的操作，将该任务挂起，去执行其他可执行代码。假如此时事件循环监听到`get_app()`​中的第一 IO 耗时操作已经执行完成，那么线程会切换到该方法第一个 IO 操作后的代码，并按顺序执行直到遇上下一个 await 装饰的 IO 操作；假如事件循环监听到`excute_sql()`​中的第一个 IO 操作先于`get_app()`​的第一个 IO 操作完成，那么线程会继续执行`excute_sql`​的后续代码；
    * 【step4】线程会重复进行上述第 3 点中的步骤，直到代码全部执行完成，事件循环也会随之停止。

‍

‍

‍
