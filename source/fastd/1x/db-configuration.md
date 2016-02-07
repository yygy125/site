title: 数据库配置
---

> 数据库驱动采用 `PDO` 驱动, 在使用前请确认 `PDO` 扩展开启.

> 在 2.0 版本中, 支持 `ORM` 及自动生成对象等方法.

## 简述

破坏总比创建要来得容易，所以在进行任何一些删除操作的时候，一定要打醒120分的精神啊，不然就很容易毁于一旦了，特别对于大访问量和大量数据的，哪怕是中断数秒钟，那损失也不是你能想象.

所以 `FastD\Database\Database` 默认本身不提供`delete` 操作，如果你一定要delete，请使用 `createQuery` 进行手动删除。

## 配置

数据库配置均在三个不同环境配置中, 在 `database` block 配置中, 不同环境数据库配置结构一样, 理应是链接信息不一样.

> 数据库配置均已多库配置作为规范, 就算在只有一个数据库链接的时候, 也应该保持多库配置的形式

```php
<?php

return [
    // some config
    'database' => [
        'write' => [
            'database_type'     => 'mysql',
            'database_host'     => '127.0.0.1',
            'database_port'     => 3306,
            'database_user'     => 'root',
            'database_pwd'      => '',
            'database_charset'  => 'utf8',
            'database_name'     => 'test',
            'database_prefix'   => ''
        ],
        'read' => [
            'database_type'     => 'mysql',
            'database_host'     => '127.0.0.1',
            'database_port'     => 3306,
            'database_user'     => 'root',
            'database_pwd'      => '',
            'database_charset'  => 'utf8',
            'database_name'     => 'test',
            'database_prefix'   => ''
        ],
    ],
    // some config
];
```

默认配置一读一写. 在 Http 事件(Controller) 中通过方法: `$this->getConnection($connection)` 获取.

> `getConnection($connection)` 在 2.0 中已经移除, 使用 `getDriver($name)` 进行代替

方法返回一个数据库链接驱动. 通过驱动可以获取 `Repository`, `Repository` 相当于平时的 `Model`, 可以自定义方法和使用其方法进行数据库操作.

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

class Welcome extends BaseEvent
{
    public function welcomeAction()
    {
        try {
            $read = $this->getConnection('read');
        } catch (\Exception $e) {
            return 'get connection fail';
        }

    	return 'ok';
    }
}
```
