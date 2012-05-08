<article>
  <header>
      <p>Bildstoff<a class="mobile-arrow desktop-hide right" href="{{ local }}{{ set_publication identifier="5" }}{{ set_current_issue }}{{ set_section number="200" }}{{ url options="section" }}{{ /local }}"><span></span></a></p>
  </header>
  <ul class="flat-list mobile-carousel jcarousel-skin-mobile">
  {{ list_articles length="5" ignore_publication="true" ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="type is blog issue is 3 section is 200" }}
      <li><a href="{{ url options="article" }}"><img src="{{ url options="image 1 width 198 height 135 crop center" }}" rel="resizable" style="width: 100%" alt="" /></a></li>
{{ /list_articles }}      
  </ul>
</article>            