<?xml version="1.0" encoding="UTF-8" ?>
{{ list_articles length="10" ignore_issue="true" ignore_section="true" constraints="type is news" }}
  {{ if $gimme->current_list->at_beginning }}
<DDD>
  {{ /if }}
  <DD>
    <DA>{{ $gimme->article->publish_date }}</DA>
    <HT>{{ $gimme->article->name }}</HT>
    {{ list_article_attachments }}{{ if $gimme->attachment->extension == "pdf" && preg_match('/^pdesk_/', $gimme->attachment->file_name) }}<ME>pdf/{{ $gimme->attachment->file_name }}</ME>{{ /if }}{{ /list_article_attachments }}
    <RE>{{ $gimme->article->section->name }}</RE>
    {{ if $gimme->article->lead|count_characters }}
    <LD>{{ $gimme->article->lead|count_characters }}</LD>
    {{ /if }}
    <TX>{{ $gimme->article->body }}</TX>
  </DD>
  {{ if $gimme->current_list->at_end }}
</DDD>
  {{ /if }}
{{ /list_articles }}