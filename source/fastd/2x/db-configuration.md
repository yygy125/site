title: 数据库配置
---
数据库配置和以往一样, 使用多维数组进行配置, 具体配置请看: [数据库配置](/fastd/1x/db-configuration.html)

> 2.0 版本的 `getConnection` 已经使用 `getDriver` 进行代替.

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
        try {
            $driver = $this->getDriver('read');
        } catch (\Exception $e) {
            return $this->response('fail');
        }

        return $this->response('ok');
    }
}
```