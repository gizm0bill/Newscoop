Der Kommentar von {{ $username }} lautet:<br />
{{ $comment->getSubject()|escape }}:<br />
{{ $comment->getMessage()|escape }}<br />
<br />
<a href="https://www.tageswoche.ch{{ $articleLink }}">Zum Artikel</a><br />
<a href="https://www.tageswoche.ch{{ $articleLink }}#comment-{{ $comment->getId() }}">Zum Kommentar</a><br />

{{ $view->placeholder('subject')->captureStart() }}Neuer Kommentar zum Artikel {{ $article->title }}{{ $view->placeholder('subject')->captureEnd() }}
