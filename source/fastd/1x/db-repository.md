title: Repository
---
`Repository` 又类似 `Model`, 其作用基本上无异, 主要负责封装数据处理操作.

#### 获取 `Repository`

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

/**
 * Class Index
 *
 * @package Welcome\Events
 */
class Index extends BaseEvent
{
    public function welcomeAction(Request $request)
    {
        try {
            $demoRepository = $this->getConnection('read')->getRepository('Welcome:Repository:Demo');
        } catch (\Exception $e) {
            return 'fail';
        }

        return 'ok';
    }
}
```

通过获取一个数据连接, 并且将链接赋予 `Repository`. 一个 `Repository` 对应一个数据库驱动链接.

方法 `getRepository(String $name)` 需要传入一个字符串, 而字符串则是 `Repository` 命名空间的路径, `\\` 用 `:` 号表示

`Repository` 对象需要加上 `Repository` 等字符串, 例如: `Welcome\Repository\DemoRepository`, 作为参数传递则只需要 `Welcome:Repository:Demo`

##### 获取一条纪录 (find)

```php
find(array $where = [], array $fields = []):bool|array
```

示例:

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

/**
 * Class Index
 *
 * @package Welcome\Events
 */
class Index extends BaseEvent
{
    public function welcomeAction(Request $request)
    {
        try {
            $demoRepository = $this->getConnection('read')->getRepository('Welcome:Repository:Demo');
        } catch (\Exception $e) {
            return 'fail';
        }

        $demoRepository->find(['id' => 1]);

        return 'ok';
    }
}
```

##### 获取全部纪录 (findAll)

```php
findAll(array $where = [], array $fields = []):bool|array
```

示例:

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

/**
 * Class Index
 *
 * @package Welcome\Events
 */
class Index extends BaseEvent
{
    public function welcomeAction(Request $request)
    {
        try {
            $demoRepository = $this->getConnection('read')->getRepository('Welcome:Repository:Demo');
        } catch (\Exception $e) {
            return 'fail';
        }

        $demoRepository->findAll(['id' => 1]);

        return 'ok';
    }
}
```

##### 插入一条纪录 (insert)

```php
insert(array $data = []): int|bool
```

示例:

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

/**
 * Class Index
 *
 * @package Welcome\Events
 */
class Index extends BaseEvent
{
    public function welcomeAction(Request $request)
    {
        try {
            $demoRepository = $this->getConnection('read')->getRepository('Welcome:Repository:Demo');
        } catch (\Exception $e) {
            return 'fail';
        }

        $demoRepository->insert(['name' => 'janhuang']);
        // insert into table (`name`) values ('janhaung');

        return 'ok';
    }
}
```

##### 更新一条纪录 (update)

```php
update(array $data = [], array $where = []): int|bool
```

示例:

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

/**
 * Class Index
 *
 * @package Welcome\Events
 */
class Index extends BaseEvent
{
    public function welcomeAction(Request $request)
    {
        try {
            $demoRepository = $this->getConnection('read')->getRepository('Welcome:Repository:Demo');
        } catch (\Exception $e) {
            return 'fail';
        }

        $demoRepository->update(['name' => 'jan'], ['id' => 1]);
        // update table set `name` = 'jan' where `id` = 1;

        return 'ok';
    }
}
```

> 插入与更新在 2.0 版本中均使用 `save` 方法代替

##### 自定义查询

```php
createQuery($sql): FastD\Database\Driver
```

示例:

```php
<?php

namespace Welcome\Events;

use FastD\Framework\Events\BaseEvent;

/**
 * Class Index
 *
 * @package Welcome\Events
 */
class Index extends BaseEvent
{
    public function welcomeAction(Request $request)
    {
        try {
            $demoRepository = $this->getConnection('read')->getRepository('Welcome:Repository:Demo');
        } catch (\Exception $e) {
            return 'fail';
        }

        $demoRepository
            ->createQuery('select * from table where id = :id')
            ->setParameter(['id' => 1])
            ->getQuery()
            ->getOne()
        ;
        // update table set `name` = 'jan' where `id` = 1;

        return 'ok';
    }
}
```

通过 `createQuery` 创建一个预查询语句, 其实现与 `PDO` 一样, 内部就是调用 `PDO` 的预处理.

通过 `getQuery` 执行绑定.

绑定后可以根据内容获取不同的返回值:

```php
getQuery()->getOne();
getQuery()->getAll();
getQuery()->getLastId();
getQuery()->getAffectedRows();
```

`Repository` 内部业务实现均使用 `Connection` 数据库驱动实现, 具体请看 [curd]()

##### 获取 `Repository` 数据库链接

```php
getConnection(): FastD\Database\Driver
```

获取数据库驱动后, 可以对数据库驱动进行直接操作.

详情请移步到: [database]()