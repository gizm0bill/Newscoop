Vielen Dank für Ihre Registrierung auf tageswoche.ch.
Um die Registerung abzuschliessen und Ihr Profil anzulegen, klicken Sie bitte auf diesen Link:

http://{{ $publication }}{{ $view->url(['user' => $user->identifier, 'token' => $token], 'confirm-email') }}

Vielen Dank. Wir freuen uns auf Ihre Beiträge auf tageswoche.ch

{{ $view->placeholder('subject')->set("Registrierung bei tageswoche.ch bitte bestätigen") }}
