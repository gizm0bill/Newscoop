{if $poll->getPoll()}

    {if $poll->userCanVote() && !$poll->showResult} 
        <table border="0" cellspacing="2" cellpadding="2">
        <form name="{$poll->mainData.Id}" action="{URIPath}" method="post">
        {FormParameters}
        
        <tr>
            <td align="left">
                <h2 id='col_schwarz'>{$poll->mainData.Question}</h2>
                <table border="0" cellspacing="0" cellpadding="2">
       
                 {foreach from=$poll->getAnswers() item=answer}
                      <tr valign="top">
                       <td align="left" valign="middle">
                            <input type="radio" name="poll[result][answer][{$poll->mainData.Id}]" value="{$answer.NrAnswer}">
                       </td>
                       <td align="left" valign="middle" width="90%">{$answer.Answer}</td>
                      </tr>
                 {/foreach}
           
                 <tr>
                    <td colspan=2>
                    <input type="submit" value="Submit">
                    &nbsp;&nbsp;
                    <a href="{URL}&poll[Id]={$poll->mainData.Id}&poll[showResult]=1" id="col_schwarz">
                        <span id="col_mitmachen">&raquo; </span>Result
                    </a>
                    </td>
                    
                 </tr>
        
                </table>
        
            </td>
        </tr>
        </form>
        </table>
    {/if}
    
    {if !$poll->userCanVote() || $poll->showResult}
        <table border="0" cellspacing="2" cellpadding="0">
        
        <tr><td>
            <h2 id='col_schwarz'>{$poll->mainData.Question}</h2>        
            <table border="0" cellspacing="0" cellpadding="2">
        
            <tr>
                <td colspan="2">        
                    {foreach from=$poll->getResult() item=answer}
						<div class="DIV_padding_minus">
                        {$answer.NrAnswer}: 
                        <img src="/phpwrapper/images/poll/mainbarlinks.png" width="1" height="9" class="IMG_norm"><img src="/phpwrapper/images/poll/mainbar.png" width="{math equation="2 * x" x=$answer.percent}" height="9" class="IMG_norm"><img src="/phpwrapper/images/poll/mainbarrechts.png" width="1" height="9" class="IMG_norm"> 
                        <span class="text_mini">{$answer.percent}%</span>
                        </div>
                    {/foreach}
                </td>
            </tr>
            
            {assign var=sum value=$poll->getSum()} 
            <tr>
          <td colspan="2">Number of Votes: {$sum.allsum}</td>
        </tr>
            
            {foreach from=$poll->getResult() item=answer}
                <tr>
                    <td valign='top' width='1%'>{$answer.NrAnswer}:</td>
                    <td width='90%'  valign='top'>{$answer.Answer}</td>
                </tr>
            {/foreach}
    
            {if $poll->linklist !== 'off'}
                {Local}
                {Section Number=300}
                <tr>
                    <td></td>
                    <td><a href="{URL}" id="col_schwarz"><span id="col_mitmachen">&raquo; </span>All Polls</a></td>
                </tr>
                {EndLocal}
            {/if}
    
        </table>
        
        </td></tr>
        </table>    
    {/if}
{/if}