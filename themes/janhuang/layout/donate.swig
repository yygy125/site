<div id="content-wrap">
  <div id="content" class="wrapper">
    <div id="content-inner">
      <article class="article-container" itemscope itemtype="http://schema.org/Article">
        <div class="article-inner">
          <div class="article">
            <div class="inner">
              <div class="article-content" itemprop="articleBody" style="text-align: center;">
                <img src="{{ url_for('images/donate.png') }}" class="donate-img" style="max-width: 250px;">
                {{ page_anchor(page.content) }}
              </div>
              {{ partial('partial/comment') }}
            </div>
          </div>
        </div>
      </article>
    </div>
  </div>
</div>
