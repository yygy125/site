title: 视图操作
---

> 若要渲染模板，处理事件需要继承 `FastD\Framework\Events\TemplateEvent`

```php
<?php

namespace Welcome\Events;

use FastD\Protocol\Http\Request;
use FastD\Framework\Events\TemplateEvent;

class Welcome extends TemplateEvent
{
    /**
     * 这里注入一个对象, 多个对象就添加多个参数.
     */
    public function welcomeAction(Request $request)
    {
    	return $this->render('path/to/name.twig');
    }
}
```

> 模板引擎在 framework 1.5 之前需要填写完整模板路径. 1.5 版本之后可以填写该 Bundle 下的 views 相对路径

赋值需要在 `render` 中的第二个参数, 以数组形式传入:

```php
render($template, array $parameters = []);
```