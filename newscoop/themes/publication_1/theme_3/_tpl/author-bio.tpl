{{ if $author->user->defined && !empty($author->user['bio']) }}{{ $author->user['bio']|bbcode }}{{ else if $author->biography->text }}{{ $author->biography->text|bbcode }}{{ else }}...{{ /if }}
