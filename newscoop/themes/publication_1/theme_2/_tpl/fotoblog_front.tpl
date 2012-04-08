<!-- _tpl/fotoblog_front.tpl -->
<article>
  <header>
      <p>Bildstoff</p>
  </header>
<div class="loader" style="height:154px">
  <ul class="photo-blog-list jcarousel-skin-photoblog">
  {{ list_articles length="12" ignore_publication="true" ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="type is blog issue is 3 section is 200" }}
      <li><a href="{{ url options="article" }}"><img src="{{ url options="image 1 width 170 height 115 crop center" }}" rel="resizable" alt="" /></a></li>
{{ /list_articles }}      

  </ul>
<div class="loading" style="height:154px"></div></div>
</article>
<!-- / _tpl/fotoblog_front.tpl -->
