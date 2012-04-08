{{* includes from src/data/article.tpl.js *}}
{{ foreach $gimme->article->slideshows as $slideshow name="slideshow" }}
  new Ext.Carousel({
    id: 'articleslideshow_{{ $gimme->article->number }}_{{ $smarty.foreach.slideshow.iteration }}',
    number: {{ $gimme->article->number }},
    type: 'carousel',
    title: 'Images',
  
    iconCls: 'image',
    indicator: true,
    scroll: false,
    items: [
    
      {{ foreach $slideshow->items as $item }}
        {{ if $item->is_image }}
        new Ext.Panel({
          scroll: 'vertical',
          layout: 'fit',
          html:  '{{ strip }}
                  <div class="center">
                    <figure class="carousel">
                      {{ if $item->is_image }}
                        <div class="relative">
                          <img src="{{ $item->image->src }}" rel="resizable" class="max-width" />
                          <div class="carousel-closer">
                            <img src="{{ url static_file="mobile/resources/img/carousel-close.png" }}" title="Bilderstrecke schliessen" alt="Icon Bilderstrecke schliessen" onClick="app.Main.ui.onArticleSlideshow()">
                          </div>  
                        </div>
                        <p class="left">
                          {{ if trim($item->image->caption) }}{{ $item->image->caption|jsencode }}&nbsp;&nbsp;{{ /if }}
                          {{ if trim($item->image->photographer) }}<small style="display: inline">(Bild: {{ $item->image->photographer|jsencode }})</small>{{ /if }}
                        </p>
                      {{ else }}
                        {{ video_player video=$item->video }}
                      {{ /if }}
                    </figure>
                  </div>
                  {{ /strip }}',
        }),
        {{ /if }}
      {{ /foreach }}
    
    ]
  }),
{{ /foreach }}