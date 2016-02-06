title: 基础操作
---
CURD其实就是增删改查，[create，update，read，delete]

其中重点说一下delete操作。

破坏总比创建要来得容易，所以在进行任何一些删除操作的时候，一定要打醒120分的精神啊，不然就很容易毁于一旦了，特别对于大访问量和大量数据的，哪怕是中断数秒钟，那损失也不是你能想象的，所以 `FastD\Database\Database` 默认本身不提供`delete` 操作，如果你一定要delete，也可以，待会讲你知。

驱动内部维护一个链接，链接基于 `\PDO` 创建，提供底层操作。

### <a name="header-c356" class="md-header-anchor"></a>Read

`find(table, where, fields)` 获取一条数据

*   `table`

表名

*   `where`

查询条件，仅支持简单查询条件 `['name' => 'jan']` 或者 `['AND' => ['name' => 'jan', 'age' => 22]]`

*   `fields`

查询字段，数组类型

`findAll(table, where, fields)` 获取查询列表， 参数和以上一样

### <a name="header-c481" class="md-header-anchor"></a>Update

`update(table, data, where)` 更新数据并获取影响行数

*   `table`

    表名

*   `data`

更新的数据

*   `where`

更新条件

### <a name="header-c430" class="md-header-anchor"></a>Insert

`insert(table, data)` 插入一条数据

*   `table`

表名

*   data

    带插入的数据

其他不太像废话太多，相信以大家的才华美貌，应该一看就看得懂，所有源代码都在 `FastD\Database` 项目中。

项目地址: [github](https://github.com/JanHuang/database) [coding](https://coding.net/u/janhuang/p/database/git)

其他会日后维护时候慢慢补充