title: Http 事件 (2.0 控制器Controller)
---
每个路由其实可以算是一个 `Http` 请求处理, 对应着 `path info` 和需要处理的工作.

正如路由上定义的 `namespace:class@action` 这就是该 `path into` 需要处理的工作

这里演示使用默认的 `Welcome` 模块，并且需要配合路由：

##### 路由

```php
Routes::get('/', 'Welcome:Events:Index@welcomeAction');
```

##### 事件 (控制器)
```php
<?php

namespace Welcome\Events;

class Welcome
{
    public function welcomeAction()
    {
    	return 'hello world';
    }
}
```

> 注意这里每个事件触发完之后都需要返回一个字符串(`string`)或者 `Response(FastD\Http\Response)` 对象。

访问该路由, 会执行对应的 `action`, 输入对应的显示.

目前封装是将 `Event` 分成 3 类:

```php
BaseEvent       针对接口
RestEvent       针对普通
TemplateEvent   针对模板
```

> 2.0 版本开始 `Event` 统一改为 `Controller`. 方法集成到 `Controller` 中. 方法移除.
