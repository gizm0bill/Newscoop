{{* _tpl/article_map-sidebar.tpl *}}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <!-- Load jQuery -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
    <script>window.jQuery || document.write("<script src='{{ uri static_file="_js/libs/jquery.min.js" }}'>\x3C/script>")</script>
</head>
<body style="margin: 0; padding: 0;" >
{{ strip }}
{{ if $gimme->article->has_map }}
{{ $gimme->article->name }} has map
  {{ if $position eq 'sidebar' }}
    {{ map show_locations_list="true" show_reset_link=false  auto_focus=false width="100%" height="250" }}
  {{ /if }}
{{ /if }}
{{ /strip }}
</body>
</html>
{{* / _tpl/article_map-sidebar.tpl *}}