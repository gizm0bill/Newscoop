{{ if $gimme->issue->number == 1 }}
  {{ if $gimme->section->number == 5 }}
    {{ render file="_section/section_fokus.tpl" }}
  {{ /if }}  
{{ else }}
  {{ if $gimme->section->number lte 50 }}
    {{ render file="_section/section_standard.tpl" }}
  {{ elseif $gimme->section->number == 71 }} 
    {{ render file="_section/section_events.tpl" }}
  {{ elseif $gimme->section->number == 72 }}
    {{ render file="_section/section_movies.tpl" }}
  {{ elseif $gimme->section->number == 80 }}
    {{ render file="_section/section_dialog.tpl" }}
  {{ elseif $gimme->section->number == 81 }}
    {{ render file="_section/section_debatte.tpl" }}
  {{ elseif $gimme->section->number == 82 }}
    {{ render file="section_newsticker.tpl" }}
  {{ elseif $gimme->section->number == 90 }}
    {{ render file="section_swissinfo.tpl" }}
  {{ /if }}
{{ /if }}
