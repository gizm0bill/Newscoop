{{ if $gimme->issue->number == 1 }}
  {{ if $gimme->section->number == 5 }}
    {{ render file="_section/section_fokus.tpl" }}
  {{ /if }}  
{{ else }}
  {{ if $gimme->section->number lte 50 }}
    {{ render file="_section/section-standard.tpl" }}
  {{ /if }}
{{ /if }}