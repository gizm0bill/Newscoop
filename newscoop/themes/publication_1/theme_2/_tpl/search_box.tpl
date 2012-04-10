<!-- _tpl/search_box.tpl -->

<script type="text/javascript">
function isWebcode(value) {
    var webcode =/^[\+@][a-zA-Z]{5,6}$/;
    if (value.search(webcode) == -1) {
        return false;
    } else {
        return true;
    }
}
function asSubmit() {
    var searchValue = document.getElementById('search-field').value;
    if (isWebcode(searchValue) == true) {
        var location = 'http://{{ $gimme->publication->site }}/' + searchValue;
        window.location = location;
        return false;
    } else {
        return true;
    }
}
</script>

<fieldset>
{{ search_form template="search.tpl" submit_button="&nbsp;" button_html_code="style=\"display: none\""  html_code="onclick=\"return asSubmit();\"" }}
    {{ camp_edit object="search" attribute="keywords" html_code="id=\"search-field\" placeholder=\"Webcode, Stichworte\"" }}
    <button>Go</button>
    <input type="hidden" name="f_search_articles" />
    <input type="hidden" name="f_search_level" value="0" />
{{ /search_form }}
</fieldset>

<!-- / _tpl/search_box.tpl -->
