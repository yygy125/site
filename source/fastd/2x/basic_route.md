title: 路由
---
基础路由与 1.0 版本路由不尽相似, 增加注释路由, 并且注释路由只在开发环境下生效, 生产环境注释路由需要通过命令生成缓存文件进行配置.

路由配置文件和 1.0 版本保持一致, 存放仔 `Bundle/Resources/config/routes.php` 文件中, 配置方法一致.

> 对 1.0 版本路由匹配规则进行优化.

#### get

```php
Routes::get('/', 'namespace:class@action');
```

#### post

```php
Routes::post('/', 'namespace:class@action')
```

#### put

```php
Routes::put('/', 'namespace:class@action');
```

#### delete

```php
Routes::delete('/', 'namespace:class@action');
```

如此类推...则可以完成基础的配置.

第二个参数是一个处理的映射路径,使用完整类名与方法: `namespace:class@action`

路由配置后返回一个 `Route` 对象, 可以在返回后追加路由配置, 如给路由增加格式访问

```php
Routes::get('/', 'namespace:class@action')
    ->setFormats(['json', 'php', 'html'])
;
```

可以支持三种访问格式, 其他方法以此类推. 详情请移步到: [Route]()

## 动态路由

上述说的是静态路由,在路由中也可以定义动态路由, 动态变量的表示方法: `{name}`.

变量会在路由映射的方法中自动注入

#### get

```php
Routes::get('/{name}', 'namespace:class@action')
    ->setFormats(['json', 'php', 'html'])
;
```

`name` 会以一个参数传入到 `namespace:class@action()` 当中, 原理使用了 `call_user_func_array` 函数完成.

## 路由组

路由组这里的定义跟多级域名原理有异曲同工之妙。其功能只有将各个散列的路由归纳在一起。

```php
Routes::group('/demo', function() {
    Routes::get('/', '事件绑定');
});
```

以上会解析出来: `/demo/`

路由组嵌套

```php
Routes::group('/demo', function () {
    Routes::group('/v1', function () {
        Routes::get('/', '事件绑定');
    });
});
```

解析: `/demo/v1` 或者 `/demo/v1/`

> 对于路由是以 `/` 结尾的, 自动匹配无 `/` 结尾或着有 `/` 结尾的 `pathinfo` 地址.

在路由看来, `/` 根是表示目录, 具体文件例如 `xx.txt` 表示一个有效文件. 具体可以查看我的博客: [URL 的理解](/blogs/1454754031.html)
