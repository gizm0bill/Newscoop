{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix reverse-columns filter-content">
            
            <ul class="top-filter">
            	<li class="filter">Filter</li>
                <li class="title">
                    <label>Sucheresultate für</label>
                    <fieldset>
                        <input type="text" value="" />
                        <button>Go</button>
                    </fieldset>
                </li>
                <li class="type">Typ</li>
                <li class="time">veröffentlicht</li>
            </ul>
        
        	<aside>
            
            	<div class="filter-aside">
            
                    <h3>Suche eingrenzen</h3>
                    <ul>
                        <li class="main"><a href="#">Alle</a></li>
                        <li><a href="#">Artikel</a></li>
                        <li><a href="#">Dossiers</a></li>
                        <li><span>Blogbeitrage</span></li>
                        <li><span>Kommentare</span></li>
                        <li><a href="#">Links</a></li>
                        <li><a href="#">Veranstaltungen</a></li>
                        <li><a href="#">Nutzer</a></li>
                    </ul>
                    
                    <ul>
                        <li class="main"><a href="#">Alle</a></li>
                        <li><a href="#">Letzte 24 Stunden</a></li>
                        <li><a href="#">Letzte 7 Tage</a></li>
                        <li><a href="#">Das Jahr</a></li>
                        <li><label>Von</label> <input type="text" value="TT.MM.JJ" /></li>
                        <li><label>Bis</label> <input type="text" value="TT.MM.JJ" /></li>
                        <li><input type="submit" value="Suchen" /></li>
                    </ul>
                
                </div>
            
            </aside>
            
            <section>
                
                <ul class="filter-list">
                
                	<li class="article">
                    	<img src="pictures/list-thumb-1.jpg" alt="" />
                    	<h3><a href="#">Titel einer superduper Eigenleistung</a></h3>
                        <p>Teasertext der Eigenleistung, die eben in den Ticker gehört, weil im Ticker alles drin ist, ungefiltert.</p>
                        <span class="time">vor 3 Min.</span>
                    </li>
                    <li class="omni">
                    	<h3><a href="#">Titel einer superduper Eigenleistung</a></h3>
                        <p>Teasertext der Eigenleistung, die eben in den Ticker gehört, weil im Ticker alles drin ist, ungefiltert.</p>
                        <span class="time">vor 8 Min.</span>
                    </li>
                   	<li class="link">
                    	<p>Diesen Link halten wir für wertvoll, weshalb wir ihn an unsere Leser weitergeben: <a href="#">Titel des Artikel bei der New York Times</a></p>
                        <span class="time">vor 12 Min.</span>
                    </li>
                    <li class="twitter">
                    	<p><b>david_herzog</b> Ein Tweet mit Nachrichtenwert, den wir aus diesem Grund favorisiert haben.</p>
                        <span class="time">vor 12 Min.</span>
                    </li>
                    <li class="article">
                    	<img src="pictures/list-thumb-1.jpg" alt="" />
                    	<h3><a href="#">Titel einer superduper Eigenleistung</a></h3>
                        <p>Teasertext der Eigenleistung, die eben in den Ticker gehört, weil im Ticker alles drin ist, ungefiltert.</p>
                        <span class="time">vor 3 Min.</span>
                    </li>
                    <li class="omni">
                    	<h3><a href="#">Titel einer superduper Eigenleistung</a></h3>
                        <p>Teasertext der Eigenleistung, die eben in den Ticker gehört, weil im Ticker alles drin ist, ungefiltert.</p>
                        <span class="time">vor 8 Min.</span>
                    </li>
                   	<li class="link">
                    	<p>Diesen Link halten wir für wertvoll, weshalb wir ihn an unsere Leser weitergeben: <a href="#">Titel des Artikel bei der New York Times</a></p>
                        <span class="time">vor 12 Min.</span>
                    </li>
                    <li class="twitter">
                    	<p><b>david_herzog</b> Ein Tweet mit Nachrichtenwert, den wir aus diesem Grund favorisiert haben.</p>
                        <span class="time">vor 12 Min.</span>
                    </li> 
                    <li class="article">
                    	<img src="pictures/list-thumb-1.jpg" alt="" />
                    	<h3><a href="#">Titel einer superduper Eigenleistung</a></h3>
                        <p>Teasertext der Eigenleistung, die eben in den Ticker gehört, weil im Ticker alles drin ist, ungefiltert.</p>
                        <span class="time">vor 3 Min.</span>
                    </li>
                    <li class="omni">
                    	<h3><a href="#">Titel einer superduper Eigenleistung</a></h3>
                        <p>Teasertext der Eigenleistung, die eben in den Ticker gehört, weil im Ticker alles drin ist, ungefiltert.</p>
                        <span class="time">vor 8 Min.</span>
                    </li>
                   	<li class="link">
                    	<p>Diesen Link halten wir für wertvoll, weshalb wir ihn an unsere Leser weitergeben: <a href="#">Titel des Artikel bei der New York Times</a></p>
                        <span class="time">vor 12 Min.</span>
                    </li>
                    <li class="twitter">
                    	<p><b>david_herzog</b> Ein Tweet mit Nachrichtenwert, den wir aus diesem Grund favorisiert haben.</p>
                        <span class="time">vor 12 Min.</span>
                    </li>                
                </ul>
                
                <ul class="paging content-paging">
                    <li><a href="#" class="grey-button">&laquo;</a></li>
                    <li>1/12</li>
                    <li><a href="#" class="grey-button">&raquo;</a></li>
                </ul>
            
            </section>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}