
    function  Save_Button_onclick() {
        var code =  WrapCode();
        code = code + document.getElementById("CodeArea").value;
        code = code + "</p><p></p> "
        if (document.getElementById("CodeArea").value == ''){
            tinyMCEPopup.close();
            return false;
        }
        tinyMCEPopup.execCommand('mceInsertContent', false, code);
        tinyMCEPopup.close();
    }

    function  WrapCode()
    {
        return "<p class=\"swiss-info-free\">";
    }

    function Cancel_Button_onclick()
    {
        tinyMCEPopup.close();
        return false;
    }
