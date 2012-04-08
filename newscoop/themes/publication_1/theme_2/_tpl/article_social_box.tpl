                    <div class="social-network-box">
                      <div id="social_bookmarks"></div>
<p class="social-options-bar"> 
{{* if $gimme->article->comments_enabled && $gimme->article->content_accessible }}
    <a title="Artikel kommentieren" href="#" onclick="javascript:omnibox.showHide()" class="omnibox omni-box-trigger">Omnibox</a> 
{{ /if *}}    
    {{* if $gimme->article->topics_count > 0 && $gimme->user->logged_in }}
    <a class="follow-topics list" href="#follow-topics-popup-{{ $gimme->article->number }}">List</a>
    {{ /if *}}
    <a title="Artikel weiterleiten" href="#" class="mail addthis_button_email"></a> 
    {{*<a title="Artikel drucken" href="#" onclick="window.print();return false" class="print">Print</a> *}}
    <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=sourcefabric"></script> 
</p>                        
                    </div>
