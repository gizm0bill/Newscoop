<div class="social-network-box clearfix">
    <div id="social_bookmarks" class="social_bookmarks left"></div>
    <p class="right mobile-hide">
        <span class="multiple">
            <a href="#" onclick="window.print();return false" class="grey-button print"><span>Print</span></a>
            <a href="{{ $view->serverUrl() }}{{ $view->baseUrl({{ $view->url(['controller' => 'article-recommendation', 'action' => 'index', 'article_number' => {{ $gimme->article->number }}], 'default') }}) }}" class="grey-button mail" id="article-recommend-button"><span>Mail</span></a>
        </span>
    </p>
</div>
