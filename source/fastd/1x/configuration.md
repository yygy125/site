title: 配置
---
## 配置文件
框架默认提供三种运行环境给您，运行入口在 `public/(dev|test|prod).php`.

三个运行入口分别对应

```
dev     本地开发环境
test    测试服务器模拟生产环境
prod    生产环境
```

运行环境对应这应用程序的环境配置文件, 本别对应:

```
app/config/config_dev.php
app/config/config_test.php
app/config/config_prod.php
```

不同环境配置不一样,为了适应开发者的调试以及习惯.

默认的开发模式和测试模式是不会纪录错误日志,而执行生产环境则会将所以错误,访问纪录日志,方便排查以及统计.

开发模式和测试模式会将所有错误信息在错误发生的时候显示给开发者

## 变量配置

配置文件支持配置动态变量，动态变量需要使用 `%` 进行定界符进行概括。

框架默认提供几个动态配置:

*   `root.path` 项目根目录
*   `env` 当前运行环境
*   `debug` 当前是否在debug模式
*   `version` 当前使用的应用版本号
*   `date` 当前日期 (Ymd)

简单配置一个动态变量:

在 `app/Application::registerConfigVariable` 方法下然后返回一个变量数组，如要定义一个自定义配置变量 `name`

<pre class="md-fences mock-cm" style="display:block;position:relative">//some code...
public function registerConfigVariable()
{
  return array(
	'name' => 'jan'
  );
}
//some code...
</pre>

配置文件: `config/config_dev.php`

<pre class="md-fences mock-cm" style="display:block;position:relative">return [
	// some code...
	'name' => '%name%'
    // some code...
];</pre>

通过配置动态变量，则在获取的时候就可以获取自定义的内容，这里除了字符串，你还可以定义其他类型的，自己发挥想象试试吧。

如果你觉得这样配置还不是很方便，则可以反馈给我并且附上调整建议哦。