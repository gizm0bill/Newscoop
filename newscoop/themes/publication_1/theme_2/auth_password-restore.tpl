{{extends file="layout.tpl"}}

{{block content}}
<section>
<div class="article-padding edit-profile-tab">
<article>
    <header>
        <p><strong>TagesWoche</strong> Passwort wiederherstellen</p>
    </header>

    <form action="{{ $form->getAction() }}" method="{{ $form->getMethod() }}">

    <fieldset class="fixBackground">

    {{ if $form->email->hasErrors() }}
    <h3>Huch, diese E-Mail-Adresse kennen wir nicht.</h3>
    <p>Haben Sie sich vielleicht mit einer anderen E-Mail-Adresse auf <em>tageswoche.ch</em> angemeldet?</p>
    {{ /if }}

        <ul>
            <li><dl>
                {{ $form->email->setLabel("E-Mail")->removeDecorator('Errors') }}
            </dl></li>
        </ul>
		<div class="form-buttons right">
            <!--<button id="submit" class="button">Neues Passwort anfordern</button>//-->
            <input type="submit" id="submit" class="button" value="Neues Passwort anfordern" />
        </div>
    </fieldset>

    </form>

</article>
</div>
</section>

<aside>
</aside>

{{/block}}
