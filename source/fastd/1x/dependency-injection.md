title: 依赖注入
---
事件处理方法对象自动注入

还是拿回刚才的 `Welcome` 模块

注入 `FastD\Protocol\Http\Request` 对象

<pre class="md-fences mock-cm" style="display:block;position:relative"><?php

namespace Welcome\Events;

use FastD\Protocol\Http\Request;

class Welcome
{
	public function welcomeAction(Request $request)
    {
    	return $request->getPathInfo();
    }
}</pre>

**注意这个自动注入默认只支持路由字符串事件绑定**

在绑定的事件处理方法中就可以通过这种方式进行注入，方便快捷，而且使程序更加优雅。

其他注入一样的道理，如果自定义对象，也可以通过这种注入方法注入。非常简单

如果你有更好的想法，欢迎和我交流