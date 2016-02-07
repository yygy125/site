title: 基础操作
---
#### 查询 (select)

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