{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box full-width clearfix">
            
            <article>
            	<header>
                	<p>Aktuell in den Blogs</p>
                </header>
                <ul class="post-list">

{{ list_articles length="6" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is blog" }}                

{{ $bloginfo=$gimme->article->get_bloginfo() }}

                	<li>
                    	<h4><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h4>
                        <p>« {{$gimme->article->body|regex_replace:'#<div class="cs_img".*</div>#U':''|strip_tags|trim|truncate:100:" [...]"}} » <a href="{{ url options="article" }}">Lesen</a> | <a href="{{ url options="section" }}">zum Blog</a></p>
                        <span class="meta">{{ if $bloginfo }}{{ if $gimme->article->get_bloginfo()->image(1)->imageurl }}<img src="{{ $gimme->article->get_bloginfo()->image(1)->imageurl }}" alt="{{ $gimme->section->name }}" width="60" />{{ /if }}{{ /if }} {{ include file="_tpl/relative-date.tpl" date=$gimme->article->publish_date }} auf {{ $gimme->section->name }}</span>
                    </li>

{{ /list_articles }}

                </ul>
            </article>
            
            <article class="single-title">
            	<header>
                	<p>Blogs</p>
                </header>
            </article>
        	
        </div>
        
        <div class="content-box clearfix">
        
            <section>
            
            	<header class="mobile-header first-in-line">
                	<p><a href="#">Blogs</a></p>
                </header>
                
                <div class="two-columns mobile-list-view small-titles clearfix">
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel asd a da sd</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                    <article>
                        <figure>
                            <big>Nur für echte<br />
                            Männer</big>
                            <a href="#"><img src="pictures/small-img-1.jpg" rel="resizable" alt="" /></a>
                        </figure>
                        <p>Seinen trainingsfreien Tag beim FC Basel</p>
                    </article>
                </div>

            </section><!-- / Main Section -->
            
            <aside>
                
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
                	<footer>
                    	<a class="more" href="#">Zur Community »</a>
                    </footer>
                    <p>Die TagesWoche Community hat über 45'000 Mitglieder!</p>
                    <a class="button" href="#">Jetzt mitmachen!</a>
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
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}