{{ if $author->has_url }}<a href="{{ $author->url }}" title="{{ $author->user->uname }}">{{ $author->user->uname }}</a>{{ else }}{{ $author->name }}{{ /if }}
