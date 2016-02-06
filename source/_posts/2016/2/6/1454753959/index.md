title: Nginx + Lua 编译安装
---
# <a name="header-c14" class="md-header-anchor"></a>Nginx + Lua

### <a name="header-c16" class="md-header-anchor"></a>环境要求:

*   [Nginx](http://nginx.org/en/download.html)
*   [LuaJIT](http://luajit.org/download.html)
*   [ngx_devel_kit](https://github.com/simpl/ngx_devel_kit/tags)
*   [ngx_lua](https://github.com/chaoslawful/lua-nginx-module/tags)

确保在编译安装Nginx的时候已经配置完以上的依赖需求。

* * *

首先将以上的全部模块都download下来，`ngx_devel_kit` 和 `ngx_lua` 只需要download下来后解压即可，编译 `nginx` 的时候需要添加解压路径即可。我一般会放在 `/usr/local/src` 目录下

编译安装 `LuaJIT` 。

<pre class="md-fences mock-cm" style="display:block;position:relative">tar zxvf LuaJITxx.tar.gz
cd LuaJITxx.tar.gz
make
make install </pre>

* * *

编译nginx

<pre class="md-fences mock-cm" style="display:block;position:relative">./configure --prefix=path \
    --add-module=/刚才解压的ngx_lua路径 \
    --add-module=/刚才解压的ngx_devel_kit路径
make
make install</pre>

编译成功后尝试启动nginx。

有可能出现以下错误。

> nginx: error while loading shared libraries: libluajit-5.1.so.2: cannot open shared object file: No such file or directory

**注意: cannot open shared object file**

没有找到相关的对象文件。

咱们可以使用ldd查看nginx模块信息。

`ldd /nginx安装路径下的/sbin/nginx`

出现以下的映射关系:

<pre class="md-fences mock-cm" style="display:block;position:relative">linux-vdso.so.1 =>  (0x00007fff4d785000)
libpthread.so.0 => /lib64/libpthread.so.0 (0x00007feeca74a000)
libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007feeca513000)
libluajit-5.1.so.2 => not found
libm.so.6 => /lib64/libm.so.6 (0x00007feeca28e000)
libdl.so.2 => /lib64/libdl.so.2 (0x00007feeca08a000)
libpcre.so.0 => /lib64/libpcre.so.0 (0x00007feec9e5d000)
libcrypto.so.10 => /usr/lib64/libcrypto.so.10 (0x00007feec9a7a000)
libz.so.1 => /lib64/libz.so.1 (0x00007feec9864000)
libc.so.6 => /lib64/libc.so.6 (0x00007feec94cf000)
/lib64/ld-linux-x86-64.so.2 (0x00007feeca96d000)
libfreebl3.so => /lib64/libfreebl3.so (0x00007feec926d000)</pre>

发现 `libluajit-5.1.so.2 => not found` 这一行是没有找到的。所以这里咱们指定一定就行啦。

<pre class="md-fences mock-cm" style="display:block;position:relative">echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig</pre>

然后再重新启动。发现 `nginx` 已经正常起来了。

访问当然没有问题， 这个自己去尝试咯。

咱们添加一个`lua` 的 `hello world` 试试吧。

<pre class="md-fences mock-cm" style="display:block;position:relative">#some code
location /lua
{
        set $test "hello, world.";
        content_by_lua '
            ngx.header.content_type = "text/plain";
            ngx.say(ngx.var.test);
        ';
}</pre>

重启 `nginx` 访问 `server_name/lua` ，成功输出 `hello world`
