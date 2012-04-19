<ul class="paging content-paging">
    <li>
        {{ if isset($paginator->previous) }}
        <a href="{{ $view->url(['page' => $paginator->previous]) }}" class="grey-button">&laquo;</a>
        {{ else }}
        <span class="grey-button">&laquo;</span>
        {{ /if }}
    </li>
    <li>{{ $paginator->current }}/{{ $paginator->last }}</li>
    <li>
        {{ if isset($paginator->next) }}
        <a href="{{ $view->url(['page' => $paginator->next ]) }}" class="grey-button">&raquo;</a>
        {{ else }}
        <span class="grey-button">&raquo;</span>
        {{ /if }}
    </li>
</ul>
