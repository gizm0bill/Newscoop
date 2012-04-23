<!-- _tpl/img/img_300x150.tpl -->{{ strip }}
{{ image rendition="blogsidebar" }}
<img src="{{ $image->src }}" width="{{ $image->width }}" height="{{ $image->height }}" rel="resizable" style="max-width: 100%" alt="{{ $image->photographer }}: {{ $image->caption }}" />
{{ /image }}
{{ /strip }}<!-- _tpl/img/img_300x150.tpl -->
