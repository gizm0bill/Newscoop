<p class="pagination reverse-border">

{{foreach $paginator->pagesInRange as $page}}
{{if $paginator->current eq $page}}
<span>{{ $page }}</span>
{{else}}
<a href="{{ $view->url(['page' => $page ]) }}">{{ $page }}</a>
{{/if}}   
{{/foreach}}

<span class="nav right">
    {{if isset($paginator->previous)}}
    <a href="{{ $view->url(['page' => $paginator->previous]) }}" class="prev">Previous</a>
    {{else}}
    <a href="#" class="prev">Previous</a>
    {{/if}}

    {{if isset($paginator->next)}}
    <a href="{{ $view->url(['page' => $paginator->next ]) }}" class="next">Next</a>
    {{else}}
    <a href="#" class="next">Next</a>
    {{/if}}
</span>
</p>
