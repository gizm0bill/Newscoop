{{ if !$section }}
{{ assign var="required_switch" value="Front_page" }}
{{ else }}
{{ assign var="required_switch" value=$section|strip }}
{{ /if }}

{{ local }}
{{ set_publication identifier=1 }}
{{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 2 section is 20 $required_switch is on type is advertisment" }}
  {
    number: {{ $gimme->article->number }},
    name:   '{{ $gimme->article->name|jsencode }}',
    url:    '{{ capture assign="url" }}{{ url options='article' }}{{ /capture }}{{ $url|jsencode }}',
    link:   '{{ $gimme->article->ad_link|jsencode }}',
    type:   'advertisement',
    text:   'Anzeige <img src="{{ uri options="image 1" }}" alt="{{ $gimme->article->ad_link|jsencode }}" style="max-width: 100%">',
    leaf:   true,
    listeners: {
      activate: function(){
        console.log('{{ $gimme->article->ad_link|jsencode }}');
      }
    }
  },
{{ /list_articles }}
{{ /local }}