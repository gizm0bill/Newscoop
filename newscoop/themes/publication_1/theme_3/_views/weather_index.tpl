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
            	<li class="active"><a href="/wetter">Basel</a></li>
            	<li><a href="/wetter?city=Liestal">Liestal</a></li>
               <li><a href="/wetter?city=Gempen">Gempen</a></li>
               <li><a href="/wetter?city=Passwang">Passwang</a></li>
               <li><a href="/wetter?city=Zurich">Zürich</a></li>
               <li><a href="/wetter?city=Bern">Bern</a></li>
               <li><a href="/wetter?city=Genf">Genf</a></li>
               <li><a href="/wetter?city=Lugano">Lugano</a></li>
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
                    <p><strong>Gericht im Senegal erlaubt Wades Kandidatur</strong> Senegals Verfassungsgericht bestätigt umstrittene Kondidatenliste <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                    <p><strong>RBS-Chef verzichtet nach Kritik auf Bonus</strong> Chef der Royal Bank of Scotland lehnt umstrittenen Bonus ab <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
                    <p><strong>RBS-Chef verzichtet nach Kritik auf Bonus</strong> Chef der Royal Bank of Scotland lehnt umstrittenen Bonus ab <a href="#" class="more">Weiterlesen</a> <span class="time">23.01.2012</span></p>
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