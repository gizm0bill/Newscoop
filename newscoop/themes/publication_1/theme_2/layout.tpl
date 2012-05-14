{{ include file="_tpl/_html-head.tpl" }}
<body>
        <div id="wrapper">

        <div class="content-box top-content-fix clearfix members"> {{* changed class 'profile' with class 'members' (LjR) *}}
                    
{{ include file="_tpl/navigation_top.tpl" }}

<div id="main-nav" class="clearfix">

{{ include file="_tpl/navigation.tpl" }}

{{ include file="_tpl/search_box.tpl" }}                         

</div>

{{block content}}{{/block}}
            
</div>
        

{{* COMMUNITY AVATARS *}}
{{ include file="_tpl/avatars_front.tpl" }}

{{* FOOTER *}}
{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Wrapper -->   

{{* JAVASCRIPT FOOTER *}}
{{ include file="_tpl/_footer_javascript.tpl" }}

</body>
</html>
