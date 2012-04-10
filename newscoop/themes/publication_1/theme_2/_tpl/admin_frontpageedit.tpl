{{ if $gimme->user->is_admin }}
<!-- _tpl/admin_frontpageedit.tpl -->
<a style="text-decoration: none; border: 1px solid #ddd; position:absolute; color: #000; padding: 1px 3px; background:yellow; font-family:sans; font-size:8px;"
href="https://{{ $gimme->publication->site }}/admin/articles/edit.php?f_publication_id={{ $gimme->publication->identifier }}&f_issue_number={{ $gimme->issue->number }}&f_section_number={{ $gimme->section->number }}&f_article_number={{ $gimme->article->number }}&f_language_id=5&f_language_selected=5" target="_blank" 
style="" title="Artikel editieren">
&para;
</a>
<!-- / _tpl/admin_frontpageedit.tpl -->
{{ /if }}