{{* includes from src/data/article.tpl.js *}}

new Ext.Carousel({
  id: 'articleimages_{{ $gimme->article->number }}',
  number: {{ $gimme->article->number }},
  type: 'carousel',
  title: 'Images',

  iconCls: 'image',
  indicator: true,
  scroll: false,
  items: [
  {{ list_article_images }}
    new Ext.Panel({
      scroll: 'vertical',
      layout: 'fit',
      html: {{ strip }}
            '<figure class="carousel">
              <div class="blog-images">
                <img src="{{ uri options="image width 980" }}" rel="resizable" alt="">
                <div class="blog-carousel-closer">
                  <img src="{{ url static_file="mobile/resources/img/carousel-close.png" }}" title="Bilderstrecke schliessen" alt="Icon Bilderstrecke schliessen" onClick="app.Main.ui.onArticleImage()">
                </div>  
              </div>
            </figure>
            '{{ /strip }},
    }),
  {{ /list_article_images }}
  ]
})
