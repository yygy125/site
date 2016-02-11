title: Http 组件
---
## 安装

```
composer install "fastd/http" -vvv
```

## 使用

```php
<?php

include __DIR__ . "/../vendor/autoload.php"

use FastD/Http/Request;

$request = new Request();

$pathinfo = $request->getPathInfo();

echo $pathinfo;
```

Http 组件封装了常用的 Http 协议, 提供便利好用的方法给开发者, 并且可以利用路由组件, 其他组件等可集成自己的开发框架.