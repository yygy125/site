title: 查询分页
---
分页查询

默认数据提供一个分页的查询，并对此进行了一些优化查询

`pagiantion(table, page, show, lastId)`

*   `table`

    表名

*   `page`

    当前页码

*   `show`

每页查询多少条数据

*   `lastId`

该页最后查询到的id，用户下一页偏移量

查询返回一个`FastD\Database\Pagination\QueryPagination` 对象，通过 `getResult`方法获取查询的列表结果。

对象包含的方法比较多，大家可以查询对象源代码进行参考，比较简单，不字一一叙述