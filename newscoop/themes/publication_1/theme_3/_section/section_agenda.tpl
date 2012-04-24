{{ include file="_tpl/_html-head.tpl" }}

<body>

  <div id="wrapper">
      
{{ include file="_tpl/header-omnibox.tpl" }}

{{ include file="_tpl/header.tpl" }}
        
{{ include file="_ausgehen/subnav.tpl" }}

Silver-enda

{{ include file="_tpl/_html-foot.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{* include file="_tpl/_footer_javascript.tpl" *}}
<link rel="stylesheet" href="{{ $view->baseUrl('js/jquery/fancybox/jquery.fancybox-1.3.4.css') }}" type="text/css" media="screen" />
<script type="text/javascript" src="{{ uri static_file='_js/libs/jquery.address.js' }}"></script>
<script type="text/javascript" src="{{ uri static_file='_js/libs/fancybox/jquery.fancybox-1.3.4.pack.js' }}"></script>

</body>
</html>
