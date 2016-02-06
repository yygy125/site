title: 自定义查询
---
想做删除是吗，这里我就告诉你，删除方法我不提供，但是我提供一个自定义`sql` 的方法给你们，你在这里写 `delete` 就行了，不过还是那句老话，不建议。

默认提供一个 `createQuery` 方法，其实现方式是 `\PDO` 的 `prepare` 语句绑定方法。

`createQuery($sql)`

*   `sql`

    自定义的 sql 语句，支持参数绑定。

`setParameters(name, value)`

*   `name`

绑定参数，但不需要加上 `:`

*   `value`

    绑定参数的值

`getQuery()`

产生预查询信息

`getOne`

获取一条查询语句

`getAll`

获取查询列表

`getLastId`

获取最后插入的ID

`getAffectedRow`

获取执行的影响行数

Demo:

<pre class="md-fences mock-cm" style="display:block;position:relative">$this->createQuery('select fields from tablename')->getQuery()->getOne()
$this->createQuery('select fields from tablename')->getQuery()->getAll()
$this->createQuery('update tablename set fileds = value')->getQuery()->getAffectedRow()
$this->createQuery('insert into table (fields) values (values)->getQuery()->getLastId()</pre>