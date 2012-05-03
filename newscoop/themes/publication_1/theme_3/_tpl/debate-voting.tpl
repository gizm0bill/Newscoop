{{ list_articles length="1" constraints="type is deb_moderator" }}
<div class="debatte-stat-box">
    <h3>Die Abstimmung</h3>

    {{ list_debates length="1" item="article" }}

    {{ if $gimme->debate->is_votable }}
    {{ debate_form template="_section/section_debatte.tpl" submit_button=false }}
    <ul class="buttons">
        {{ list_debate_answers order="bynumber asc" }}
        <li class="{{ if $gimme->debateanswer->number % 2}}left{{ else }}right{{ /if }}">
            {{ math equation="round(x)" x=$gimme->debateanswer->percentage format="%d"}}% f&uuml;r
            <a onclick="$('#answer-{{ $gimme->debateanswer->number }}').attr('checked','checked');$(this).parents('form:eq(0)').submit(); return false;" href="javascript:void(0)" class="grey-button{{ if $gimme->debateanswer->voted }} active"{{ else }}"{{ /if }}>{{ $gimme->debateanswer->answer }}</a>
            <!-- f_debateanswer_nr name mandatory -->
            <input type="radio" name="f_debateanswer_nr"
                value="{{ $gimme->debateanswer->number }}" id="answer-{{ $gimme->debateanswer->number }}"
                onclick="$(this).parents('form:eq(0)').submit();" style="display:none" />
        </li>
        {{ /list_debate_answers }}
    </ul>
    <input type="submit" id="submit-debate" class="button" value="I think so!" style="display:none" />
    {{ /debate_form }}
    {{/if}}

    {{ if $gimme->debatejustvoted->number }}<small style="font-weight: bold">Ihre Stimme: {{ $gimme->debatejustvoted->answer }}</small><br />{{ /if }}
    {{ if $gimme->debate->is_votable }}<p>Sie können Ihre Meinung bis zum Ende der Debatte am Mittwoch um 12:00 Uhr ändern, wenn Sie die Gegenseite doch mehr überzeugt.</p>
    {{ elseif $gimme->user->logged_in or !$gimme->debate->is_current }}<p>Die Debatte ist abgeschlossen. Das Endresultat steht fest.</p>{{ /if }}

    {{ if !$gimme->debate->is_votable }}
    <p><b>Endresultat</b></p>

    <ul class="votes bottom-margin">
    {{ list_debate_answers order="bynumber asc" }}
        <li style="width:{{ $gimme->debateanswer->percentage|string_format:"%d" }}%;" class="{{ $gimme->debateanswer->answer|lower }}"><p>{{ $gimme->debateanswer->answer }} {{ math equation="round(x)" x=$gimme->debateanswer->percentage format="%d" }}%</p></li>
    {{ /list_debate_answers }}
    </ul>
    {{ /if }}

    <ul class="debatte-stat-list">
        <li>
        {{ list_debate_answers order="bynumber asc" }}
            <b>{{ $gimme->debateanswer->answer }}</b>
        {{/list_debate_answers}}
        </li>

        {{ $stages.zero.answers.yes=0 }}
        {{ $stages.zero.answers.no=0 }}
        {{ $stages.one.answers.yes=0 }}
        {{ $stages.one.answers.no=0 }}
        {{ $stages.two.answers.yes=0 }}
        {{ $stages.two.answers.no=0 }}
        {{ $stages.three.answers.yes=0 }}
        {{ $stages.three.answers.no=0 }}
        {{ list_debate_days length="7" }}
            {{ assign var=debate_time value=$gimme->debatedays->time|date_format:"%Y-%m-%d" }}
            {{ if $debate_time == $gimme->article->date_opening }}
                {{ $stages.zero.answers.yes = $stages.zero.answers.yes + $gimme->debatedays->answers[0]['value'] }}
                {{ $stages.zero.answers.no = $stages.zero.answers.no + $gimme->debatedays->answers[1]['value'] }}
            {{ elseif $debate_time > $gimme->article->date_opening && $debate_time < $gimme->article->date_rebuttal }}
                {{ $stages.one.answers.yes = $stages.one.answers.yes + $gimme->debatedays->answers[0]['value'] }}
                {{ $stages.one.answers.no = $stages.one.answers.no + $gimme->debatedays->answers[1]['value'] }}
            {{ elseif $debate_time >= $gimme->article->date_rebuttal && $debate_time < $gimme->article->date_final }}
                {{ $stages.two.answers.yes = $stages.two.answers.yes + $gimme->debatedays->answers[0]['value'] }}
                {{ $stages.two.answers.no = $stages.two.answers.no + $gimme->debatedays->answers[1]['value'] }}
            {{ elseif $debate_time >= $gimme->article->date_final && $debate_time <= $gimme->article->date_closing }}
                {{ $stages.three.answers.yes = $stages.three.answers.yes + $gimme->debatedays->answers[0]['value'] }}
                {{ $stages.three.answers.no = $stages.three.answers.no + $gimme->debatedays->answers[1]['value'] }}
            {{ /if }}
        {{ /list_debate_days }}

        {{ $stages.zero.count = $stages.zero.answers.yes + $stages.zero.answers.no }}
        {{ $stages.one.count = $stages.one.answers.yes + $stages.one.answers.no }}
        {{ $stages.two.count = $stages.two.answers.yes + $stages.two.answers.no }}
        {{ $stages.three.count = $stages.three.answers.yes + $stages.three.answers.no }}

        {{ foreach $stages as $stage }}
        <li style="height:100px">
            <dl>
            {{ foreach $stage.answers as $votes }}
                {{ if $stage.count > 0 }}
                    {{ $stage_percentage=($votes*100)/$stage.count }}
                {{ else }}
                    {{ $stage_percentage=0 }}
                {{ /if }}
                {{ if $votes@key == "yes" }}<dt {{ else }}<dd {{ /if }}style="height:{{ math equation="round(x)" x=$stage_percentage format="%d" }}px;"><span>{{ math equation="round(x)" x=$stage_percentage format="%d" }}%</span>{{ if $votes@key == "yes" }}</dt>{{ else }}</dd>{{ /if }}
            {{ /foreach }}
            </dl>
            <p>{{ $stage@key }}</p>
        </li>
        {{ /foreach }}
    </ul>

    {{ if $gimme->debate->is_votable }}
    <p><b>Zwischenstand</b></p>

    <ul class="votes">
    {{ list_debate_answers order="bynumber asc" }}
        <li style="width:{{ $gimme->debateanswer->percentage|string_format:"%d" }}%;" class="{{ $gimme->debateanswer->answer|lower }}"><p>{{ $gimme->debateanswer->answer }} {{ math equation="round(x)" x=$gimme->debateanswer->percentage format="%d" }}%</p></li>
    {{ /list_debate_answers }}
    </ul>
    {{ /if }}
</div>

    {{ /list_debates }}
{{ /list_articles }}

