{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
            	<header class="mobile-header">
                	<p><a href="#">Blogs</a></p>
                </header>

{{ list_articles length="1" constraints="type is bloginfo" }}            
            	<article class="featured">
                    <figure>
                    		{{ include file="_tpl/renditions/img_640x280.tpl" }}
                        <big>{{ $gimme->article->name }}</big>
                    </figure>
                    <p>{{ strip }}{{ $gimme->article->infolong|strip_tags }}{{ /strip }}</p>
                </article>
{{ /list_articles }}
                
                <div class="mobile-list-view clearfix">

{{ list_articles length="3" constraints="type is blog" }}                 
                    <article>
                        <header>
                            <p><a href="#">International</a></p>
                        </header>
                        <figure class="left">
                            <a href="{{ url options="article" }}"><img src="pictures/blog-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <h2><a href="{{ url options="article" }}">Katalanischer Künstler Antoni Tàpies ist tot</a></h2>
                        <p>Der spanische Maler Antoni Tàpies, einer der bedeutendsten abstrakten Künstler der Gegenwart, ist tot. Wie die Stadtverwaltung von Barcelona in der Nacht zim Alter von 88 Jahren. Von sda. <a href="#">Weiterlesen</a>  <a href="#" class="comments">1 Kommentar</a></p>
                    </article>
{{ /list_articles }}                    
                
                    <ul class="paging content-paging">
                        <li><a class="grey-button" href="#">«</a></li>
                        <li>1/12</li>
                        <li><a class="grey-button" href="#">»</a></li>
                    </ul>
                
                </div>

            </section><!-- / Main Section -->
            
            <aside>
                
                <article>
                	<header>
                    	<p>Blog-Partner</p>
                    </header>
                    <ul class="partner-list">
                    	<li>
                        	<a href="#"><img src="pictures/partner-logo-1.jpg" alt="" /></a>
                        </li>
                    </ul>
                </article>
                
                <article class="regular-box">
                	<header>
                    	<p>Autor: David Bauer</p>
                    </header>
                    <img src="pictures/author-img-1.jpg" alt="" />
                    <p>Redakteur bei der Badischen Zeitung, für die er zehn Jahre lang arbeitete, zuletzt als Sportredakteur. </p>
                </article>
                
                <article>
                	<header>
                    	<p>Abonnieren</p>
                    </header>
                    <p><a href="#" class="rss">Bohnenkult RSS-Feed</a></p>
                </article>
                
                <article class="community omni-corner-box">
                	<header>
                    	<p>TagesWoche Community</p>
                    </header>
                    <ul class="item-list">
                        <li class="comment"><a href="#">Reinhard Arens ist gerade Mitglied geworden</a></li>
                        <li class="omni"><a href="#">Neuer Kommentar zu Barak Obama in Haft: «Hilfe nicht - Ein sehr widerlicher Gedanke, da [...]</a></li>
                        <li class="comment"><a href="#">Manuel Bürger: Neuer Blogeintrag</a></li>
                        <li class="comment"><a href="#">Um 17:00Uhr: Verlosung 20 Karten für Stones mit 50% Rabatt</a></li>
                        <li class="omni"><a href="#">Andrea1980 ist gerade Mitglied geworden</a></li>
                        <li class="omni"><a href="#">Maria Magdalena: Neuer Blogeintrag</a></li>
                    </ul>
                </article>
                
                <article>
                	<header>
                    	<p><em>Werbung</em></p>
                    </header>
                    <span class="werbung">
                    	<img src="pictures/werbung-sidebar.jpg"  rel="resizable" alt="" />
                    </span>
                </article>
                
                <article class="regular-box">
                    <header>
                        <p>Tageswoche honorieren</p>
                    </header>
                    <p>Alle Artikel auf tageswoche.ch sind feri verfügbar. Wenn Ihnen unsere Arbeit etwas wert ist, können Sie uns freiwillig unterstützen. Sie entscheiden wieviel Sie bezahlen. Danke, dass Sie uns helfen, tageswoche.ch in Zukunft besser zu machen.</p>
                </article>
                
                <a class="grey-button reward-button" href="#"><span>Jetzt honorieren!</span></a>
            
            </aside><!-- / Sidebar -->
            
        </div>
        
        <div class="content-box full-width clearfix">
            
            <article>
            	<header class="link-back">
                	<p><a href="#">Blogs</a></p>
                </header>
                <ul class="post-list">
                	<li>
                    	<h4><a href="#">Nur für echte Männer: Basler Magazin.</a></h4>
                        <p>«Der Zielleser der BaZ erscheint mir nach der Lektüre der heutigen Sonntags- ausgabe immer [...] » <a href="#">Lesen</a> | <a href="#">zum Blog</a></p>
                        <span class="meta"><img src="pictures/tiny-thumb.jpg" alt="" /> vor 7 Tagen auf Bildstoff</span>
                    </li>
                	<li>
                    	<h4><a href="#">Nur für echte Männer: Basler Magazin.</a></h4>
                        <p>«Der Zielleser der BaZ erscheint mir nach der Lektüre der heutigen Sonntags- ausgabe immer [...] » <a href="#">Lesen</a> | <a href="#">zum Blog</a></p>
                        <span class="meta"><img src="pictures/tiny-thumb.jpg" alt="" /> vor 7 Tagen auf Bildstoff</span>
                    </li>
                	<li>
                    	<h4><a href="#">Nur für echte Männer: Basler Magazin.</a></h4>
                        <p>«Der Zielleser der BaZ erscheint mir nach der Lektüre der heutigen Sonntags- ausgabe immer [...] » <a href="#">Lesen</a> | <a href="#">zum Blog</a></p>
                        <span class="meta"><img src="pictures/tiny-thumb.jpg" alt="" /> vor 7 Tagen auf Bildstoff</span>
                    </li>
                	<li>
                    	<h4><a href="#">Nur für echte Männer: Basler Magazin.</a></h4>
                        <p>«Der Zielleser der BaZ erscheint mir nach der Lektüre der heutigen Sonntags- ausgabe immer [...] » <a href="#">Lesen</a> | <a href="#">zum Blog</a></p>
                        <span class="meta"><img src="pictures/tiny-thumb.jpg" alt="" /> vor 7 Tagen auf Bildstoff</span>
                    </li>
                	<li>
                    	<h4><a href="#">Nur für echte Männer: Basler Magazin.</a></h4>
                        <p>«Der Zielleser der BaZ erscheint mir nach der Lektüre der heutigen Sonntags- ausgabe immer [...] » <a href="#">Lesen</a> | <a href="#">zum Blog</a></p>
                        <span class="meta"><img src="pictures/tiny-thumb.jpg" alt="" /> vor 7 Tagen auf Bildstoff</span>
                    </li>
                	<li>
                    	<h4><a href="#">Nur für echte Männer: Basler Magazin.</a></h4>
                        <p>«Der Zielleser der BaZ erscheint mir nach der Lektüre der heutigen Sonntags- ausgabe immer [...] » <a href="#">Lesen</a> | <a href="#">zum Blog</a></p>
                        <span class="meta"><img src="pictures/tiny-thumb.jpg" alt="" /> vor 7 Tagen auf Bildstoff</span>
                    </li>
                </ul>
                <footer>
                	<a href="#" class="more">Zur den Blogs»</a>
                </footer>
            </article>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}