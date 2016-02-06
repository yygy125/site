title:  Routing
---
> Dobee php routing component. 框架路由组件

改玩意也是依赖composer的哟。

项目地址:

1. **[github][1]**
2. **[coding][2]**

##由来
其实一开始不打算做这个东西的，因为现在到处都是，之前也讲过，本人也是一个爱作死爱折腾的人，所以还是参考了一些别人的，做了一下玩玩

##安装
此玩意已经推托管到**[packagist][3]**了，用composer装逼的同学可以试试。但是鉴于国内的那道墙和网络，实在不敢恭维呀，苦了墙内的小伙伴们，还是直接到**[github][4]**或者**[coding][5]** clone下来吧。

##故事／发展
一开始的时候，搞这个东西，是用注释去配置陆游的，但是后来发现在项目中如果这样配置，程序每次初始化，都需要加载分析一次全部路由，每个请求一次(我擦，这玩笑开大了)，然而对系统的开销是很大的。所以这样的一个不足有几点：
    1. io
    2. 程序对注释段分析
    3. 不好排查

那么应对的也有几个方案：
    1. 在生产环境部署的时候缓存所有路由配置，形成路由表文件
    2. 整合命令行工具，通过命令行排查
    3. 代码常驻到内存里面 (**[swoole][6]**)

后面经过一段的调整，把他拆直接通过全局 `Routes` 对象创建，感兴趣的同学可以安装试试，玩玩，对象里面的方法我就不讲了，你们都懂得，看不懂的去面壁吧。

目前路由配置的方法是类似 `laravel` 的路由配置的，但请不要喷我，我只是参考了而已，折腾了下。

目前支持 `get`, `post`, `group` 其他还没具体测试过用例，小伙伴们可以帮下忙哦，有问题直接反馈或者在项目上 `issue`

##感受
做这个玩意，当时也是抱着试一试的想法去做，没想到就做成现在这样，现在也用上了正途，虽然偶尔会发现点bug，但是我特么都解决了。多烂的东西只要持续去做持续去完善，总有一天会变好的，这叫打磨。首先你要去尝试。是吧，包哥。@**[runnerlee][7]**，很荣幸有这大神陪伴，感觉自己就是个渣。

##用例
####GET
```
Routes::get('/', function () {
    return 'hello world';
});
```
每个配置之后都 `return \Dobee\Routing\RouteInterface` 对象，也就是说，以上用例配置完之后，可以执行一系列的链式操作。比如:
```
Routes::get('/', function () {})->setFormat(['html', 'php'])->setXX()->setXX;
```
最用用**[PHPStorm][8]**吧，有提示的。

不说了，这么简单的东西，你看看，刚入门都懂了，你们，应该都透了，我就不浪费口水了，去撸吧，程序猿。

##关于作者
不得不说我是一个喜欢折腾比较作死的人。常言道：生命不止，折腾不息。干我们这行的，不是被人干就是干别人(通常都是被人干)。趁年轻，干点自己喜欢的事情呗，反正自己开心，喜欢就得了，哪怕是重复造轮子。喜欢的，总有收获。感恩各位小伙伴指点。

<!--干掉硬广

我擦，留个QQ给大伙交流交流: **384099566**，记住，系**384099566**。
个人网站: **[http://www.janhuang.me][9]**
微信是: ******046

-->

##关于大神Runnerlee
他威胁我不能说。


  [1]: https://github.com/JanHuang/routing
  [2]: https://coding.net/u/janhuang/p/routing/git
  [3]: https://packagist.org/packages/dobee/routing
  [4]: https://github.com/JanHuang/routing
  [5]: https://coding.net/u/janhuang/p/routing/git
  [6]: http://swoole.com/
  [7]: http://www.runnerlee.com/
  [8]: http://www.jetbrains.com/phpstorm/
  [9]: http://www.janhuang.me