title: 目录
---
## 目录结构

目录结构大致与 1.0 版本没有根本上的却别, 但还是有小部分的调整.

```php
app
    -|-config  环境配置文件
     |-storage 存储目录
     |-views
         -|-errors 自定义错误信息视图
     |-application.php 应用初始化文件

bin  命令行存放目录
    console 命令行管理
public 根目录
src  项目模块源代码目录
resources 前端资源源码, 整合 gulp, react
```

## 应用模块 (Bundle)

> `Events` 模块改为 `Controller` 模块.
> `Repository` 模块迁移到 `ORM` 模块中

应用模块增加

1. 测试模块
2. orm目录
3. Standard标准模块
4. Extensions扩展模块

```
Welcome
    -|-Commands   模块自定义命令行目录
     |-Controller     模块路由映射事件目录
     |-Extensions   视图扩展模块
     |-Orm          数据库操作, ORM模块, 通过命令生成, 可以手动创建, 但不推荐
     |-Resources  模块配置文件目录及视图目录
        -|assets    模块资源, 通过命令进行映射
        -|config    模块独立配置文件
        -|orm       模块独立数据库文件
        -|views     模块视图
     |-Services     模块 Services
     |-Standard     模块标准接口
     |-Tests        模块单元测试
     |-WelcomeBundle.php   模块引导文件，每个模块都需要将引导文件注册到 Application::registerBundle 方法中
```
