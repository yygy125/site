title: URL 的理解
---
# URL 的理解

维基百科给出答案

** URL（全名Uniform Resource Locator），又譯劃一資源定位器，俗稱網頁地址（網址），係互聯網上標準嘅資源嘅地址。要去互聯網上任何一個地方，都需要佢嘅URL。 **

首先咱们要理解这个叫资源定位的意思，咱们平时在配置部署 web 服务器的时候，应该都有见过 document root 这个配置项，以 nginx 为例，nginx 中，就是需要配置一个 `root` 选项，而每个 server 都对应一个 server_name，或是域名，或是ip，一个标示，那这个 server_name 其实可以简单地把它看成是 `root` 的别名，当访问到这个 server_name 的时候，就会自动在 `root` 目录下进行查询。如：

```
server {
    server_name test.com
    root /htdocs
    # some config
}
```

当访问到 `http://test.com` 的时候，就会去到 `/htdocs` 目录下寻找目标。

`http://test.com/a.html` => `/htdocs/a.html`
`http://test.com/public/a.html` => `/htdocs/public/a.html`

这个是最基本的方法，当然你可以在 server 中配置其他，这里不再阐述。

其实说白了，他只是一个 “资源定位” 的作用。

很明显地，其实这里寻找的是 html 文件，也可以寻找 json，xml 文件，如：

`http://test.com/a.json` => `/htdocs/a.json`
`http://test.com/public/a.xml` => `/htdocs/public/a.xml`

其实都是一样，只要理解了 “资源定位”，那么其实，URL 就是访问一个文件内容，至于这个 “文件” 内部怎么执行，就需要自己定义了。

### Http Api 设计

那么既然理解了上述的 URL 的意义，那么设计 API 起来就很好做了，所谓的 RESTful API 设计，其实我的理解无非就是让你清楚 URL 的作用，然后对应地给不同的 “文件” 进行操作。

####1. 文章的获取：

Host: http://test.com

#####1.1 文章列表

```
http://test.com/articles/{page}

http://test.com/articles/1
http://test.com/articles/2
```

#####1.2 文章详情

```
http://test.com/articles/{page}/{id}.{format}

http://test.com/articles/1/3.html
http://test.com/articles/2/12.json
```

以上理解为：

http://test.com/articles/1/3.html 这个地址定位到: /htdocs/articles/1/3.html
http://test.com/articles/2/12.json 这个地址定位到: /htdocs/articles/2/12.json

很好理解吧，这样设计出来的 API 其实可以收是一目了然。在资源后缀上，是可以自己定义的，如 [FastD](https://github.com/JanHuang/fastD) 中就有此项功能，可以根据不同后缀返回不同的内容格式。

以上仅是个人理解及想法，欢迎指点与批评。


