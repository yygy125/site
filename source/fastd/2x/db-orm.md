title: 对象关系映射(ORM)
---
一个快速的 ORM 操作, 提供快速,便捷的操作,安全无副作用. 需要使用, 发现问题几时反馈修复, 完善产品与功能.

orm目录: `Bundle/Resources/orm`, 里面存放数据库的 `yml` 配置文件.

## 数据库表结构配置

`table` 表名

`engine` 表引擎, 默认是 `innodb`

`charset` 表编码, 默认是 `utf8`

`fields` 字段, 数组类型

字段列表, 在 `fields` 配置下进行配置

`key` 代表字段的别名, 用于在查询和其他操作, 如表实例 `Entity` 和 `Repository` 中使用.

每个 `key` 对应一个字段信息

`name` 真实的字段名.

`type` 类型, 与 `mysql` 保持一致, 后将整合 `array`, `json` 等类型, 用于自动编码解码.

`length` 字段长度, 与 `mysql` 保持一致.

`comment` 注释, 与 `mysql` 保持一致.

`unsigned` 与 `mysql` 保持一致.

`key` 索引, 主键索引: `primary`, 唯一索引: `unique`, 普通索引: `index`

`notnull` `true` or `false`.

`default` 默认值, 与 `mysql` 保持一致.

配置示例: 

```yml
table: test
engine: innodb
charset: utf8
fields:
    id:
        name: id
        type: int
        length: 10
        comment: 主键
        unsigned: true
        key: primary
    trueName:
        name: true_name
        type: varchar
        length: 10
        notnull: true
    tel:
        name: tel_number
        type: char
        length: 20
        notnull: true
        default:
        comment: 手机号
        key: unique
```

配置完表后, 通过命令将表, `Entity`, `Fields` 和 `Repository` 生成.

运行命令: 

```shell
php bin/console db:update
```

生成的 `Entity`, `Fields` 和 `Repository` 会存在生成的目录当中, 在 `Bundle/Orm` 目录下, 对应会生成3个目录, 分别存放对应的信息.

可以修改 `Entity` 和 `Repository` 对象的方法和属性, `Fields` 可以适当修改, 一般情况下不需要修改.

每次使用命令生成的时候不会影响开发者自定义添加的方法和属性.

生成后就可以在控制器中使用对应的方法进行操作.

## 为已存在的表生成对象

有时候会当没有存在表配置的时候, 则需要通过现有的数据表进行映射, 创建及生成.

框架中就有一个很好用的功能, 就是对照表生成应有的 `Entity`, `Fields` 和 `Repository`. 

输入命令:

```shell
php bin/console db:revert
```

效果和生成数据表配置一样. 在 `Bundle/Orm` 目录下生成对应的目录结构及对象.

## Orm 基础操作

通过生成 `Entity`, `Fields` 和 `Repository`, 可以很方便地对数据进行操作.

> 目前仅支持基础简单的操作, 暂不支持删除操作, 建议删除操作通过状态字段进行控制.

### 使用 `Entity` 插入或者更新一条记录, 

```php
<?php

namespace Welcome\Controllers;

use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;
use Welcome\Orm\Entity\Test;

/**
 * Class Index
 *
 * @package Welcome\Controller
 */
class Index extends Controller
{
    /**
     * @Route("/orm", name="orm")
     *
     * @return Response|string
     */
    public function saveOrmAction()
    {
        try {
            $driver = $this->getDriver('read');
        } catch (\Exception $e) {
            return $this->response('fail');
        }

        $test = new Test(null, $driver);
        $test->setTrueName('janhuang');
        $test->setTel(mt_rand(0, 99999));

        return $this->response('new id: ' . $test->save());
    }
}
```

打开生成的 `Entity`, 构造方法接受两个参数, 第一个为主键 `id`, 第二个为数据库链接驱动, 通过 `getDriver` 获取返回的对象.

设置实体字段内容, 由 `set` 开头, 命名规则是驼峰式, 作为别名存在, 具体字段映射可以查看 `Orm/Fields` 下对应的表字段对象获得.

设置完字段内容后, 通过 `save` 方法进行插入或者更新, 当存在主键 `id`, 则为更新操作, 若主键 `id` 为空, 则为插入操作.

操作返回影响行数或者最后插入的 `id`.

### 使用 `Entity` 获取一行纪录

```php
<?php

namespace Welcome\Controllers;

use FastD\Database\Drivers\Query\MySQLQueryBuilder;
use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;
use Welcome\Orm\Entity\Test;

/**
 * Class Index
 *
 * @package Welcome\Controller
 */
class Index extends Controller
{
    /**
     * @Route("/orm/find/{id}", name="orm_find")
     *
     * @param int $id
     * @return Response|string
     */
    public function findOrmAction($id)
    {
        try {
            $driver = $this->getDriver('read');
        } catch (\Exception $e) {
            return $this->response('fail');
        }

        $test = new Test($id, $driver);

        return $this->response('name:' . $test->getTrueName());
    }
}
```

在初始化的时候通过赋值主键id, 会自动寻找该条纪录, 然后通过 `get` 方法进行字段获取.

## 使用 `Repository` 进行数据库操作

```php
<?php

namespace Welcome\Controllers;

use FastD\Database\Drivers\Query\MySQLQueryBuilder;
use FastD\Framework\Bundle\Controllers\Controller;
use FastD\Http\Request;
use FastD\Http\Response;
use Welcome\Orm\Entity\Test;
use Welcome\Orm\Repository\TestRepository;

/**
 * Class Index
 *
 * @package Welcome\Controller
 */
class Index extends Controller
{
    /**
     * @Route("/orm/repository/{id}", name="welcome_repository", defaults={"id": "0"})
     *
     * @param int $id
     * @return Response|string
     */
    public function repositoryAction($id)
    {
        try {
            $driver = $this->getDriver('read');
        } catch (\Exception $e) {
            return $this->response('fail');
        }

        $repository = new TestRepository($driver);

        if (empty($id)) {
            $result = $repository->findAll();
        } else {
            $result = $repository->find(['id' => $id]);
        }

        return $this->response(json_encode($result));
    }
}
```

访问指定 `repository` 路由, 就可以使用 `Repository` 进行简单的操作了, 操作方式和 `Entity` 一样.

