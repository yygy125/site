title: 安装
---
## 环境要求

PHP >= 7

#### 可选扩展

Swoole >= 1.8

### Composer

```
composer -vvv create-project "fastd/fastd:~2.0" fastd
```

### Swoole 扩展安装

#### GitHub

获取扩展源码: [Swoole](https://github.com/swoole/swoole-src/releases)

```
cd swoole-src
/path/to/php/bin/phpize
./configure --with-php-config=/path/to/php/bin/php-config
sudo make
sudo make install
```

追加扩展信息到 `php.ini`

```
extension=swoole.so
```

查看扩展信息

```
php -m | grep swoole
php -r 'echo swoole_version();'
```

若安装失败, 请查看相关的错误信息, 进行解决.

