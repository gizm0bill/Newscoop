{{ strip }}
{{ if $gimme->article->type_name == "blog" && $gimme->section->number >= 200 }}
  {{ list_article_images }}
    <figure style="margin-bottom: 15px">
      <div class="blog-images">
        <img src="{{ uri options="image width 980" }}" rel="resizable" alt="">
        <div class="blog-carousel-opener">
          <img src="{{ url static_file="mobile/resources/img/carousel-open.png" }}" title="Bilderstrecke &ouml;ffnen" alt="Icon Bilderstrecke &ouml;ffnen" onClick="app.Main.ui.onArticleImage({{ $gimme->current_list->index - 1}})">
        </div>    
      </div>
      <p>
        {{ if trim($gimme->article->image->caption) }}{{ $gimme->article->image->caption|jsencode }}&nbsp;&nbsp;{{ /if }}
        {{ if trim($gimme->article->image->photographer) }}<small style="display: inline">(Bild: {{ $gimme->article->image->photographer|jsencode }})</small>{{ /if }}
      </p>
    </figure>
  {{ /list_article_images }}
{{ /if }}
{{ /strip }}