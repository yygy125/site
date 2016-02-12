title: 控制器
---
2.0 版本的控制器和 1.0 版本的 `Event` 是同一个概念, 至于因为 "控制器" 更加接地气, 所在在 2.0 版本重新加上, 代替 `Event`.

控制器主要负责的工作也就是 1.0 版本的 `Event` 工作, 处理方式和 1.0 版本一样.

配置路由访问到指定的事件处理(控制器).

> 若要使用框架控制器提供的方法, 需要继承 `FastD\Framework\Bundle\Controllers\Controller` 基类

## 注释配置

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
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
     * @return Response|string
     */
    public function welcomeAction($name)
    {
        return $this->response($name);
    }
}
```

当访问到跟目录, 会显示对应的处理信息. 具体逻辑实现由实际的业务进行处理.

## 路由配置

与 1.0 保持一致的配置, 配置文件在: `{Bundle}/Resources/config/routes.php` 下, 进行配置路由: 

```php
<?php
Routes::get(['/', 'name' => 'root'], 'Welcome:Controllers:Index@welcomeAction', ['name' => 'janhuang']);
```

或者

```php
<?php
Routes::get(['/', 'name' => 'root'], 'Welcome:Controllers:Index@welcomeAction')
    ->setDefaults(['name' => 'janhuang'])
;
```

效果是一样的.

这就是最基础的路由与控制器的配置.

## 获取数据库链接 `getDriver($name, array $options = [])`

与 1.0 不同, 2.0 版本获取数据库驱动由 1.0 的 `getConnection` 换成 `getDriver`

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;

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
        try {
            $this->getDriver('read');
        } catch (\Exception $e) {
            return $this->response('fail');
        }
        
        return $this->response($name);
    }
}
```

## 获取容器 `getContainer()`

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;

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
        try {
            $this->getContainer();
        } catch (\Exception $e) {
            return $this->response('fail');
        }
        
        return $this->response($name);
    }
}
```

## 响应

```php
public function response($data, $statusCode = 200, array $headers = []): FastD\Http\Response
```

响应是根据请求格式(后缀)来进行自动的判断和分类.

示例: 

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;

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
        return $this->response(['name' => 'janhuang']);
    }
}
```

如果请求是 `html`, 则响应头是 `text/html`, 也就是根据后缀进行处理, 如: 

```
/name.json
```

响应 `json` 对象, `FastD\Http\JsonResponse`

```
/name.xml
```

响应 `xml` 对象, `FastD\Http\XmlResponse`

如此类推. 详情请移步到: [Http组件](/components/basic_http.html)