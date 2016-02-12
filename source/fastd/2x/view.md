title: 视图渲染
---
2.0 版本移除 `FastD\Framework\Events\TemplateEvent` 对象, 统一使用 `FastD\Framework\Bundle\Controllers\Controller` 对象, 有控制器统一调用.

使用模板渲染需要继承基类控制器 `FastD\Framework\Bundle\Controllers\Controller` 进行方法继承.

目前会在当前 `Bundle` 下的 `Resources/views` 自动寻找目标.

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;

/**
 * Class Index
 *
 * @package Welcome\Controller
 */
class Index extends Controller
{
    /**
     * @Route("/{name}", name="welcome", defaults={"name":"janhuang"})
     *
     * @param Request $request
     * @return Response|string
     */
    public function welcomeAction(Request $request, $name)
    {
        return $this->render('welcome.twig', [
            'name' => $name
        ]);
    }
}
```

渲染当前 `Bundle` 下的 `welcome.twig` 模板, 对模板分配一个变量 `name`.

> 渲染模板默认会返回一个 `FastD\Http\Response` 对象.

渲染模板可以通过第三个参数进行获取内容, 而不进行内容包装.

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;

/**
 * Class Index
 *
 * @package Welcome\Controller
 */
class Index extends Controller
{
    /**
     * @Route("/{name}", name="welcome", defaults={"name":"janhuang"})
     *
     * @param Request $request
     * @return Response|string
     */
    public function welcomeAction(Request $request, $name)
    {
        $content = $this->render('welcome.twig', [
            'name' => $name
        ], true);
        
        return $this->response($content);
    }
}
```

如果第三个参数设置 `true`, 方法会返回渲染模板后的内容.