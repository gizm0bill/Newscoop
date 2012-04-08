{{ list_articles length="1" constraints="type is deb_moderator" }}

<article>

<!-- can use parameter 'number' - the number next to the debate name in admin list -->
{{ list_debates length="1" item="article" }} 
  
  <!-- dbt -->
  {{if $gimme->debate->is_votable}}
    {{ debate_form template="_section/section_debatte.tpl" submit_button=false }}
      <ul class="vote-results">
          {{list_debate_answers order="bynumber asc"}}
        <li>
          <em>Insgesamt stimmten</em>
  {{math equation="round(x)" x=$gimme->debateanswer->percentage format="%d"}}% f&uuml;r
          <a onclick="$('#answer-{{$gimme->debateanswer->number}}').attr('checked','checked');$(this).parents('form:eq(0)').submit(); return false;" href="javascript:void(0)"
    {{if $gimme->debateanswer->voted}} class="active" {{/if}}>
            {{$gimme->debateanswer->answer}}
          </a>
          <!-- f_debateanswer_nr name mandatory -->
              <input type="radio" name="f_debateanswer_nr"
                value="{{$gimme->debateanswer->number}}" id="answer-{{$gimme->debateanswer->number}}"
                onclick="$(this).parents('form:eq(0)').submit();" style="display:none"
              />
        </li>
          {{/list_debate_answers}}
        </ul>
      <input type="submit" id="submit-debate" class="button" value="I think so!" style="display:none" />
    {{/debate_form}}
  {{/if}}

   <p>{{ if $gimme->debatejustvoted->number }}<small style="font-weight: bold">Ihre Stimme: {{ $gimme->debatejustvoted->answer }}</small><br />{{ /if }}
   {{ if $gimme->debate->is_votable }}Sie können Ihre Meinung bis zum Ende der Debatte am Mittwoch um 12:00 Uhr ändern, wenn Sie die Gegenseite doch mehr überzeugt.
   {{ elseif $gimme->user->logged_in or !$gimme->debate->is_current }}Die Debatte ist abgeschlossen. Das Endresultat steht fest.
   {{ /if }}</p>

  <h4>Zwischenstand</h4>
  <ul class="vote-stat clearfix">
    <li>
      {{list_debate_answers order="bynumber asc"}}
        <div class="voteheader">{{$gimme->debateanswer->answer}}</div>
        {{/list_debate_answers}}
    </li>
      {{list_debate_days length="7"}}
      <li style="height:100px">
        <!-- the list of votes, numbering in 2 usually -->
    <!--{{$gimme->debatedays|dump}}{{$gimme->debatedays->time|debate_date_format:"%a"}} {{$gimme->debatedays->time}}-->
        {{list_debate_votes}}
        <div
          class="{{if $gimme->debatevotes->number % 2}}gray{{/if}}"
          style="height: {{$gimme->debatevotes->percentage|string_format:"%.2f"}}%;"></div>
            {{if $gimme->debatevotes->number % 2}}
              <em>{{math equation="round(x)" x=$gimme->debatevotes->percentage format="%d"}}%</em>
            {{else}}
              <small>{{math equation="round(x)" x=$gimme->debatevotes->percentage format="%d"}}%</small>
            {{/if}}
          {{/list_debate_votes}}
          <span>{{$gimme->debatedays->time|debate_date_format:"%a"}}.</span>
      </li>
      {{/list_debate_days}}
  </ul>
<!-- or you can use $gimme->debate->is_closed to check if the deadline is met -->
  {{if !$gimme->debate->is_votable}}
     <ul class="vote-score clearfix">
      {{list_debate_answers order="bynumber asc"}}
          <li style="height:100px">
        <div class="gray" style="height:{{$gimme->debateanswer->percentage|string_format:"%d"}}%;"></div>
                <em>{{math equation="round(x)" x=$gimme->debateanswer->percentage format="%d"}}%</em>
                <span>{{$gimme->debateanswer->answer}}</span>
            </li>
            {{/list_debate_answers}}
        </ul>
  {{else}}
  <!-- dbt nvtb -->
  {{/if}}

{{/list_debates}}

{{ if !($gimme->user->logged_in) }}
<a style="margin-top: 15px; display: block" href="javascript:omnibox.showHide()">Loggen Sie sich ein, um abzustimmen</a>
{{ /if }}

                        </article>    

{{ /list_articles }}

