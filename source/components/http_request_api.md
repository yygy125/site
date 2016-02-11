title: FastD\Http\Request
---
## __construct()

```php
public function __construct(array $get = [], array $post = [], array $files = [], array $cookie = [], array $server = []) : void
```

构造方法, 创建一个请求处理

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

## initialize()

```php
public function initialize(array $get = [], array $post = [], array $files = [], array $cookie = [], array $server = []): void
```

与构造方法保持一致

## createRequestHandle()

```php
public static function createRequestHandle(): FastD\Http\Request
```

不支持自定义参数注入, 目前仅以构造方法参数为准, 后期配置自定义参数.

## createRequest()

```php
public function createRequest($url, array $arguments = array(), $timeout = 3): FastD\Http\RequestLauncher
```

## getContent()

```php
public function getContent(): resource|string
```

获取请求内容, POST|PUT, 通过 `file_get_contents('php://input');` 实现

## getUserAgent()

```php
public function getUserAgent(): string
```

获取 `User-Agent` 信息, 可以通过 `User-Agent` 对客户端进行一定的判断.

## getSchemeAndHost()

```php
public function getSchemeAndHost(): string
```

获取 `Scheme` 和 `Host` 地址.

## getScheme()

```php
public function getScheme(): string
```

获取 `Scheme`

## getHost()

```php
public function getHost(): string
```

获取域名地址

## isSecure()

```php
public function isSecure(): bool
```

判断是否 `Secure`, 也就是 `https` 请求

## getClientIp()

```php
public function getClientIp(): string
```

获取请求客户端 ip 地址, ip 地址有可能是多个的, 例如: 192.168.0.1,192.168.1.11, 多个以 `,` 号隔开


