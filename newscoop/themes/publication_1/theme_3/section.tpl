{{ if $gimme->publication->identifier == 5 }} 
	{{ if $gimme->issue->number == 3 }}
		{{ render file="_section/section-blog.tpl" }}
	{{ /if }}
{{ elseif $gimme->issue->number == 1 }}
  {{ if $gimme->section->number == 5 }}
    {{ render file="_section/section-dossier.tpl" }}
  {{ /if }}  
{{ else }}
  {{ if $gimme->section->number lte 60 }}
    {{ render file="_section/section-standard.tpl" }}
  {{ elseif $gimme->section->number == 70 }}
    {{ render file="_section/section_agenda.tpl" }}
  {{ elseif $gimme->section->number == 71 }}
    {{ render file="_section/section_events.tpl" }}
  {{ elseif $gimme->section->number == 72 }}
    {{ render file="_section/section_movies.tpl" }}
  {{ elseif $gimme->section->number == 80 }}
    {{ render file="_section/section-dialog.tpl" }}
  {{ elseif $gimme->section->number == 81 }}
    {{ render file="_section/section-debatte.tpl" }}    
  {{ /if }}
{{ /if }}
