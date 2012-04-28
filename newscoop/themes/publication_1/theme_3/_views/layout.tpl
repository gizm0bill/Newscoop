{{ include file="_tpl/_html-head.tpl" }}
<body>
    {{block head}}{{/block}}
	<div id="wrapper">
    {{ include file="_tpl/header-omnibox.tpl" }}
    {{ include file="_tpl/header.tpl" }}
        <div class="content-box clearfix {{block content_classes}}reverse-columns filter-content{{/block}}">
        {{block content}}{{/block}}
        </div>
    </div><!-- / Wrapper -->
     <div id="footer">
        {{ include file="_tpl/footer-calendar.tpl" }}
        {{ include file="_tpl/footer.tpl" }}
    </div><!-- / Footer -->
{{ include file="_tpl/_html-foot.tpl" }}
