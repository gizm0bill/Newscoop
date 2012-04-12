{{ if $image->photographer != "" }}
(Bild: {{ if $image->photographer == 'sda' }}Keystone{{ else }}{{ $image->photographer }}{{ /if }})
{{ /if }}
