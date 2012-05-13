    <meta name="description" content="{{ strip }}
{{ if $gimme->template->name == "front.tpl" }}
Die TagesWoche ist eine Schweizer Zeitung aus Basel. Sie erscheint täglich online und jeweils am Freitag als Druckausgabe.
{{ elseif $gimme->template->name == "section.tpl" }}
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
{{ if $gimme->section->number == 71 }}
Die Veranstaltungsagenda der TagesWoche mit tausenden Veranstaltungen aus der ganzen Schweiz.
{{ /if }}
{{ if $gimme->section->number == 72 }}
Das aktuelle Kinoprogramm für die ganze Schweiz, inklusive Bildern und Trailern zu allen Filmen. 
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
{{ /strip }}" />