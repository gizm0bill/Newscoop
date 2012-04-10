<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <link rel="shortcut icon"  href="{{ url static_file="favicon.ico" }}" />
    
{{ local }}
  {{* keep it, see WOBS-1023 *}}
  {{ set_publication identifier="1" }}
{{ /local }}

    <title>TagesWoche</title>
    
    <link rel="stylesheet" href="{{ url static_file="mobile/resources/css/tageswoche.css" }}?$Id$" type="text/css">
    
    <script type="text/javascript" src="{{ url static_file="mobile/src/googleanalytics.js" }}?$Id$"></script>
    <script type="text/javascript" src="{{ url static_file="mobile/lib/sencha-touch-1.1.1/sencha-touch-debug.js" }}"></script>
    <script type="text/javascript" src="{{ url static_file="_js/cookie.js" }}?$Id$"></script>
    <script type="text/javascript" src="{{ url options="template mobile/src/autotheme.tpl.js" }}&amp;$Id$"></script>    
    <script type="text/javascript" src="{{ url options="template mobile/src/cardPanel.tpl.js" }}&amp;$Id$"></script>
    <script type="text/javascript" src="{{ url options="template mobile/src/index.tpl.js" }}&amp;$Id$"></script>
    <script type="text/javascript" src="{{ url options="template mobile/src/structure.tpl.js" }}&amp;$Id$"></script>
     
</head>
<body></body>
</html>
