title: 数据库驱动
---
通过获取一个数据库驱动链接来进行一下操作, `Repository` 操作实现均是使用一下操作实现.

##### 获取一条纪录 (find)

```php
find($table, array $where = [], array $fields = []): array|bool
```

##### 获取全部纪录 (findAll)

```php
findAll($table, array $where = [], array $fields = []): array|bool
```

##### 插入纪录 (insert)

```php
insert(array $data = []): int|bool
```

##### 更新纪录 (update)

```php
update(array $data = [], array $where = []): int|bool
```

##### 获取总纪录数

```php
count(array $where = []): int|bool
```

##### 创建一个查询 (createQuery)

```php
createQuery($sql): array|bool
```