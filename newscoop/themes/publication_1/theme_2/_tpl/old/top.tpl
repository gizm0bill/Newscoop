
<div class="grid_2">
{{ include file="_tpl/top-login.tpl" }}
</div><!-- grid_2 -->
<div class="grid_1 omega">
  <a href="http://{{ $gimme->publication->site }}/?tpl=1341">RSS Feed</a>
</div><!-- grid_1 -->
<div class='clear'>&nbsp;</div>

<div class="grid_2">
  <a href="http://{{ $gimme->publication->site }}" title="{{ $gimme->publication->name }}"><img src="{{ url static_file='_img/tageswoche.png' }}" alt="{{ $gimme->publication->name }}"></a>
</div><!-- grid_2 -->
<div class="grid_1 omega">
  {{$smarty.now|camp_date_format:"%M %e, %Y"}}
</div><!-- grid_1 -->
<div class='clear'>&nbsp;</div>

{{ include file="_tpl/top-nav.tpl" }}  

