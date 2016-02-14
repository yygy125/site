title: 注释路由
---
注释路由针对要执行要处理的事件(控制器)而定, 注释就是普通的 `PHP` 注释, 标准注释.

实现原理通过 `PHP` 提供的 `Reflection` 反射进行解析处理.

所以这里有一点需要提及的, 既然是通过 `PHP` 的反射进行处理, 那么要考虑一点性能上的问题.

最后决定将注释路由配置在开发环境的时候生效, 若要将注释路由配置到生产环境使用, 需要使用预设命令进行缓存.

## 注释

注释同普通 `PHP` 并没有太大的差异, 唯一需要一个标识, 仅仅是一个注释, 解析根据标示进行获取. 示例:

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
        return $this->response($this->generateUrl('welcome'));
    }
}
```

`@Route` 就是路由标识, 通过标示对路由进行定义, 其定义的方式会与平时咱们的 `PHP` 代码去注释略有些不一样.

> 注释路由定义中, 必须使用双引号 `"` 进行定义.

### @Route 标识

```php
@Route(
    {path},
    [name],
    [defaults],
    [requirements]
)
```

一共可以单行定义 4 个参数.

### 参数

#### path

&emsp;&emsp;路由地址, 被访问的地址, 也既是 path info.

#### name

&emsp;&emsp;路由名, 可以通过路由名定位到路由位置, 控制器等, 作为路由唯一表示

#### defaults

&emsp;&emsp;路由动态变量默认值

#### requirements

&emsp;&emsp;路由动态变量类型约束

### 示例

```php
/**
 * @Route("/{name}", name="welcome", defaults={"name":"janhuang"})
 */
```

### @Method 标识

限制路由的可访问方法

```php
/**
 * @Route()
 * @Methods({methods})
 */
```

### 参数

#### methods

&emsp;&emsp;请求方法, 以数组形式存在

### 示例

```php
/**
 * @Route("/{name}", name="welcome", defaults={"name":"janhuang"})
 * @Methods(["GET", "POST"])
 */
```

### @Formats 标识

限制路由的请求格式

```php
/**
 * @Route()
 * @Formats({formats})
 */
```

### 参数

#### formats

&emsp;&emsp;请求格式, 以数组形式存在, 不填默认是 `php`, 也就是 `txt/html`

### 示例

```php
/**
 * @Route("/{name}", name="welcome", defaults={"name":"janhuang"})
 * @Formats(["json", "html", "php"])
 */
```
