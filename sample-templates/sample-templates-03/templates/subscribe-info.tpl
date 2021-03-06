<table width="466"  border="0" cellspacing="5" cellpadding="0">
<tr>
<td>
<h1>{{ $campsite->publication->name }}: Subscription page</h1>
{{ subscription_form type="by_publication" template="do_subscribe.tpl" submit_button="Submit" }}
<table>
    {{ if $campsite->url->get_parameter("SubsType") == "paid" }}
    <tr><td colspan=2 align=left><span class="subscribe">Total time:
    {{ $campsite->publication->subscription_paid_time }}
    {{ $campsite->publication->subscription_time_unit }}</span></td></tr>
    
    <tr><td colspan=2 align=left><span class="subscribe">Total cost:
    {{ $campsite->subscription->totalcost }}
    {{ $campsite->publication->subscription_currency }}</span></td></tr>
    {{ /if }}
    
    {{ if $campsite->url->get_parameter("SubsType") == "trial" }}
    <tr><td colspan=2 align=left><span class="subscribe">Total time:</span>
    {{ $campsite->publication->subscription_trial_time }}
    {{ $campsite->publication->subscription_time_unit }}
    </td></tr>
    {{ /if }}
    
    <tr>
        <td colspan="2">
            {{ camp_select object="subscription" attribute="alllanguages" }}
            <span class="subscribe">Subscribe to all languages</span>
        </td>
    </tr>
    <tr>
        <td><span class="subscribe">Languages:</span></td>
        <td>{{ camp_select object="subscription" attribute="languages" }}
    </tr>
</table>
{{ /subscription_form }} 
</td>
</tr>
</table>