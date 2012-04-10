{{ strip }}
<article>

{{ if $gimme->article->type_name == "news" }}
  <header>
    <p>Autoren</p>
  </header>
   
  <ul class="people-list">
    {{ list_article_authors }}                     
      <li>
        <p><b><span>{{ $gimme->author->name|jsencode }}</span> ({{ $gimme->author->type|jsencode }})</b></p>
        
        {{ if $gimme->author->picture->imageurl }}
          <figure>
            <img src="{{ $gimme->author->picture->imageurl }}" alt="Portrait {{ $gimme->author->name|jsencode }}" width=60/>
          </figure>
        {{ /if }}
        
        {{ if strip_tags($gimme->author->biography->text) }}
          <blockquote>
            <p>{{ $gimme->author->biography->text|bbcode|jsencode }}</p>
          </blockquote>
        {{ /if }}
        
      </li>
    {{ /list_article_authors }}
  </ul>
{{ /if }}

  <header>
    <p>Artikelgeschichte</p>
  </header>
  
  <p class="tag-list">
    Erstellt am: <br />
    <span>{{ $gimme->article->creation_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</span>
  </p>
    
  <p class="tag-list">
    Erstmals ver&ouml;ffentlicht: <br />
    <span>{{ $gimme->article->publish_date|camp_date_format:"%e.%c.%Y - %H:%i" }}</span>
  </p>
  
  <p class="tag-list">
    Letzte &Auml;nderungen: <br />
    <span>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y - %H:%i" }}</span>
  </p>
  
  {{ if strip_tags($gimme->article->history) }}
    <p class="tag-list">
      Verlauf:<br />
      <span>{{ $gimme->article->history|jsencode }}</span>
    </p>
  {{ /if }}
  
  {{ if strip_tags($gimme->article->sources) }}
    <header>
      <p>Quellen</p>
    </header>
    <span>{{ $gimme->article->sources|jsencode }}</span>
  {{  /if }}
  
  <header>
    <p>Webcode</p>
    <span>{{ $gimme->article->webcode|jsencode }}</span>
  </header>
  
  
</article>
{{ /strip }}
