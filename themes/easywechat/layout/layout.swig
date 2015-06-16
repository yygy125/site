<!DOCTYPE html>
<html lang="{{ page.lang }}">
{{ partial('partial/head') }}
<body class="{% if is_current('/') %}home{% endif %}">
  <div id="container">
    {{ partial('partial/header') }}
    {{ body }}
  </div>
  {{ partial('partial/footer') }}
  <div id="mobile-nav-dimmer"></div>
  {{ partial('partial/mobile_nav') }}
  {{ partial('partial/after_footer') }}
</body>
</html>