{{ strip }}
<ul class="socialbuttons">
<li>
<a href="mailto:?Subject=TagesWoche%20Artikel:%20{{ $gimme->article->name|escape:'url' }}&body=
Diesen Artikel empfehle ich:
%0D%0A %0D%0A 
{{ $gimme->article->name|escape:'url' }}
{{ $gimme->article->lede|strip_tags|escape:'url' }}{{ $gimme->article->DataLead|strip_tags|escape:'url' }}
%0D%0A %0D%0A 
http://{{ $gimme->publication->site }}/{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/{{ $gimme->article->number }}/
" class="mailto" title="Diesen Artikel verschicken"><span>Diesen Artikel verschicken</span></a>
</li>
<li>
<a href="http://www.facebook.com/sharer.php?u=http://{{ $gimme->publication->site }}/{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/{{ $gimme->article->number }}/&t={{ $gimme->article->name|escape:'url' }}" 
target="_blank" class="facebook" title="Auf Facebook ver&ouml;ffentlichen">
<span>Auf Facebook ver&ouml;ffentlichen</span></a>
</li>
<li>
<a href="http://twitter.com/home?status=Ich lese gerade {{ $gimme->article->name|escape:'url' }} in der TagesWoche http://{{ $gimme->publication->site }}/{{ $gimme->language->code }}/{{ $gimme->issue->url_name }}/{{ $gimme->section->url_name }}/{{ $gimme->article->number }}/" 
target="_blank" class="twitter" title="Auf Twitter ver&ouml;ffentlichen">
<span>Auf Twitter ver&ouml;ffentlichen</span></a>
</li>
</ul>

{{ /strip }}