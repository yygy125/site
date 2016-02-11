title: FastD\Http\Request
---
## 构造方法

```php
public function __construct(array $get = [], array $post = [], array $files = [], array $cookie = [], array $server = []) : void
```

### 参数

#### get

&emsp;&emsp;_GET 参数, URL QueryString, 默认为 $_GET

#### post

&emsp;&emsp;_POST 参数, request body 内容, 默认为 $_POST

#### files

&emsp;&emsp;_FILES 参数, 上传文件内容, 默认为 $_FILES

#### cookie

&emsp;&emsp;Cookie, 默认为 $_COOKIE

#### server

&emsp;&emsp;服务器信息, 默认 $_SERVER

### 返回值

&emsp;&emsp; void

-----------------

