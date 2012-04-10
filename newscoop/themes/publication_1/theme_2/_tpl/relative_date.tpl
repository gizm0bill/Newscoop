{{ $diff=date_diff(date_create('now'), date_create($date)) }}
<small class="date relative">vor
{{ if $diff->y }} {{ $diff->y }} {{ if $diff->y > 1 }}Jahre{{ else }}Jahr{{ /if }}{{ /if }}
{{ if $diff->m }} {{ $diff->m }} {{ if $diff->m > 1 }}Monate{{ else }}Monat{{ /if }}{{ /if }}
{{ if $diff->d }} {{ $diff->d }} {{ if $diff->d > 1 }}Tagen{{ else }}Tag{{ /if }}{{ /if }}
{{ if $diff->h && (!$diff->d || empty($short)) }} {{ $diff->h }} Std.{{ /if }}
{{ if !$diff->d && $diff->i && (empty($short) || !$diff->h) }} {{ $diff->i }} Min.{{ /if }}
{{ if !$diff->d && !$diff->h && !$diff->i && $diff->s }} {{ $diff->s }} Sek.{{ /if }}
</small>
