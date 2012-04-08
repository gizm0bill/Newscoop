{{ strip }}

{{ if $gimme->article->type_name == "news" || $gimme->article->type_name == "blog" }}
  {{ foreach $gimme->article->slideshows as $slideshow name="slideshow" }}
    {{ assign var="_has_slideshow" value=true }}
    <p>
      {{ foreach $slideshow->items as $item name="image" }}
        {{ if $item->is_image && !$_passed }}
          {{ assign var="_passed" value=true }}
          <div class="inline-block">
            <div class="relative">
              <img src="{{ $item->image->src }}" rel="resizable" style="max-width: 100%" />
              <div class="carousel-opener">
                <img src="{{ url static_file="mobile/resources/img/carousel-open.png" }}" title="Bilderstrecke &ouml;ffnen" alt="Icon Bilderstrecke &ouml;ffnen" onClick="app.Main.ui.onArticleSlideshow({{ $smarty.foreach.slideshow.iteration }})">
              </div>
            </div>
          </div>
          <p>
            {{ if trim($item->caption) }}{{ $item->caption|jsencode }}&nbsp;&nbsp;{{ /if }}
            {{ if trim($item->image->photographer) }}<small style="display: inline">(Bild: {{ $item->image->photographer|jsencode }})</small>{{ /if }}
          </p>
        {{ /if }}
      {{ /foreach }}
    </p>
  {{ /foreach }}
{{ /if }}
  
{{ if !$_has_slideshow && ($gimme->article->type_name != "blog" || $gimme->article->publish_date gt "2012-01-24 00:00:00" || $gimme->article->creation_date gt "2012-01-24 00:00:00") }}
  {{ if $gimme->article->publish_date gt "2012-02-08 13:00:00" || $gimme->article->creation_date gt "2012-02-08 13:00:00" }}
    {{ image rendition="artikel" }}
      <p>
        <img src="{{ $image->src }}" rel="resizable" alt="{{ $gimme->article->image->description|jsencode }}" style="max-width: 100%" />
        <small>{{ $gimme->article->image->description|jsencode }} {{ if $gimme->article->image->photographer }}(Bild: {{ $gimme->article->image->photographer|replace:$replace:"Keystone"|jsencode }}){{ /if }}</small>
    </p>
    {{ /image }}
  {{ else }}
    {{ if $gimme->article->has_image(7) }}
      <p>
        <img src="{{ uri options="image 7" }}" rel="resizable" alt="{{ $gimme->article->image7->description|jsencode }}" style="max-width: 100%">
        <small>{{ $gimme->article->image->description|jsencode }} {{ if $gimme->article->image->photographer }}(Bild: {{ $gimme->article->image->photographer|replace:$replace:"Keystone"|jsencode }}){{ /if }}</small>
      </p>
    {{ elseif $gimme->article->has_image(1) }}
      <p>
        <img src="{{ uri options="image 1 width 555 height 370 crop center" }}" rel="resizable" alt="{{ $gimme->article->image1->description|jsencode }}" style="max-width: 100%">
        <small>{{ $gimme->article->image->description|jsencode }} {{ if $gimme->article->image->photographer }}(Bild: {{ $gimme->article->image->photographer|replace:$replace:"Keystone"|jsencode }}){{ /if }}</small>
      </p>
    {{ /if }}
  {{ /if }}
{{ /if }}

{{ /strip }}