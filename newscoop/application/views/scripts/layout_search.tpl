<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>Tages Woche</title>
    <meta name="description" content="">
    <meta name="author" content="">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="favicon.png">
    <link rel="apple-touch-icon" href="touch-icon.png">

    <link rel="stylesheet" href="{{ $view->baseUrl('public/_css/tw2011/main.css') }}">
    <link rel="stylesheet" href="{{ $view->baseUrl('public/_css/tw2011/skin.css') }}">
    <link rel="stylesheet" href="{{ $view->baseUrl('public/_js/libs/fancybox/jquery.fancybox-1.3.4.css') }}">
    <script src="{{ $view->baseUrl('public/_js/libs/modernizr-2.0.6.js') }}"></script>
    
    <script type="text/template" id="document-article-template">
    <% if (doc.get('image')) { %><img src="/images/cache/<%= doc.get('image') %>" alt="" width="90" /><% } %>
    <h3><a href="<%= doc.get('link') %>" title="<%= doc.escape('title') %>"><%= doc.escape('title') %></a></h3>
    <p><%= doc.escape('lead') %></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="document-twitter-template">
    <p><b><%= doc.escape('tweet_user_screen_name') %></b> <%= doc.escape('tweet') %></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="document-user-template">
    <h3><a href="#"><%= doc.escape('user') %></a></h3>
    <p><%= doc.escape('bio') %></p>
    </script>

    <script type="text/template" id="document-event-template">
    <h3><a href="#"><%= doc.escape('title') %></a></h3>
    </script>

    <script type="text/template" id="document-omni-template">
    <h3><a href="#"><%= doc.escape('subject') %></a></h3>
    <p><%= doc.get('message').length > 200 ? doc.escape('message').substr(0, 199) + '...' : doc.escape('message') %> <a href="<%= doc.get('link') %>" title="Weiterlesen">Weiterlesen</a></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="document-link-template">
    <p>Diesen Link halten wir für wertvoll, weshalb wir ihn an unsere Leser weitergeben: <a href="<%= doc.get('link_url') %>"><%= doc.escape('link_description') %></a></p>
    <span class="time"><%= doc.relDate('published') %></span>
    </script>

    <script type="text/template" id="empty-search-list-template">
    <p>Wir haben keine Resultate zu diesem Suchbegriff gefunden.<br />Bitte versuchen Sie einen anderen oder grenzen Sie Ihre Suche weniger stark ein.</p>
    </script>

    <script src="{{ $view->baseUrl('js/jquery/jquery-1.6.4.min.js') }}"></script>
    <script src="{{ $view->baseUrl('js/underscore.js') }}"></script>
    <script src="{{ $view->baseUrl('js/backbone.js') }}"></script>
    <script src="{{ $view->baseUrl('js/apps/search.js') }}"></script>
    <script>
    $(function() {
        window.documents = new DocumentCollection();
        documentsView = new DocumentListView({collection: documents, el: $('#results'), emptyTemplate: $('#empty-search-list-template')});
        paginationView = new PaginationView({collection: documents, el: $('#search-pagination') });
        documents.reset(documents.parse({{ json_encode($result) }}));
    });
    </script>
</head>
<body>

	<div id="wrapper">
        
        <div id="omni-box-placeholder">
            <div id="omnibox">
                <a href="#" class="trigger">Open</a>
                <div class="omnibox-content">
                    <fieldset>
                        <ul class="omnilogin">
                            <li>
                                <h3>Login</h3>
                                <p>Melden Sie sich bei der TagesWoche an, um Artikel zu kommentieren und Mitteilungen direkt an die Redaktion zu schicken.<br>
                                <a href="#">Warum muss ich mich registrieren?</a></p>
                            </li>
                            <li>
                                <ul>
                                    <li>
                                    	<label>Username</label>
                                        <input type="text" id="emil" />
                                    </li>
                                    <li>
                                    	<label>Password</label>
                                    	<input type="text" id="passwort" />
                                    </li>
                                    <li>
                                        <button class="button">Login</button>
                                        <a href="#">Benutzerkonto anlegen</a><br>
                                        <a href="#">Passwort vergessen</a>
                                    </li>
                                </ul>
                           </li>
                        </ul>
                    </fieldset>
                </div>
            </div>
        </div><!-- / Omni box -->
        
        <div class="content-box top-content-box clearfix">
    
            <div id="top" class="clearfix">
                <ul>
                    <li>Freitag 13.02.2011</li>
                    <li><img src="{{ $view->baseUrl('public/pictures/icon-weather-sunny.png') }}" alt=""> 5°C Basel</li>
                    <li><a href="#">Kontakt</a></li>
                    <li><a href="#">Login</a></li>
                </ul>
                <h1><a href="index.php">Tages Woche</a></h1>
            </div><!-- / Top -->
            <div id="main-nav" class="clearfix">
                <nav>
                    <ul>
                        <li><a href="#" class="active">Basel</a></li>
                        <li><a href="#">Schweiz</a></li>
                        <li><a href="#">International</a></li>
                        <li><a href="#">Sport</a></li>
                        <li><a href="#">Kultur</a></li>
                        <li><a href="#">Leben</a></li>
                    </ul>
                    <ul>
                        <li><a href="#">Blogs</a></li>
                        <li><a href="#">Dossiers</a></li>
                        <li><a href="#">Dialog</a></li>
                    </ul>
                    <ul>
                        <li><a href="#">Ausgehen</a></li>
                    </ul>
                </nav>
                <fieldset>
                    <input type="text" value="" />
                    <button>Go</button>
                </fieldset>
            </div><!-- / Main Nav -->
            
        </div>        
        <div class="content-box clearfix reverse-columns filter-content">
            <aside>
            {{block aside}}{{/block}}
            </aside>
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
    
        <div class="footer-holder">
            <ul>
                <li>
                    <h4>TagesWoche</h4>
                    <ul>
                        <li><a href="#">Über uns</a></li>
                        <li><a href="#">Dialogkultur</a></li>
                        <li><a href="#">Kontakt</a></li>
                        <li><a href="#">Werbung</a></li>
                        <li><a href="#">Impressum</a></li>
                        <li><a href="#">Zeitungsarchiv</a></li>
                        <li><a href="#">RSS-Feeds</a></li>
                        <li><a href="#">Press Corner</a></li>
                        <li><a href="#">AGB</a></li>
                        <li><a href="#">Abos</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Dialog</h4>
                    <ul>
                        <li><a href="#">Kommentare</a></li>
                        <li><a href="#">Nutzersuche</a></li>
                        <li><a href="#">Storyboard</a></li>
                        <li><a href="#">Wochendebatte</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Themen</h4>
                    <ul>
                        <li><a href="#">Meine Themen</a></li>
                        <li><a href="#">Basel</a></li>
                        <li><a href="#">Schweiz</a></li>
                        <li><a href="#">International</a></li>
                        <li><a href="#">Sport</a></li>
                        <li><a href="#">Kultur</a></li>
                        <li><a href="#">Leben</a></li>
                        <li><a href="#">Dossiers</a></li>
                        <li><a href="#">Alle Nachrichten</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Ausgehen</h4>
                    <ul>
                        <li><a href="#">Veranstaltungen</a></li>
                        <li><a href="#">Kino</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Blogs</h4>
                    <ul>
                        <li><a href="#">Bildstoff</a></li>
                        <li><a href="#">FF-Blog</a></li>
                        <li><a href="#">Doppelspitze</a></li>
                        <li><a href="#">Bohnenkult</a></li>
                        <li><a href="#">Kulturschocker</a></li>
                        <li><a href="#">Habenmuss</a></li>
                        <li><a href="#">Lichtspiele</a></li>
                        <li><a href="#">Listomania</a></li>
                        <li><a href="#">Mittendrin</a></li>
                    </ul>
                </li>
                <li>
                    <h4>Folgen Sie uns</h4>
                    <ul class="social">
                        <li class="fb"><a href="#">Facebook</a></li>
                        <li class="tw"><a href="#">Twitter</a></li>
                        <li class="yt"><a href="#">YouTube</a></li>
                        <li class="sc"><a href="#">Soundcloud</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        
    </div><!-- / Footer -->
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
    
    <!--[if (gte IE 6)&(lte IE 8)]>
      <script type="text/javascript" src="_js/libs/selectivizr-min.js"></script>
    <![endif]--> 
    
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/jquery-ui-1.8.16.custom.min.js') }}"></script>
	<script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/jquery.easing.1.3.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/fancybox/jquery.mousewheel-3.0.4.pack.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/fancybox/jquery.fancybox-1.3.4.pack.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/stickysidebar.jquery.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/jquery.jcarousel.min.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/custom-form-elements.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/jquery.simplyscroll-1.0.4.min.js') }}"></script>
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/libs/jquery.masonry.min.js') }}"></script>
    
    <script type="text/javascript" src="{{ $view->baseUrl('public/_js/init.js') }}"></script>

</body>
</html>
