title: 依赖注入
---
依赖注入也算是本框架的一个亮点之作, 所以对象都会注册到一个 "容器" 对象里面, 所有的对象获取都通过该 "容器" 获取.

一方面减少了对象重复 new, 另一方面也可以很好地管理各种对象.

对象实例实现通过 `composer` 来实现. 具体请看: [Container]()

```php
<?php

namespace Welcome\Events;

use FastD\Protocol\Http\Request;

class Welcome
{
    /**
     * 这里注入一个对象, 多个对象就添加多个参数.
     */
    public function welcomeAction(Request $request)
    {
    	return $request->getPathInfo();
    }
}
```

> 注入的对象需要排在动态参数的最前面

如果这里配置动态路由, 在 `action` 中添加参数即可.

```php
<?php

namespace Welcome\Events;

use FastD\Protocol\Http\Request;

class Welcome
{
    /**
     * 这里注入一个对象, 多个对象就添加多个参数.
     */
    public function welcomeAction(Request $request, $name)
    {
    	return $name;
    }
}
```

路由对应到

```php
Routes::get('/{name}', 'namespace:class@action');
```

具体路由定义请看: [路由]()
