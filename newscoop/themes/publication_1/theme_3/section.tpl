{{ if $gimme->issue->number == 1 }}
  {{ if $gimme->section->number == 5 }}
    {{ render file="_section/section_fokus.tpl" }}
  {{ /if }}  
{{ else }}
  {{ if $gimme->section->number lte 60 }}
    {{ render file="_section/section-standard.tpl" }}
  {{ elseif $gimme->section->number == 71 }}
    {{ render file="_section/section_events.tpl" }}
  {{ elseif $gimme->section->number == 72 }}
    {{ render file="_section/section_movies.tpl" }}
  {{ /if }}
{{ /if }}
