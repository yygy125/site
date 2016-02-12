title: 视图扩展
---
2.0 版本开始支持自定义模板函数,过滤器. 通过自定义扩展,可以针对 `Bundle` 职责进行自定义配置.

实现扩展需要继承一个 `FastD\Framework\Extensions\TplExtension` 对象, 实现内部的扩展方法.

扩展存放在 `Bundle` 的 `Extensions` 目录下.

扩展需要实现 3 个方法: `getName`, `getFilters`, `getFunctions`, 方法中个字返回对应信息.

```php
<?php

namespace Welcome\Extensions;

use FastD\Framework\Extensions\TplExtension;
use Twig_SimpleFilter;
use Twig_SimpleFunction;

class DemoExtensions extends TplExtension
{
    /**
     * Returns the name of the extension.
     *
     * @return string The extension name
     */
    public function getName()
    {
        return 'demo';
    }

    /**
     * Returns a list of filters to add to the existing list.
     *
     * @return Twig_SimpleFilter[]
     */
    public function getFilters()
    {
        return [
            new Twig_SimpleFilter('demo_filter', function () {
                return 'demo_filter';
            })
        ];
    }

    /**
     * Returns a list of functions to add to the existing list.
     *
     * @return Twig_SimpleFunction[]
     */
    public function getFunctions()
    {
        return [
            new Twig_SimpleFunction('demo_func', function () {
                return 'demo_func';
            }),
        ];
    }
}
```

## getName

返回当前扩展的名字, 推荐使用 `BundleName_{name}` 进行格式配置.

## getFilters, getFunctions

函数返回一个 `\Twig_SimpleFunction` 数组.

过滤器返回一个 `\Twig_SimpleFilter` 数组.

内容实现参考: [Twig扩展](http://twig.sensiolabs.org/doc/advanced.html#functions) 

