title: 目录
---
## 目录结构

```php
app
    -|-config  环境配置文件
     |-helpers 自定义辅助类目录
     |-kernel  框架核心文件
     |-stroage 存储目录
     |-tests 测试目录
     |-views
         -|-errors 自定义错误信息视图
         -|-welcome 欢迎页视图
     |-Application.php 应用初始化文件
     |-console  命令行控制文件 // 2.0 版本将 console 迁移到 bin 目录

bin  命令行存放目录
public 根目录
src  项目模块源代码目录
vendor 安装依赖包目录
```

## 应用模块 (Bundle)

每个"项目"对应一个模块，而且我建议模块的灵活性大于模块的整体性，可以多个模块支撑起一个大的整体，而且模块当中有适当的容错处理，降低模块与模块之间的耦合性，然而这一块目前我个人觉得还需要加强。

模块的目录位于项目的 `src` 目录，由模块名建立而成。

目前模块中仅需包含简单几个目录，目前我拿 `Welcome` 默认模块进行目录结构解析:

```
Welcome
    -|-Commands   模块自定义命令行目录
     |-Events     模块路由映射事件目录
     |-Resources  模块配置文件目录及视图目录
     |-Repository 模块数据库文件
     |-WelcomeBundle.php   模块引导文件，每个模块都需要将引导文件注册到 Application::registerBundle 方法中
```

## 模块视图 (Views)

视图的目录位置处于 `[app/views, Bundle/Resources/views]`

因此，如果想要引用和渲染模块当中的视图文件，则需要将模块的具体视图文件直接写在渲染的方法上。
