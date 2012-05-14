    <meta name="description" content="{{ strip }}   

{{ if $gimme->publication->identifier == 1 }}
    
{{ if $gimme->template->name == "front.tpl" }}
Die TagesWoche ist eine Schweizer Zeitung aus Basel. Sie erscheint täglich online und jeweils am Freitag als Druckausgabe.
{{ elseif $gimme->template->name == "section.tpl" }}

{{* STANDARD SECTIONS *}}
{{ if $gimme->section->number == 10 }}
Aktuelle Nachrichten und Hintergründe aus Basel und Region, inklusive Baselland, Aargau und Solothurn.
{{ /if }}
{{ if $gimme->section->number == 20 }}
Aktuelle Nachrichten und Hintergründe aus der Schweiz zu Politik, Wirtschaft und Gesellschaft. 
{{ /if }}
{{ if $gimme->section->number == 30 }}
Aktuelle internationale Nachrichten und Hintergründe zu Politik, Wirtschaft und Gesellschaft. 
{{ /if }}
{{ if $gimme->section->number == 40 }}
Aktuelle Sportnachrichten, Hintergründe, Interviews, Spielberichte, Fussball und alles zum FC Basel. 
{{ /if }}
{{ if $gimme->section->number == 50 }}
Aktuelle Kultur-Nachrichten, Interviews, Konzertkritiken, Musik, Film, Literatur, Kunst.	
{{ /if }}
{{ if $gimme->section->number == 60 }}
Menschen und ihr Leben. Aktuelle Berichte und Hintergründe zu Gesellschaft, Bildung, Wissenschaft, Lifestyle und Konsum 
{{ /if }}

{{* AUSGEHEN *}}
{{ if $gimme->section->number == 70 }}
Die Veranstaltungsagenda der TagesWoche mit tausenden Veranstaltungen aus der ganzen Schweiz. 
{{ /if }}
{{ if $gimme->section->number == 71 }}
Die Veranstaltungsagenda der TagesWoche mit tausenden Veranstaltungen aus der ganzen Schweiz. 
{{ /if }}
{{ if $gimme->section->number == 72 }}
Das aktuelle Kinoprogramm für die ganze Schweiz, inklusive Bildern und Trailern zu allen Filmen. 
{{ /if }}

{{* DIALOG *}}
{{ if $gimme->section->number == 80 }}
Die Seite der Community: Alle Inhalte und Kommentare der Leserinnen und Leser der TagesWoche.  
{{ /if }}

{{* WOCHENDEBATTE *}}
{{ if $gimme->section->number == 81 }}
Jede Woche diskutieren zwei prominente Personen in der Wochendebatte über ein kontroverses Thema. Die Leser und Leserinnen können diskutieren mit und stimmen ab.  
{{ /if }}

{{* DOSSIERS *}}
{{ if $gimme->publication->identifier == 1 && $gimme->issue->number == 1 && $gimme->section->number == 5 }}
Die grossen Themen, übersichtlich und verständlich zusammengefasst in den TagesWoche-Dossiers. 
{{ /if }}

{{* ABOS *}}
{{ if $gimme->template->name == "abo.tpl" }}
Mit einem Abonnement der TagesWoche entscheiden Sie sich für kritische und unabhängige Berichterstattung und erhalten die TagesWoche jeden Freitag bequem nach Hause geliefert. 
{{ /if }} 

{{ elseif $gimme->article->defined }}

{{ if $gimme->article->SEO_description|strip_tags|trim !== "" }}
    {{ $gimme->article->SEO_description|strip_tags|escape:'html'|trim }}
{{ else }}
    {{ if $gimme->article->lede|strip_tags|trim !== "" }}
        {{ $gimme->article->lede|strip_tags|escape:'html'|trim }}
    {{ elseif $gimme->article->teaser|strip_tags|trim !== "" }} 
        {{ $gimme->article->teaser|strip_tags|escape:'html'|trim }}
    {{ elseif $gimme->article->teaser|strip_tags|trim !== "" }} 
        {{ $gimme->article->headline|strip_tags|escape:'html'|trim }}
    {{ elseif $gimme->article->DataLead|strip_tags|trim !== "" }} 
        {{ $gimme->article->DataLead|strip_tags|escape:'html'|trim }}
    {{ else }}        
        {{ $gimme->article->body|strip_tags|escape:'html'|trim|truncate:150 }}
    {{ /if }}
{{ /if }}
{{ /if }}

{{ elseif $gimme->publication->identifier == 5 }}

{{ if $gimme->template->name == "blogs.tpl" }}
Spezielle Themenakzente und profilierte Autorenmeinungen: Die Blogs der TagesWoche liefern erfrischende Perspektiven. 

{{ elseif $gimme->template->name == "section.tpl" }}
    {{ list_articles length="1" constraints="type is bloginfo" }}        
        {{ $gimme->article->motto|strip_tags|escape:'html'|trim }}
    {{ /list_articles }}
    
{{ elseif $gimme->article->defined }}
		  {{ $gimme->article->teaser|strip_tags|escape:'html'|trim }}
{{ /if }}

{{ /if }}

{{* COMMUNITY }}
{{ if ????? }}
Die rasant wachsende TagesWoche Community ist eines der wichtigsten Elemente für das Online-Angebot der TagesWoche.  
{{ /if *}}

{{ /strip }}" />