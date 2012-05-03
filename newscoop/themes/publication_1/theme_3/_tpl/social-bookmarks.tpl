<div class="social-network-box clearfix">
    <div id="social_bookmarks" class="left"></div>
    <p class="right">
        <span class="multiple">
            <a href="#" onclick="window.print();return false" class="grey-button print"><span>Print</span></a>
            <a href="{{$view->url(['controller' => 'article-recommendation', 'action' => 'index', 'article_number' => {{$gimme->article->number}}], 'default')}}" class="grey-button mail iframe" id="article-recommend-button"><span>Mail</span></a>
        </span>
        <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=sourcefabric"></script>
    </p>
</div>