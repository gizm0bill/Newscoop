<page backtop="18mm" backbottom="10mm" backleft="15mm" backright="15mm">
  <page_header>
    <table>
    <tr>
      <td><img src="themes/publication_1/theme_2/_css/tw2011/img/tw-logo-print.png"></td>
    </tr>
    </table>
  </page_header>
  <table style="width:95%;">
  <tr>
    <td>
      <h2>{{ $gimme->article->name|replace:'  ':'<br />' }}</h2>
      <p>{{ $gimme->article->last_update|camp_date_format:"%e.%c.%Y, %H:%i" }}Uhr</p>
    {{ if $gimme->article->type_name == 'news' }}
      <p><strong>{{ $gimme->article->lede|strip_tags }}</strong>
    {{ elseif $gimme->article->type_name == 'newswire' }}
      <p><strong>{{ $gimme->article->DataLead|strip_tags }}</strong>
    {{ /if }}
        Von {{ list_article_authors }}{{ $gimme->author->name }}{{ if $gimme->current_list->at_end}}{{ else }}, {{ /if }}{{ /list_article_authors }}</p>

      {{ if $gimme->article->image1->defined }}
      <p><img src="{{ $gimme->article->image1->filerpath }}"></p>
      {{ /if }}
    </td>
  </tr>
  </table>
  <div style="width:95%;line-height:150%;">
  {{ if $gimme->article->type_name == 'news' }}
    {{ $gimme->article->body }}
  {{ elseif $gimme->article->type_name == 'newswire' }}
    {{ $gimme->article->DataContent }}
  {{ /if }}
  </div>
  <page_footer>
  <table style="width:95%;">
  <tr>
    <td style="margin-top:20px;font-size:10px;text-align:right;text-decoration:none;">URL: <a href="http://{{ $gimme->publication->site }}{{ uri }}">http://{{ $gimme->publication->site }}{{ uri }}</a></td>
  </tr>
  </table>
  </page_footer>
</page>
