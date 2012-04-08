{{* PAGINATION KOSHER/HALAL WAY *}}
{{ $pages=ceil($gimme->current_list->count/10) }}
{{ $curpage=intval($gimme->url->get_parameter($gimme->current_list_id())) }}
{{ if $pages gt 1 }}
<p class="pagination reverse-border">
    {{ for $i=0 to $pages - 1 }}
        {{ $curlistid=$i*10 }}
        {{ $gimme->url->set_parameter($gimme->current_list_id(),$curlistid) }}
        {{ if $curlistid != $curpage }}
        <a href="{{ url }}">{{ $i+1 }}</a>
        {{ else }}
        <span style="font-weight: bold; text-decoration: none">{{ $i+1 }}</span>
        {{ $remi=$i+1 }}
        {{ /if }}
    {{ /for }}
    <span class="nav right">
    {{ if $gimme->current_list->has_previous_elements }}<a href="{{ url options="previous_items" }}" class="prev">Previous</a>{{ /if }}
    {{ if $gimme->current_list->has_next_elements }}<a href="{{ url options="next_items" }}" class="next">Next</a>{{ /if }}
    </span>
</p>
{{ $gimme->url->set_parameter($gimme->current_list_id(),$curpage) }}
{{ /if }}
