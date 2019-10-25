{%- if theme.google_analytics.tracking_id %}
  {%- if not theme.google_analytics.only_pageview %}
    <script async src="https://www.googletagmanager.com/gtag/js?id={{ theme.google_analytics.tracking_id }}"></script>
    <script>
      function pushGtag() {
        if (!CONFIG.page.isLocalhost || !{{ theme.google_analytics.localhost_ignored }}) {
          console.log('开始 Google Analytics 统计');
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
          gtag('config', '{{ theme.google_analytics.tracking_id }}');
        } else {
          console.log('停止 Google Analytics 统计');
        }
      }
      document.addEventListener('pjax:complete', pushGtag);
      pushGtag();
    </script>
  {%- endif %}
  {%- if theme.google_analytics.only_pageview %}
    <script>
      function sendPageView() {
        if (CONFIG.page.isLocalhost && {{ theme.google_analytics.localhost_ignored }}) {
          console.log('停止 Google Analytics 计数');
          return;
        }
        console.log('开始 Google Analytics 计数');
        var uid = localStorage.getItem('uid') || (Math.random() + '.' + Math.random());
        localStorage.setItem('uid', uid);
        navigator.sendBeacon('https://www.google-analytics.com/collect', new URLSearchParams({
          v  : 1,
          tid: '{{ theme.google_analytics.tracking_id }}',
          cid: uid,
          t  : 'pageview',
          dp : encodeURIComponent(location.pathname)
        }));
      }
      document.addEventListener('pjax:complete', sendPageView);
      sendPageView();
    </script>
  {%- endif %}
{%- endif %}
