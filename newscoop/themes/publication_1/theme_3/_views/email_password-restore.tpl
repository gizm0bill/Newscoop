Guten Tag {{ $user->uname }},

um ein neues Passwort für tageswoche.ch zu setzen, folgen Sie bitte dem folgenden Link:

http://{{ $publication }}{{ $view->url(['controller' => 'auth', 'action' => 'password-restore-finish', 'user' => $user->identifier, 'token' => $token], 'default') }}

{{ $view->placeholder('subject')->set('Passwort für tageswoche.ch zurücksetzen') }}
