title: PHP 框架与前端整合方案
---
FastD 默认使用的是 twig，因此从前端来说，twigjs 和 fastd是可以整合的，而且并且试验过，twigjs和 fastd 整合也是前后端开发一个不错的方案。

## gulp

安装 gulp: `npm install gulp --save`

## guip-twig

安装 gulp-twig: `npm install gulp-twig --save`

文档地址: [gulp-twig](https://www.npmjs.com/package/gulp-twig)

## 其他: less, compass(由前端决定)

可选安装: `npm install [options] --save`

## 环境配置

FastD: 2.0.x-dev

新建 `gulpfile.js`，编写内容:

```javascript
'use strict';
var gulp = require('gulp'),
    bundles = require('./bundles.json'),
    twig = require('gulp-twig'),
    tasks = (function (bundles) {
        var tasks = [];
        for (var i in bundles) {
            tasks.push(bundles[i].name);
        }
        return tasks;
    })(bundles)
    ;

var resources = './resources';

// todo. waiting...

/**
 * Task list.
 * */
gulp.task('default', tasks, function () {
    console.log("Tasks: " + tasks.join(','));
    console.log('Register bundles length: ' + bundles.length);
});

```

引入gulp，基础的处理，如果没有接触过 npm(Node Package Manager) 和 gulp 的同学，可能要去学习下咯: [npm](https://www.npmjs.com/) [gulp](http://www.gulpjs.com.cn/)

这里的 `require` 当中有一个 `bundles.json` 配置文件，是因为 FastD 和 Symfony 一样，模块需要注册，因此在开发环境中也需要配置相对应的配置文件，现在新建文件: `bundles.json`。文件中的所有模块按照 `app/application` 的 `registerBundles` 里面注册的模块。

bundles.json:

```json
[
    {
        "name": "welcome",
        "path": "./src/Index/Resources",
        "data": {
            "title": "test title"
        }
    }
]
```

每个 bundle 均已一个对象存在，json 你懂的。其中 `name` 表示模块名，`path` 表示模块资源所在地址，`data` 是根据 `twig` 模板中所需的 "变量"，也就是 `{{ 变量名 }}` 中所需要的变量。

再看看 gulpfile 文件，因为 FastD 中模板引擎实现两个预定义函数，所以在配置环境的时候也需要统一处理，函数分别为: `url(name, args, format)`, `asset(name, version)`，分别表示生成 url 地址，生成资源链接地址(link, script等资源地址)。

所以 gulpfile 也需要定义此函数，实现的内容根据自己喜好调整:

```javascript
var functions = [
    {
        "name": "asset",
        func: function (args) {
            return args; // todo
        }
    },
    {
        "name": "url",
        func: function (args) {
            return args; // todo
        }
    }
];
```

回头看看上面的配置，因为 `bundles` 是以一个数组的形式组成，所以我们的配置需要根据动态注册的 `bundle` 进行处理，不应该手动一个一个去操作，因为开发效率问题以及一些灵活性的问题。

循环每个 `bundle` 进行动态读取配置:

```javascript
/**
 * Register bundles.
 * */
bundles.forEach(function (bundle) {
    module.exports = function (gulp, twig, bundle) {
        var view = bundle.path + '/views';
        var asset = bundle.path + '/assets';
        var watch = bundle.name  + '.watch';
        gulp.task(watch , function() {
            console.log(bundle.name.replace(/(\w)/,function(v){return v.toUpperCase()}) + 'Bundle: task running......');
            var tpl = gulp.src(view + '/**/*.twig')
                .pipe(twig({
                    base: view,
                    data: bundle.data,
                    functions: functions
                }))
                // output html
                .pipe(gulp.dest(resources + '/' + bundle.name + '/views'))
                ;
            var js = gulp.src(asset + '/**/*.js')
                .pipe(gulp.dest(resources + '/' + bundle.name + '/js'))
                ;
            var css = gulp.src(asset + '/**/*.css')
                .pipe(gulp.dest(resources + '/' + bundle.name + '/css'))
                ;
        });

        gulp.task(bundle.name, [watch], function () {
            gulp.watch(view + '/**/*.twig', [watch]);
            gulp.watch(asset + '/**/*.css', [watch]);
            gulp.watch(asset + '/**/*.js',  [watch]);
        });
    }(gulp, twig, bundle);
});
```

以上是完整配置，包括监听文件，此处监听文件变化动态生成文件。

生成规则，存放在 `./resources` 下，按照模块名分开， `js`, `css`, `views` 目录分开，如果存在图片，也是按照 `images` 区分，自行配制即可，如此类推。

配置已经完成，新增:

`bundles.json`
`gulpfile.js`

## 正式编码

正是编码之前哆嗦几句，我们总说前后端分离，前后端分离，前后端分离，我也不知道前后端应该怎么分离，前后端为什么要分离。实际上很多人都想分离分离分离，但是想想，分离之后真的有你想象的那么好吗？我看其不然，技术本身是相辅相成的东西，其实分离了之后，虽然说负责的东西和处理的东西单一了，但是在很多时候，这并不利于一个团队以及一个项目的发展，因为这从一定基础上隔阂了大家。

我更推荐是精通一种并且懂得与其他的技术交互，这并不是分离，而是更好地将自己熟悉的东西融合到其他技术当中，并且更好地与其他技术一起工作。

前后端分离一直都是个梗，还是以团队利益最大化考虑。

### 前端

通过以上配置，前端现在只需要关注自己的代码，结构与后端一致即可，有变动需要同步到 git 并且与后端沟通

前端编写的 twig 代码存放在 `{Bundle}/Resources/views` & `{Bundle}/Resources/assets`，输出通过 gulpfile 控制，环境，数据由自己控制，摆脱后端的依赖。

当前端调整模板的时候，完全可以按照后端的变量分配方式进行处理。并且后端可以很好地兼容和操作 twig 模板。后端也可以很好地处理 twig 模板。配合 git 可谓是一个非常高效的方式。

### 后端

通过以上配置，后端现在只需要关注自己的代码，结构与前端一致即可，有变动需要同步到 git 并且与前端沟通

后端现在就可以完全不用理会前端干啥了，完全可以做自己做的工作了，当前端有变动的时候，你可以第一时间看到变化的情况，而且发现有操作不当或者需要调整的地方，可以直接调整修改，前端进行代码同步。

逻辑处理，动态变量分配都可以自由控制。

## 总结

其实为啥这样做？原理很简单，双方的工作应该自己都要清楚，但是双方之间的工作对接也更应该统一并且易于处理，也就是说，中间的那一层应该是大家都能操作，并且双方都作为监督者，一方面可以提高效率，另一方面可以提高项目、团队之间的沟通，还可以提高默契。

所以我觉得这是一个值得尝试的方案。

如果你的工作中有使用用 twig 作为模板引擎，可以根据自己的业务定制自己对应的开发环境，提高效率是咱们要去认真对待的事情。



