{{extends file="layout.tpl"}}

{{block content}}
<section>
<div class="article-padding edit-profile-tab">
<article>
    <header>
        <p><strong>TagesWoche</strong> Benutzerkonto</p>
    </header>

    <form id="register-form" action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}">

    <fieldset class="fixBackground">
        <h3>Bitte geben Sie Ihre E-Mail-Adresse ein und stimmen Sie den Nutzungsbedingungen zu.</h3>
        <p>Mit dem Benutzerkonto können Sie Ihr Abo online verwalten, eigene Beiträge veröffentlichen und mit anderen TagesWoche-Lesern in Kontakt treten. Das Benutzerkonto ist kostenlos und kann jederzeit wieder gelöscht werden.</p>
        <ul>
            <li><dl>
                {{ $form->email->setLabel("E-Mail")->removeDecorator('Errors') }}
                {{ if $form->email->hasErrors() }}
                <span class="error-info">Bitte geben Sie eine gültige E-Mail-Adresse an.</span>
                {{ /if }}
            </dl></li>
            <li><p>* Ihre E-Mail-Adresse wird unter keinen Umständen an Dritte weitergegeben.</p></li>

            <li>
                <textarea rows="5" cols="60" id="terms-of-use-text" readonly="readonly" style="font-size:1em">Anwendungsbereich

1. Gegenstand der vorliegenden AGB bilden die Beziehungen zwischen der Neue Medien Basel AG als Herausgeberin der TagesWoche und Betreiberin der Webseite der TagesWoche (nachfolgend “Betreiberin”) und den Nutzerinnen und Nutzern (nachfolgend “Nutzer”) der online angebotenen Dienstleistungen und Produkte. Insbesondere sind diese AGB Bestandteil eines jeden Vertrages über die Nutzung der angebotenen Online-Dienstleistungen auf der Webseite der TagesWoche.
2. Unter die vorliegenden AGB fallen sämtliche Nutzungen der Webseite der TagesWoche. Die AGB gelten dabei sowohl für die Nutzung registrierungspflichtiger als auch registrierungsfreier Dienstleistungen. Die Webseite der TagesWoche wird von der Betreiberin unter der Bedingung angeboten, dass sich der Nutzer den vorliegenden AGB vorbehaltlos und ohne Änderungen unterwirft.
3. Mit der Nutzung der Dienstleistungen auf der Webseite der TagesWoche erklärt der Nutzer sein Einverständnis mit den vorliegenden AGB. Die AGB sind jederzeit auf der Webseite der TagesWoche verfügbar und können heruntergeladen und ausgedruckt werden. Bei registrierungspflichtigen Dienstleistungen wird der Nutzer zu Beginn des Registrierungsprozesses zusätzlich ausdrücklich auf die AGB hingewiesen.
4. Sofern und soweit spezielle Dienstleistungen weitergehenden oder anderen Nutzungsbedingungen unterliegen sollten, werden diese dem Nutzer an geeigneter Stelle zur Kenntnis gebracht. Bei einem Widerspruch solcher speziellen Nutzungsbedingungen zu den vorliegenden AGB, haben erstere als Spezialbestimmungen Vorrang.


Nutzung der Webseiten der TagesWoche

5. Die Benutzung der Webseiten der TagesWoche ist zum privaten Gebrauch bestimmt, die Nutzung zum gewerblichen Gebrauch ist grundsätzlich untersagt. Letztere kann jedoch mit schriftlicher Zustimmung der Betreiberin nach der vertraglichen Festlegung sämtlicher damit zusammenhängender Bedingungen erlaubt werden.
6. Dem Nutzer ist es grundsätzlich untersagt, Inhalte auf der Webseite der TagesWoche zu kopieren, zu versenden, zu veröffentlichen, zu ändern, vorzutragen, anzubieten, zu vermieten, zu veräussern, zu lizenzieren, weiterzuverarbeiten oder auf Dritte zu übertragen. Ausgenommen sind diejenigen Dienstleistungen, welche ausdrücklich eine Weiterverbreitung von Inhalten erlauben und entsprechend gekennzeichnet sind. In jedem Fall bleibt der Inhalt ausschliesslich auf der Infrastruktur der Betreiberin der Webseite gespeichert und wird über die entsprechenden Funktionen auf den Webseiten von Dritten lediglich eingebettet.
7. Der Nutzer der Webseite hat die Möglichkeit, ohne einen Registrierungsprozess die Inhalte auf der Webseite der TagesWoche anzusehen. Nach der Registrierung und Erstellung eines Benutzerprofils kann der Nutzer zudem weitere Funktionen verwenden und insbesondere Kommentare und Blogs erstellen. Darüber hinaus wird dem Nutzer ermöglicht, eigene Inhalte auf der Webseite zu erstellen (insb. Kommentare und Blogs) bzw. hochzuladen (insb. Bildmaterial).
8. Der Nutzer hat darum besorgt zu sein, dass die erstellten und die hochgeladenen Inhalte nicht gegen die Schweizerische Rechtsordnung verstossen und insbesondere keine Urheberrechte oder Persönlichkeitsrechte verletzen. Die diesbezügliche Verantwortlichkeit liegt allein beim Nutzer. Sollte die Betreiberin für derartige Eingriffe rechtlich belangt werden, so kann sie auf den betreffenden Nutzer Regress nehmen.
9. Mit dem Hochladen eigener Inhalte räumt der Nutzer der Betreiberin das unentgeltliche, zeitlich und räumlich unbegrenzte Recht ein, die betreffenden Inhalte zu kopieren, zu versenden, zu veröffentlichen, weiterzuverbreiten, zu übertragen, weiterzuverarbeiten und zu veräussern. Insbesondere kann die Betreiberin die hochgeladenen Nutzerinhalte auch für die Printversion der TagesWoche oder für andere Medien (bspw. Film, Radio, Fernsehen usw.) verwenden. Der Nutzer erklärt sich mit dem Hochladen der Inhalte damit einverstanden, dass die Betreiberin anderen Nutzern erlaubt, die betreffenden Inhalte auf Webseiten von Dritten kenntlich zu machen und auf diesen Seiten einzubetten. In der Regel bleiben dabei die Inhalte auf der Infrastruktur der Betreiberin gespeichertin (vgl. Ziffer 6). Sollte dies aus irgendwelchen Gründen nicht möglich sein, so ist vorgängig die schriftliche Zustimmung der Betreiberin einzuholen. An sämtlichen Inhalten bleibt zu jeder Zeit ausschliesslich die Betreiberin berechtigt.
10. Bei sämtlichen hochgeladenen Inhalten behält sich die Betreiberin vor, die Inhalte zu löschen oder in geeigneter Weise unkenntlich zu machen, insbesondere (aber nicht ausschliesslich) solche mit rechtswidrigem Gehalt.
11. Der Nutzer hat ohne vorgängige Registrierung und Erstellung eines Benutzerprofils die Möglichkeit, einzelne Inhalte auf der Webseite der TagesWoche finanziell zu honorieren. Dabei wird der Nutzer durch Anklicken der entsprechenden Schaltfläche an einen externen und von der Webseite der Betreiberin unabhängigen Zahlungsvorgang weitergeleitet. Die Mittel aus dieser Honorierung fliessen direkt der Betreiberin zu und können von dieser zur Weiterentwicklung und Verbesserung ihres Angebots verwendet werden. Die finanzielle Honorierung von Inhalten ist jedoch einseitig, der Nutzer erhält dafür keine Gegenleistung.


Links zu Webseiten von Dritten

12. Die Webseite der TagesWoche kann mittels Link auf von Dritten betriebene und unterhaltene Webseiten verweisen. Für deren Inhalte wird jegliche Verantwortung abgelehnt. Sollten Inhalte von gelinkten Webseiten gegen die Schweizerische Rechtsordnung verstossen, kann die Betreiberin den Link nach Kenntnis des Inhalts umgehend von Ihrer eigenen Webseite entfernen.
13. Der Nutzer der Webseite der TagesWoche verpflichtet sich seinerseits, die Betreiberin über Inhalte von gelinkten Webseiten, welche gegen die Schweizerische Rechtsordnung verstossen oder von denen er annimmt, dass sie gegen diese verstossen, umgehend zur Kenntnis zu bringen.


Nutzerprofil und Nutzer-Account

14. Zur Nutzung von registrierungspflichtigen Dienstleistungen auf der Webseite muss sich der Nutzer online anmelden und einen Nutzer-Account erstellen. Der Zugriff auf den persönlichen Account wird nach der Eingabe der erforderlichen Registrierungsdaten und der anschliessenden Aktivierung des Accounts freigeschaltet. Damit erhält der Nutzer Zugriff auf sämtliche registrierungspflichtigen Dienstleistungen auf der Webseite der TagesWoche. Nach der Registrierung kann sich der Nutzer mit seinen persönlichen Zugangsdaten, bestehend aus einem Login und einem Passwort, auf der Webseite anmelden. 
15. Das Anlegen des persönlichen Nutzer-Accounts mit integriertem Benutzerprofil ist kostenlos.
16. Der Nutzer ist dazu angehalten, wahrheitsgetreue Angaben zu machen. Die Betreiberin behält sich vor, fiktive Benutzerprofile zu löschen. Die Angabe eines Pseudonyms im betreffenden Feld ist zulässig. Der Nutzer wird bei der Nutzung der registrierungspflichtigen Dienstleistungen jeweils unter diesem Pseudonym aufgeführt. Insbesondere werden Beiträge, Kommentare, Blogs, Bilder usw., welche der Nutzer erstellt oder hoch lädt, mit diesem Pseudonym gekennzeichnet und mit dem Benutzerprofil verknüpft. 
17. Der Nutzer kann über die Einstellungen in seinem persönlichen Nutzer-Account definieren, welche Daten seines Benutzerprofils er anderen Nutzern kenntlich machten will und welche nicht. Er hat insbesondere die Möglichkeit, mit Ausnahme seines Pseudonyms sämtliche Personendaten unsichtbar zu machen und anderen Nutzern bei der Kenntnisnahme seines Profils zu verbergen. Die Betreiberin kann die betreffenden Daten jedoch jederzeit einsehen. Sämtliche Personendaten werden im Übrigen vertraulich behandelt. 
18. Der Nutzer hat die Möglichkeit, seinen Nutzer-Account mit dem gespeicherten Benutzerprofil jederzeit zu löschen. Sämtliche vom betreffenden Nutzer erstellten und hochgeladenen Inhalte auf der Webseite bleiben unter der ausschliesslichen Nennung seines Pseudonyms bestehen. Der Nutzer kann sich an die Betreiberin wenden, falls er einzelne oder sämtliche seiner erstellten oder hochgeladenen Inhalte (insbesondere Kommentare, Blogs, Bilder usw.) löschen lassen will. Die Betreiberin entscheidet im Einzelfall, ob eine Löschung der Inhalte mit dem Interesse am Weiterbestand der Inhalte zu vereinbaren ist. Ein Anspruch auf Löschung besteht jedoch nicht.


Datenschutzerklärung

19. Die Betreiberin hält sich an die geltenden Datenschutzbestimmungen und ist darum bemüht, sorgfältig und diskret mit persönlichen Daten der Nutzer umzugehen. Bei der Erhebung und Verwendung von Personendaten gelten die nachfolgenden Grundsätze:
20. Personendaten sind alle Angaben, die sich auf eine bestimmte oder bestimmbare Person beziehen. Darunter fallen Informationen wie Name, Adresse, Telefonnummer und E-Mailadresse von natürlichen und juristischen Personen. 
21. Daten von Personen werden nur erhoben, falls sie für die Ausführung von angebotenen Dienstleistungen, für Abo-Bestellungen und die Nutzung personenspezifischer Angebote notwendig sind. Es steht jeder Person frei, weitere Angaben zu machen. Jede Person wird über den Zweck der Datenbeschaffung vorgängig informiert. Besonders schützenswerte Personendaten werden nicht erhoben.
22. Die erhobenen Personendaten werden nur zur Ausführung von dem Nutzer bekannt gegebenen Dienstleistungen verwendet. Sollten die Daten auf eine andere Art verwendet werden, wird der Nutzer entsprechend informiert und kann die weitere Verwendung seiner Daten ablehnen. Personendaten werden nicht an Dritte weitergegeben, mit Ausnahme der Verwendung von Trackingdaten (siehe nachfolgende Ziffer 23). Der Nutzer bestimmt mit seinen Einstellungen im Benutzerprofil, ob und in welchem Umfang er seine erfassten Personendaten für andere Nutzer sichtbar machen will (siehe Ziffer 17).
23. Zu statistischen Zwecken, insbesondere um die angebotenen Dienstleistungen zu verbessern, werden so genannte Trackingdaten erhoben, welche Auskunft über das Surfverhalten der Nutzer geben. Diese Daten werden von Google Analytics (oder allenfalls einem anderen Partner der Betreiberin) erhoben. Die erhobenen Daten lassen keinen Rückschluss auf die Identität einzelner Nutzer zu und werden lediglich zu Handen der Betreiberin erfasst und ausschliesslich an diese weitergeleitet. Die Betreiberin übernimmt keine Verantwortung oder Haftung für die Datenverarbeitung durch Google Analytics.
24. Zur Optimierung des Angebots und zu statistischen Zwecken werden Cookies eingesetzt. Diese Cookies sind vollständig anonymisiert und enthalten keine Daten über die einzelnen Nutzer. Cookies werden darüber hinaus dazu verwendet, um den Nutzern Inhalte entsprechend ihren Interessen und Bedürfnissen anzeigen zu können. 
25. Jeder Nutzer kann jederzeit die über ihn erhobenen Daten in der Datenbank der Betreiberin löschen lassen. Vorbehalten bleibt bei einer Löschung des Benutzerprofils das Pseudonym des Nutzers, welches bestehen bleibt (siehe Ziffer 18).
26. Jeder Nutzer, über den Personendaten erhoben und bearbeitet werden, kann jederzeit Auskunft darüber verlangen, welche Daten über ihn bearbeitet werden. Ausserdem kann er die Berichtigung von Daten sowie die Streichung aus dem Adressregister verlangen.
27. Die erhobenen Daten werden elektronisch erfasst und gespeichert. Personendaten werden durch angemessene technische und organisatorische Massnahmen gegen unbefugtes Bearbeiten geschützt.
28. Bei Missbrauch oder dem Verdacht auf eine strafbare Handlung ist die Betreiberin berechtigt, die Daten auszuwerten und auf Begehren den zuständigen amtlichen Behörden weiterzuleiten, sofern sie gesetzlich dazu verpflichtet ist.


Haftung

29. Jede Haftung der Betreiberin wird, soweit gesetzlich zulässig, wegbedungen.
30. Die Betreiberin übernimmt insbesondere keine Haftung für die Richtigkeit, Vollständigkeit und Aktualität der Informationen, die über die Webseite dargestellt werden. Eine Haftung für Inhalte, welche von Nutzern erstellt und/oder hochgeladen wurden, wird ausdrücklich abgelehnt. Für diese Inhalte haftet ausschliesslich der Nutzer selbst (Ziffer 8). Für Informationen, welche über die Webseite von Dritten abrufbar und mittels Link auf der Webseite der TagesWoche zugänglich gemacht oder eingebettet werden, wird jegliche Haftung abgelehnt. 
31. Darüber hinaus haftet die Betreiberin insbesondere nicht für Technikfehler, Betriebsstörungen und Softwarefehler. Eine Haftung für Schäden, welche durch Computerviren, Spionageprogramme und andere schädliche Computerprogramme hervorgerufen werden, ist ebenfalls ausgeschlossen.


Schlussbestimmungen

32. Sollten einzelne Bestimmungen dieser AGB unwirksam sein oder werden, so berührt dies die Wirksamkeit der übrigen Bestimmungen nicht. An die Stelle einer unwirksamen Bestimmung tritt eine neue Bestimmung, die in ihrer wirtschaftlichen und rechtlichen Auswirkung der unwirksamen Bestimmung möglichst nahe kommt.
33. Die Betreiberin behält sich ausdrücklich das Recht vor, die vorliegenden AGB und deren Bestimmungen jederzeit zu ändern. Der Nutzer ist verpflichtet, sich über die aktuell geltende Fassung der AGB auf den Webseiten zu informieren. Die Aufschaltung einer neuen Fassung der AGB wird den registrierten Nutzern jeweils mittels E-Mail-Nachricht zur Kenntnis gebracht.


Gerichtsstand und anwendbares Recht

34. Auf alle Rechtsbeziehungen aus dem Vertrag zwischen der Betreiberin und dem Nutzer sowie diesen AGB ist Schweizerisches Recht unter Ausschluss der Bestimmungen des UN-Kaufrechts anwendbar. Ausschliesslicher Gerichtsstand ist Basel als der Sitz der Betreiberin. Die Betreiberin kann allerdings Klagen gegen den Nutzer auch an dessen Sitz oder Wohnsitz anhängig machen.</textarea>
            </li>
            <li>
                <input type="checkbox" name="terms_of_use" value="1" id="terms-of-use" />
                <label for="terms-of-use" id="terms-of-use-label">Ich habe die Nutzungsbedingungen gelesen und stimme Ihnen zu.</label>
                {{ if $form->terms_of_use->hasErrors() }}
                <span class="error-info">Sie können sich nur registrieren, wenn Sie unseren Nutzungsbedingungen zustimmen. Dies geschieht zu Ihrer und unserer Sicherheit. Bitten setzen Sie im entsprechenden Feld ein Häkchen.</span>
                {{ /if }}
            </li>
        </ul>
    <div class="form-buttons right">
            <!--<button id="submit" class="button">Weiter</button>//-->
            <input type="submit" id="submit" class="button" value="Weiter" />
        </div>
    </fieldset>

    </form>
</article>
</div>
</section>

<aside>
</aside>

<script type="text/javascript">
$(document).ready(function() {

$('#register-form').submit(function() {
    if ($('#email.red-error').size()) {
        return false;
    }
});

$('#email').change(function() {
    $.post('{{ $view->url(['controller' => 'register', 'action' => 'check-email'], 'default') }}?format=json', {
        'email': $(this).val()
    }, function (data) {
        if (data.status) {
            $('#email').removeClass('red-error').next('span.error-info').detach();
            $('.error-info', $('#email').closest('dl')).detach();
        } else {
            if (!$('#email.red-error').size()) {
                $('#email').addClass('red-error').after('<span class="error-info">Sie haben offenbar bereits ein Benutzerkonto bei der TagesWoche. Loggen Sie sich <a href="{{ $view->url(['controller' => 'auth', 'action' => 'index']) }}">hier</a> ein. Falls Sie Ihr Passwort nicht mehr kennen, klicken Sie <a href="{{ $view->url(['controller' => 'auth', 'action' => 'password-restore'], 'default') }}">hier</a>.</span>');
            } 
        }
    }, 'json');
}).keyup(function() {
    $(this).change();
});

});
</script>
{{/block}}