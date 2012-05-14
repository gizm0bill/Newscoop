{{ if !$user->is_active }}
{{ url static_file="_css/tw2011/img/user_inactive_`$width`x`$height`.png" }}
{{ else if $user->image() }}
{{ $user->image($width, $height) }}
{{ else }}
{{ url static_file="_css/tw2011/img/user_blank_`$width`x`$height`.png" }}
{{ /if }}
