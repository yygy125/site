title: 视图操作
---
## 渲染

若要渲染模板，处理事件需要继承 `Kernel\Events\TemplateEvent`

<pre class="md-fences mock-cm" style="display:block;position:relative">render(template, array parameters)</pre>

*   `template`

    需要渲染的模板路径

*   `array parameters`

给模板分配变量， `key => value`

## 赋值

目前模板仅支持 `twig` 模板引擎驱动，默认地址是:

<pre class="md-fences mock-cm" style="display:block;position:relative">[
	app/views/
    Moduble/Resources/views
]</pre>

默认模板会在以上目录寻找。

详细参考地址: **[Twig](http://twig.sensiolabs.org/documentation)**

为甚么选择 `twig`

*   灵活

*   强大
*   快
*   好用

`twig` 可以在生产服务器添加到 `php extension中`
