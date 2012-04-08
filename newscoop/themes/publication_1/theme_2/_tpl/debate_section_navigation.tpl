{{ list_articles length="1" constraints="type is deb_moderator" }}

            <div class="wide-title">
                <header>
                    <p>
        {{ $closingdate=date_create($gimme->article->date_closing) }}
        {{ $deadline=$closingdate->setTime(12, 0) }}
        {{ $diff=date_diff($deadline, date_create('now')) }}
        {{ if $deadline->getTimestamp() > time() }}
            Aktueller Stand: 
           {{ if $wdphase == "1"}}Standpunkte{{ /if }}
           {{ if $wdphase == "2"}}Entgegnung{{ /if }}
           {{ if $wdphase == "3"}}Schlussworte{{ /if }}
           {{ if $wdphase == "4"}}Zusammenfassung{{ /if }}
            | Noch {{ $diff->days }} Tage, {{ $diff->h }} Stunden, {{ $diff->i }} Minuten
        {{ else }}
            Aktueller Stand: Fazit{{* (Diskussion geschlossen am {{ $deadline->format('j.n.Y') }} um 12:00 Uhr)*}}
        {{ /if }}</p>
                </header>
            </div>
            
            <div class="wide-box debatte-page">        
                <article>
                    <h2><a href="#"><mark>Die Wochendebatte</mark>  {{ $gimme->article->subject }}</a></h2>
                    
                    <ul class="debatte-buttons-box">
                    
                        <li>
                            <span><a{{ if $wdstage=="0" }} class="active"{{ /if }} href="?stage=0">Start</a></span>
                            <small class="bottom">Übersicht</small>
                        </li>

{{* if $wdphase > 0 *}}                       
                        <li>
                            <em class="top">{{ $gimme->article->date_opening|camp_date_format:"%W" }}</em>
                            <span>
{{ if $wdphase > 0 }}<a{{ if $wdstage=="1" }} class="active"{{ /if }} href="?stage=1">
{{ else }}<span>
{{ /if }}
{{ $gimme->article->date_opening|camp_date_format:"%e.%m" }}
{{ if $wdphase > 0 }}</a>{{ else }}</span>{{ /if }}
</span>
                            <small class="bottom">Standpunkte</small>
                        </li>
{{* /if *}}   
{{* if $wdphase > 1 *}}                    
                        <li>
                            <em class="top">{{ $gimme->article->date_rebuttal|camp_date_format:"%W" }}</em>
                            <span>
{{ if $wdphase > 1 }}<a{{ if $wdstage=="2" }} class="active"{{ /if }} href="?stage=2">
{{ else }}<span>
{{ /if }}
{{ $gimme->article->date_rebuttal|camp_date_format:"%e.%m" }}
{{ if $wdphase > 1 }}</a>{{ else }}</span>{{ /if }}
</span>
                            <small class="bottom">Entgegnung</small>
                        </li>
{{* /if *}}  
{{* if $wdphase > 2 *}}                        
                        <li>
                            <em class="top">{{ $gimme->article->date_final|camp_date_format:"%W" }}</em>
                            <span>
{{ if $wdphase > 2 }}<a{{ if $wdstage=="3" }} class="active"{{ /if }} href="?stage=3">
{{ else }}<span>
{{ /if }}
{{ $gimme->article->date_final|camp_date_format:"%e.%m" }}
{{ if $wdphase > 2 }}</a>{{ else }}</span>{{ /if }}
</span>
                            <small class="bottom">Schlussworte</small>
                        </li>               
                        <li>
                            <span>{{ if $wdphase > 3 }}<a{{ if $wdstage=="4" }} class="active"{{ /if }} href="?stage=4">{{ else }}<span>{{ /if }}{{ $gimme->article->date_closing|camp_date_format:"%e.%m" }}{{ if $wdphase > 3 }}</a>{{ else }}</span>{{ /if }}</span>
                            <small class="bottom">Zusammenfassung</small>
                        </li>  
                    </ul>
                </article>
            </div>
            
{{ /list_articles }}