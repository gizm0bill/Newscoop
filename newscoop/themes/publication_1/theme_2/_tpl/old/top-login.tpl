{{ if ! $gimme->user->logged_in }}                                
  {{ login_form submit_button="go" }}     
    <a href="{{ uri options="template register.tpl" }}">Register</a> | 
    {{ if $gimme->login_action->is_error }}
      {{ $gimme->login_action->error_message }}
    {{ else }}Sign in:
    {{ /if }} 
    {{ camp_edit object="login" attribute="uname" html_code="id=\"loginname\" placeholder=\"login\"" }}
    {{ camp_edit object="login" attribute="password" html_code="id=\"loginpassword\" placeholder=\"pass\"" }}
  {{ /login_form }}
{{ else }}
  Welcome, <a href="{{ uri options="template register.tpl" }}">{{ $gimme->user->name }}</a> | <a href="?logout=true">logout</a>
{{ /if }}