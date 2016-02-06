title: Http 事件 (控制器Controller)
---
事件绑定

每个请求，都视为一个动作，每个动作都对应一个事件，路由则是绑定一这类事件，并且在触发路由的时候，会解析路由绑定的动作交给调度器进行事件触发处理。

这里演示使用默认的 `Welcome` 模块，并且需要配合路由：

`Routes::get('/', '\\Welcome\\Events\\Index@welcomeAction');`

<pre class="md-fences mock-cm" style="display:block;position:relative"><?php

namespace Welcome\Events;

class Welcome
{
	public function welcomeAction()
    {
    	return 'hello world';
    }
}</pre>

**注意这里每个事件触发完之后都需要返回一个结果 `[string|FastD\\Protocol\\Http\\Response]`。**

当访问到根目录的时候，浏览器则会显示 `hello world`，证明绑定没有问题了。

可以继续更深一层的挖掘

## 基础事件

不同事件根据不同动作操作，而每个事件处理的逻辑及返回都不一样，所以这里提供多个基类处理事件，处理不同策略下的数据返回，而这一类基础事件处理的父类，都是 `Kernel\\Events\\EventAbstract` 抽象类

基类列表

*   `Kernel\\Events\\EventAbstract` 全部事件基类，默认不支持模板输出
*   `Kernel\\Events\\TemplateEvent` 支持模板输出的事件基，继承 `Kernel\\Events\\EventAbstract`

如果想使用处理模板输出的，需要让自定义事件处理器继承 `Kernel\\Events\\TemplateEvent`