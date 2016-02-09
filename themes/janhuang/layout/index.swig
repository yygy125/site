<header id="banner" class="wrapper">
  <div class="inner">
    <h2 id="banner-title">{{ page.subtitle }}</h2>
    <div id="banner-start">
      <span id="banner-start-command">composer create-project "fastd/fastd:2.0.x-dev" fastd -vvv</span><a id="banner-start-link" href="fastd/"><i class="fa fa-arrow-right"></i></a>
    </div>
    {#<div id="banner-share">{{ partial('partial/share') }}</div>#}
  </div>
</header>
<div id="content-wrap">
  <div class="wrapper">
    <div class="inner">
      {{ page.content }}
      <div id="intro-get-started-wrap">
        <a href="/fastd/1x/" id="intro-get-started-link">{{ __('index.get_started') }}</a>
      </div>
    </div>
  </div>
</div>