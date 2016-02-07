title: 配置
---
## 配置文件
框架默认提供三种运行环境给您，运行入口在 `public/(dev|test|prod).php`.

三个运行入口分别对应

```
dev     本地开发环境
test    测试服务器模拟生产环境
prod    生产环境
```

运行环境对应这应用程序的环境配置文件, 本别对应:

```
app/config/config_dev.php
app/config/config_test.php
app/config/config_prod.php
```

不同环境配置不一样,为了适应开发者的调试以及习惯.

默认的开发模式和测试模式是不会纪录错误日志,而执行生产环境则会将所以错误,访问纪录日志,方便排查以及统计.

开发模式和测试模式会将所有错误信息在错误发生的时候显示给开发者