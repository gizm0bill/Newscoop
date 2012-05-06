{{foreach $paginator->pagesInRange as $page}}
{{if $paginator->current eq $page}}
<span>{{ $page }}</span>
{{else}}
<a href="{{ $view->url(['page' => $page ]) }}">{{ $page }}</a>
{{/if}}
{{/foreach}}

<ul class="paging content-paging">
    <li>
        {{ if isset($paginator->previous) }}
        <a href="{{ $view->url(['page' => $paginator->previous]) }}" class="grey-button">&laquo;</a>
        {{ else }}
        <a>&laquo;</a>
        {{ /if }}
    </li>
    <li>{{ $paginator->current }}/{{ $paginator->last }}</li>
    <li>
        {{ if isset($paginator->next) }}
        <a href="{{ $view->url(['page' => $paginator->next ]) }}" class="grey-button">&raquo;</a>
        {{ else }}
        <a>&raquo;</a>
        {{ /if }}
    </li>
</ul>
