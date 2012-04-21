{{ include file="_tpl/_html-head.tpl" }}

<body>

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}
        
        <div class="content-box clearfix">
            
            <section>
            
                <article class="quote-list">            
{{ $weekbackdate=date_create("-1 week") }}
{{ $weekback=$weekbackdate->format("Y-m-d") }}
{{ list_articles ignore_issue="true" ignore_section="true" order="byLastUpdate desc" constraints="section is 85 type is good_comment publish_date greater_equal $weekback" }}                
                
                    <blockquote>{{ $gimme->article->comment_community|strip_tags:false }}</blockquote>
                    <small class="quote-meta">{{ $gimme->article->comment_on_comment|replace:"<p>":""|replace:"</p>":""|strip }}</a></small>
                    
{{ /list_articles }}
                </article>
                
                <div class="omni-corner-box comments-box tabs">
                
                    <ul class="comments-nav">
                        <li><a href="#ausgewählte-kommentare">Ausgewählte Kommentare</a></li>
                        <li><a href="#alle-kommentare">Alle Kommentare</a></li>
                    </ul>
                    
                    <div id="ausgewählte-kommentare" class="comment-list">
                    
                        <ol>
                            <li>
                                <img src="pictures/avatar-1.png" alt="" />
                                <h4>Hurra Wahlkampf!</h4>
                                <small>von <a href="#">rejeanne</a> um 30.01.2012 um 07:28Uhr</small>
                                <p>Ich plädiere für Neuwahlen jedes Jahr. Denn anscheinend brauchen gewisse Politiker den Druck des Wahlkampfs um sich um die drängenden Probleme ihres Landes zu kümmern und sich Gedanken zu machen, wie sie diese in den Griff bekommen können. Ob sie diese dann wirklich in die Tat umsetzen, steht auf einem anderen Blatt geschrieben. Aber dann stehen ja bereits die nächsten Wahlen an und man wieder blenden und versprechen. </p>
                                <p><a href="#">Direktlink zum Kommentar</a></p>
                            </li>
                            <li>
                                <img src="pictures/avatar-2.png" alt="" />
                                <h4>Hurra Wahlkampf!</h4>
                                <small>von <a href="#">rejeanne</a> um 30.01.2012 um 07:28Uhr</small>
                                <p>Ich plädiere für Neuwahlen jedes Jahr. Denn anscheinend brauchen gewisse Politiker den Druck des Wahlkampfs um sich um die drängenden Probleme ihres Landes zu kümmern und sich Gedanken zu machen, wie sie diese in den Griff bekommen können. Ob sie diese dann wirklich in die Tat umsetzen, steht auf einem anderen Blatt geschrieben. Aber dann stehen ja bereits die nächsten Wahlen an und man wieder blenden und versprechen. </p>
                                <p><a href="#">Direktlink zum Kommentar</a></p>
                            </li>
                        </ol>
                    
                    </div>
                    
                    <div id="alle-kommentare" class="comment-list">
                    
                        <ol>
                            <li>
                                <img src="pictures/avatar-2.png" alt="" />
                                <h4>Hurra Wahlkampf!</h4>
                                <small>von <a href="#">rejeanne</a> um 30.01.2012 um 07:28Uhr</small>
                                <p>Ich plädiere für Neuwahlen jedes Jahr. Denn anscheinend brauchen gewisse Politiker den Druck des Wahlkampfs um sich um die drängenden Probleme ihres Landes zu kümmern und sich Gedanken zu machen, wie sie diese in den Griff bekommen können. Ob sie diese dann wirklich in die Tat umsetzen, steht auf einem anderen Blatt geschrieben. Aber dann stehen ja bereits die nächsten Wahlen an und man wieder blenden und versprechen. </p>
                                <p><a href="#">Direktlink zum Kommentar</a></p>
                            </li>
                            <li>
                                <img src="pictures/avatar-1.png" alt="" />
                                <h4>Hurra Wahlkampf!</h4>
                                <small>von <a href="#">rejeanne</a> um 30.01.2012 um 07:28Uhr</small>
                                <p>Ich plädiere für Neuwahlen jedes Jahr. Denn anscheinend brauchen gewisse Politiker den Druck des Wahlkampfs um sich um die drängenden Probleme ihres Landes zu kümmern und sich Gedanken zu machen, wie sie diese in den Griff bekommen können. Ob sie diese dann wirklich in die Tat umsetzen, steht auf einem anderen Blatt geschrieben. Aber dann stehen ja bereits die nächsten Wahlen an und man wieder blenden und versprechen. </p>
                                <p><a href="#">Direktlink zum Kommentar</a></p>
                            </li>
                        </ol>
                    
                    </div>
                    
                    <p>show 10 latest comments like this, cap at 400 characters each</p>
                    <ul class="paging content-paging">
                        <li><a class="grey-button" href="#">«</a></li>
                        <li>1/12</li>
                        <li><a class="grey-button" href="#">»</a></li>
                    </ul>
                
                </div>
                
{{ include file="_tpl/front-debatte.tpl" }}
            
            </section><!-- / Main Section -->
            
            <aside>
            
{{ include file="_tpl/sidebar-community.tpl" }}
                
{{ include file="_tpl/sidebar-facebook.tpl" }}
                
{{ include file="_tpl/sidebar-twitter.tpl" }}
                
{{ include file="_tpl/sidebar-blogs.tpl" blogpl="Blog teasers - {{ $gimme->section->name }}" }}
            
            </aside><!-- / Sidebar -->
            
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">
    
{{ include file="_tpl/footer-calendar.tpl" }}

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}