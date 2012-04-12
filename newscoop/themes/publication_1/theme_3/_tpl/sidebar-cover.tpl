                <article>
                    <header>
                        <p><b>Aktuelle Ausgabe</b></p>
                    </header>
                    <div class="frontpage-holder">
                    {{ list_articles length="1" ignore_publication="true" ignore_issue="true" ignore_section="true" order="bypublishdate desc" constraints="type is cover" }}
                        <a href="{{ local }}{{ set_publication identifier="1" }}{{ set_issue number="1" }}{{ set_section number="20" }}{{ url options="section" }}{{ /local }}">
                        <img src="{{ url options="image 1 width 298" }}"  rel="resizable" alt="" />
                        </a>
                    {{ /list_articles }}
                    </div>
                    <a href="{{ local }}{{ set_publication identifier="1" }}{{ set_issue number="1" }}{{ set_section number="20" }}{{ url options="section" }}{{ /local }}" class="button">Jetzt abonnieren!</a>
                </article>                