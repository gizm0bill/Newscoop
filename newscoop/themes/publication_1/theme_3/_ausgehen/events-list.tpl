{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
{{ include file="_ausgehen/subnav.tpl" }}
        
        <div class="content-box clearfix reverse-columns agenda-content">
        
        	<aside>
            
            	<h3>Ort</h3>
                <ul>
                	<li>
                    	<select>
                        	<option>Basel Stadt</option>
                        	<option>1</option>
                        	<option>2</option>
                        </select>
                    </li>
                </ul>
                
                <h3>Genre</h3>
                <ul class="categories">
                	<li class="active"><a href="#">Alle</a></li>
                	<li><a href="#">Theater</a></li>
                	<li><a href="#">Komödie</a></li>
                	<li><a href="#">Cabaret</a></li>
                </ul>
                
            	<h3>Presenting Partner</h3>
                <ul class="partner-list">
                	<li><a href="#"><img src="pictures/partner-logo-small-1.jpg" alt="" /></a></li>
                </ul>
                
                <p><a href="#">Melden Sie Ihre Veranstaltung!</a></p>
            
            </aside>
            
            <section>
                
                <article>
                    <img src="pictures/theater-img-1.jpg" alt="" />
                    <h3><a href="#">Lorem Ipsum Dolor</a></h3>
                    <h6>Theater</h6>
                    <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet. <a href="#">Details</a></p>
                </article>
                <article>
                    <h3><a href="#">Lorem Ipsum Dolor</a></h3>
                    <h6>Komödie</h6>
                    <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet. <a href="#">Details</a></p>
                </article>
                <article class="stared">
                    <h3><a href="#">Lorem Ipsum Dolor</a></h3>
                    <h6>Theater</h6>
                    <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet. <a href="#">Details</a></p>
                </article>
                <article>
                    <img src="pictures/theater-img-1.jpg" alt="" />
                    <h3><a href="#">Lorem Ipsum Dolor</a></h3>
                    <h6>Cabaret</h6>
                    <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet. <a href="#">Details</a></p>
                </article>
            
            </section>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}