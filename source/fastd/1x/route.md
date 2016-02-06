title: 基础路由
---
本框架陆游组件采用自己写的 `fastd/routing`，项目地址: **[routing](https://github.com/JanHuang/routing)**

路由组件支持常用的请求方式，支持动态路由，路由参数自动追加等基础功能，按照目前来说应该能够满足使用需求，若在使用过程中发现问题及做得不够好的地方，请及时反馈给我，我会在短时间内修复。

如果你有兴趣一起维护，我更加欢迎

## 基础路由

路由这里就是简单几个配置，没有像 `TP` 一样的需要配置，这里就是一个种方式。

### <a name="header-c16" class="md-header-anchor"></a>get

<pre class="md-fences mock-cm" style="display:block;position:relative">Routes::get('/', '事件绑定');</pre>

### <a name="header-c18" class="md-header-anchor"></a>post

<pre class="md-fences mock-cm" style="display:block;position:relative">Routes::post('/', '事件绑定')</pre>

### <a name="header-c20" class="md-header-anchor"></a>put

<pre class="md-fences mock-cm" style="display:block;position:relative">Routes::put('/', '事件绑定');</pre>

如此类推...则可以完成基础的配置

## 动态路由

## 路由组

路由组这里的定义跟多级域名原理有异曲同工之妙。其功能只有将各个散列的路由归纳在一起。

基础使用:

<pre class="md-fences mock-cm" style="display:block;position:relative">Routes::group('/demo', function() {
	Routes::get('/', '事件绑定');
});</pre>

路由组嵌套

<pre class="md-fences mock-cm" style="display:block;position:relative">Routes::group('/demo', function () {
	Routes::group('/v1', function () {
    	Routes::get('/', '事件绑定');
    });
});</pre>

bingo，完成基础的配置。