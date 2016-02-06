title: 安装
---
`FastD` 没有提供源码下载，因为我不想你用了本框架还不知道 `composer` 是用来干嘛的，那我这个初衷就失败了，虽然过程是非常坎坷，但是我还是希望各位开发者可以多学习一些，多点打破常规去思考，去实践。

* * *

### 环境要求

框架默认需要PHP5.4以上版本环境，部分组件可能已经升级到5.5了，所以建议环境时5.5欢迎以上。

数据库使用 `\PDO` 驱动，所以要确保编译安装PHP的时候开启 `PDO` 模块。

而2015年的PHP7已经在计划开发当中，敬请期待......

* * *

首先你可以查看框架的版本信息

`composer -vvv show fastd/fastd`

根据想安装的版本进行安装

`composer -vvv create-project fastd/fastd [path/to] [version]`

将框架安装到 `[path/to]` 目录，指定安装 `[version]` 版本，如: `1.0.4`

* * *

安装成功后访问 `public/dev.php`，成功得出官网首页。[http://www.fast-d.cn/](http://www.fast-d.cn/)

框架已经成功运行。

根路径默认访问: `Welcome\Events\Index@welcomeAction`。欢迎模块包下的。`Welcome\Events\Index` 类的 `welcomeAction` 方法。详情请看对应的方法内容。