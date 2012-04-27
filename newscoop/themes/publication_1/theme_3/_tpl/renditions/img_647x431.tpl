{{ strip }}
{{ image rendition="artikelnew" }}
<img src="{{ $image->src }}" width="" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}