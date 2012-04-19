{{ include file="_tpl/_html-head.tpl" no_close=true }}

    <script type="text/template" id="document-article-template">
    <% if (doc.get('image')) { %><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><img src="/images/cache/<%= doc.get('image') %>" alt="" width="90" /></a><% } %>
    <h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><%= doc.escape('title') %></a></h3>
    <p><%= doc.escape('lead') %></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="document-twitter-template">
    <p><b><%= doc.escape('tweet_user_screen_name') %></b> <%= doc.getTweet() %></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="document-user-template">
    <h3><a href="{{ $view->url(['username' => ''], 'user') }}/<%= doc.escape('user') %>"><%= doc.escape('user') %></a></h3>
    <p><%= doc.escape('bio') %></p>
    </script>

    <script type="text/template" id="document-event-template">
    <h3><a href="<%= doc.get('link') %>" title="<%= doc.getEventTitle() %>"><%= doc.getEventTitle() %></a></h3>
    <p><%= doc.get('event_organizer') %> <%= doc.get('event_town') %>, <%= doc.getEventDate() %> <%= doc.getEventTime() %></p>
    </script>

    <script type="text/template" id="document-omni-template">
    <h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('subject') %>"><%= doc.escape('subject') %></a></h3>
    <p><%= doc.get('message').length > 200 ? doc.escape('message').substr(0, 199) + '...' : doc.escape('message') %> <a href="<%= doc.get('link') %>" title="Weiterlesen">Weiterlesen</a></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="document-link-template">
    <p><%= doc.escape('link_description') %> <a href="<%= doc.get('link_url') %>" title="<%= doc.escape('link_description') %>"><%= doc.escape('title') %></a></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="empty-search-list-template">
    <p>Wir haben keine Resultate zu diesem Suchbegriff gefunden.<br />Bitte versuchen Sie einen anderen oder grenzen Sie Ihre Suche weniger stark ein.</p>
    </script>

    <script src="{{ $view->baseUrl('js/jquery/jquery-1.6.4.min.js') }}"></script>
    <script src="{{ $view->baseUrl('js/underscore.js') }}"></script>
    <script src="{{ $view->baseUrl('js/backbone.js') }}"></script>
    <script src="{{ $view->baseUrl('js/models/search.js') }}"></script>
    <script src="{{ $view->baseUrl('js/apps/search.js') }}"></script>
    <script>
    $(function() {
        window.documents = new DocumentCollection();
        documentsView = new DocumentListView({collection: documents, el: $('#results'), emptyTemplate: $('#empty-search-list-template')});
        paginationView = new PaginationView({collection: documents, el: $('#search-pagination') });
        documents.reset(documents.parse({{ json_encode($result) }}));
        dateFilterView = new DateFilterView({collection: documents, el: $('#date-filter') });
    });
    </script>
</head>

<body>

	<div id="wrapper">
        
    {{ include file="_tpl/header-omnibox.tpl" }}
        
    {{ include file="_tpl/header.tpl" }}

        <div class="content-box clearfix reverse-columns filter-content">
            {{block top}}{{/block}}

            <aside><div class="filter-aside">
            {{block aside}}{{/block}}

            <ul id="date-filter">
                <li class="main"><a href="#">Alle</a></li>
                {{block datefilter}}
                <li><a href="#24h">Letzte 24 Stunden</a></li>
                <li><a href="#7d">Letzte 7 Tage</a></li>
                <li><a href="#1y">Dieses Jahr</a></li>
                {{/block}}
                <li class="range"><label for="range_from">Von</label> <input type="text" id="range_from" class="from" placeholder="TT.MM.JJ" /></li>
                <li class="range"><label for="range_to">Bis</label> <input type="text" id="range_to" class="to" placeholder="TT.MM.JJ" /></li>
                <li><input type="submit" value="Suchen" /></li>
            </ul>

            </div></aside>
            <section>
            {{block section}}
            {{/block}}

            <ul id="results" class="filter-list">
            </ul>

            <ul id="search-pagination" class="paging content-paging">
                <li class="prev"><a href="#" class="grey-button">&laquo;</a></li>
                <li><span class="start">1</span>/<span class="end">12</span></li>
                <li class="next"><a href="#" class="grey-button">&raquo;</a></li>
            </ul>
            </section>
        </div>

    	
    </div><!-- / Wrapper -->

     <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}
