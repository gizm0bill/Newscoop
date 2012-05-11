Bitte klicken Sie auf den folgenden Link, um Ihr Profil bei tageswoche.ch zu aktivieren.

http://{{ $publication }}{{ $view->url(['user' => $user->identifier, 'token' => $token], 'confirm-email') }}

Vielen Dank und herzlich willkommen in unserer Community.

{{ $view->placeholder('subject')->set("E-Mail-Adresse bestätigen") }}
