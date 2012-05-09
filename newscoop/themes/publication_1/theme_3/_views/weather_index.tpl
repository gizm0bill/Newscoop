{{ include file="_tpl/_html-head.tpl" }}

<body>

{{ include file="_tpl/_netmetrix-stats.tpl" }}

	<div id="wrapper">
        
{{ include file="_tpl/header-omnibox.tpl" }}
        
{{ include file="_tpl/header.tpl" }}

{{ assign var="ch_city" value=$smarty.get.city }}
{{ if  empty($ch_city) }}{{ $ch_city = 'Basel' }}{{ /if }}
        
        <div class="content-box agenda-mobile-top single-menu desktop-hide">
        
            <ul class="clearfix">
                <li><a href="/wetter" class="trigger grey-button arrow">Basel</a>
                    <ul>
                        <li><a href="/wetter?city=Liestal">Liestal</a></li>
                        <li><a href="/wetter?city=Gempen">Gempen</a></li>
                        <li><a href="/wetter?city=Passwang">Passwang</a></li>
                        <li><a href="/wetter?city=Zurich">Zürich</a></li>
                        <li><a href="/wetter?city=Bern">Bern</a></li>
                        <li><a href="/wetter?city=Genf">Genf</a></li>
                        <li><a href="/wetter?city=Lugano">Lugano</a></li>
                    </ul>
                </li>
            </ul>
        
        </div>
        
        <div class="content-box weather mobile-hide agenda-top">
        
            <ul class="nav">
            	<li{{ if $ch_city == "Basel" }} class="active"{{ /if }}><a href="/wetter">Basel</a></li>
            	<li{{ if $ch_city == "Liestal" }} class="active"{{ /if }}><a href="/wetter?city=Liestal">Liestal</a></li>
               <li{{ if $ch_city == "Gempen" }} class="active"{{ /if }}><a href="/wetter?city=Gempen">Gempen</a></li>
               <li{{ if $ch_city == "Passwang" }} class="active"{{ /if }}><a href="/wetter?city=Passwang">Passwang</a></li>
               <li{{ if $ch_city == "Zurich" }} class="active"{{ /if }}><a href="/wetter?city=Zurich">Zürich</a></li>
               <li{{ if $ch_city == "Bern" }} class="active"{{ /if }}><a href="/wetter?city=Bern">Bern</a></li>
               <li{{ if $ch_city == "Genf" }} class="active"{{ /if }}><a href="/wetter?city=Genf">Genf</a></li>
               <li{{ if $ch_city == "Lugano" }} class="active"{{ /if }}><a href="/wetter?city=Lugano">Lugano</a></li>
            </ul>
        
        </div>
        
        <div class="content-box clearfix">
        
        	<section>
               {{ if $ch_city == "Basel" }}{{ assign var="citycode" value="basel_ch_376" }}{{ /if }}
               {{ if $ch_city == "Liestal" }}{{ assign var="citycode" value="liestal_ch_2612" }}{{ /if }}
               {{ if $ch_city == "Gempen" }}{{ assign var="citycode" value="gempen_ch_1587" }}{{ /if }}
               {{ if $ch_city == "Passwang" }}{{ assign var="citycode" value="passwang_ch_3469" }}{{ /if }}
               {{ if $ch_city == "Zurich" }}{{ assign var="citycode" value="zurich_ch_5254" }}{{ /if }}
               {{ if $ch_city == "Bern" }}{{ assign var="citycode" value="bern_ch_449" }}{{ /if }}  
               {{ if $ch_city == "Genf" }}{{ assign var="citycode" value="genf_ch_1605" }}{{ /if }}
               {{ if $ch_city == "Lugano" }}{{ assign var="citycode" value="lugano_ch_2680" }}{{ /if }}    
               
            	{{ include file="_tpl/weather-iframe.tpl" citycode=$citycode }}
            
         </section>
            
            <aside class="mobile-hide">
                
                <article class="regular-box">
                    <img src="{{ url static_file="pictures/author-img-1.jpg" }}" alt="" />
                    <p>Das Wetter wird präsentiert von Karl Gutbrod von Meteoblug</p>
                </article>
                
                <article>
                    <header>
                        <p>Artikel zum Thema Wetter</p>
                    </header>
                    {{ list_articles length="3" ignore_publication="true" ignore_issue="true" ignore_section="true" constraints="topic is Wetter:de" }}
                    <p><strong>{{ if !($gimme->article->short_name == "") }}{{ $gimme->article->short_name }}{{ else }}{{ $gimme->article->name }}{{ /if }}</strong> 
                    {{ if $gimme->article->type_name == "news" }}
    					  		{{ $gimme->article->teaser|strip_tags|truncate:100:"..." }}
    					  {{ elseif $gimme->article->type_name == "newswire" }}
    							{{ $gimme->article->DataLead|strip_tags|truncate:100:"..." }}
    					  {{ elseif $gimme->article->type_name == "blog" }}
    							{{ $gimme->article->lede|strip_tags|truncate:100:"..." }}
    					  {{ /if }}
     <a href="{{ url options="article" }}" class="more">Weiterlesen</a> <span class="time">{{ $gimme->article->publish_date|camp_date_format:"%e.%m.%Y" }}</span></p>
                    {{ /list_articles }}
                </article>
                
                <article>
                    <header>
                        <p><em>Werbung</em></p>
                    </header>
                    <span class="werbung">
                        <img src="pictures/werbung-sidebar.jpg"  rel="resizable" alt="" />
                    </span>
                </article>
            
            </aside>
        	
        </div>
        
    </div><!-- / Wrapper -->
    
    <div id="footer">

{{ include file="_tpl/footer.tpl" }}

    </div><!-- / Footer -->

{{ include file="_tpl/_html-foot.tpl" }}