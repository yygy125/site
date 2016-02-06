title: Nginx 动态添加模块
---
#Nginx 动态添加模块

> 这个在工作中遇到的其中一个活生生的例子，因为 `nginx` 在编译安装的时候并没有考虑太多，而且我一向的做法都是按照项目需要安装相应的功能，尽量让服务和应用简洁。

我一向的作风:

```
./configure --prefix=/path/to/nginx
```
😂 是不是够简洁，仅仅一个安装路径。如果兄弟们觉有欠妥的话，请直接批评我，谢谢。

广告回来继续。

......

成功将 `nginx` 安装完， 然后可以将二进制的 `nginx` 管理脚本配置到系统 `PATH` 或者做个软链接到出来。

`/path/to/nginx/sbin/nginx` 启动 `ngin`。

因为当时系统服务需要支持 `https`, 所以以上的配置炸了，根本不支持，所以就得动态给 `nginx` 添加ssl证书的支持。

首先要确保系统的 `openssl` 有正常安装。没有安装的朋友也不要灰心，只需要安装一下就好了。

```
yum install -y openssl-devel
```

确认安装完成以后，查看一下 `nginx` 当初的配置 `/path/to/nginx -V`

然后回到以前的 `nginx`, 复制一下刚才的配置信息 `./configure --prefix=/path/to/nginx --with-http_ssl_module`

保留自己一贯的作风。 😂

然后 `make`， 记得不要 `make install` 不要 `make install` 不要 `make install`!!! 重要的事情说三遍

然后这里是需要停掉 `nginx` 服务，才能覆盖二进制的管理脚本。

复制 `cp objs/nginx /path/to/nginx/sbin/`

覆盖即可。

查看: `nginx -v`
