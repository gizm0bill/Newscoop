<!-- _tpl/noticeboard_announcement.tpl --> 
{{ list_articles length="3" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is pinnwand" }}  
{{ if $gimme->current_list->at_beginning }}
  <article>
      <header>
          <p>Storyboard</p>
      </header>
      <ul class="item-list side-icons-list">      
{{ /if }}
        <li class="pinwand">
          <b>{{ $gimme->article->name }}</b> {{*<small>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y, %H:%i" }}</small><br />*}}
          {{ $gimme->article->teaser|strip_tags|truncate:100 }}
        </li>

{{ if $gimme->current_list->at_end }}
      </ul>
      <footer>
          <a href="{{ url options="article" }}">Zur &Uuml;bersicht</a>
      </footer>
  </article>
{{ /if }} 
{{ /list_articles }} 
<!-- / _tpl/noticeboard_announcement.tpl -->
