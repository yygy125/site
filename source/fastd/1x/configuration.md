title: 配置
---

框架当中不提供太多默认的常亮配置及默认配置项，因为我觉得不应该提供太多的配置给开发者(因为80%以上默认配置是用不上的)，所以这里提供的配置，仅针对每个模块。

每位开发者对自己模块及依赖的配置，不会约束开发者对自己应用项目的限制，这里则会更加开发和灵活地给每位开发者自行配置。

如果你觉得这里配置有异议的话，可以与我交流，我会及时作出调整。

## 环境配置文件

框架目前赞分为两大类配置:

*   框架默认配置
*   环境定制配置

配置列表:

*   `config.php` 框架默认配置
*   `config_dev.php` 本地开发环境配置
*   `config_test.php` 测试服环境配置
*   `config_prod.php` 生产服环境配置

配置文件根据当前运行的应用场景进行加载。例如，当你在本地开发是则应该运行 `public/dev.php` 入口文件(生产服禁止访问)，则会对应加载 `app/config/config_dev.php` 配置文件，所以在框架运行的时候需要明确区分不同的应用场景。

配置信息一律使用 `php` 数组形式进行配置(曾经采用 `yaml` 配置，但需要配置对应缓存，否则每次解析都会消耗大量资源.)。

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