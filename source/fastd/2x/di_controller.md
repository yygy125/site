title: 参数注入
---
参数注入, 大部分体现在业务逻辑处理模块(控制器), 或者在 Services 中进行体现.

## 注入的概念

注入的意思, 简单理解可以理解成 "参数", 但是这个 "参数" 是程序自动按照参数的类型, 自动帮你传递到方法中.

所以其实是很简单就可以理解的, 可能这个说法比较 "专业".

### Setter 注入

```php
class People
{
    protected $name;
    public function setName($name)
    {
        $this->name = $name;
    }
    public function getName()
    {
        return $this->name;
    }
}
```

以上就是一个简单的 `setter` 注入. 说白了就是传递参数.

### 构造器注入

```php
class People
{
    protected $name;
    public function __construct($name)
    {
        $this->name = $name;
    }
    public function getName()
    {
        return $this->name;
    }
}
```

以上是一个简单的构造器注入, 还是参数.

更加深层次的, 应该需要理解 [IoC]() 的概念.

以上若是有不足, 欢迎批评指点.

## 控制器依赖注入

```php
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
        return $this->response($name);
    }
}
```

因为方法 `welcomeAction` 方法需要一个 `FastD\Http\Request` 对象, 作为第一参数传递.

那么在声明方法的需要明确声明参数的对象, 因为在对象注入的时候需要清楚需要注入什么对象, 依赖注入只针对 "对象" 进行自动注入.

在自动检测的过程中, 会使用 `Reflection` 进行对象方法映射, 从 "容器([Container]())" 中提取对象进行参数传递, 若 "容器" 中没有明确的对象, 则会通过 `composer` 的 `autoload` 进行加载.

接受多个参数注入, 只需要添加对应对象声明即可.

> 这里面的依赖注入对象, 需要排在其他普通参数的前面.