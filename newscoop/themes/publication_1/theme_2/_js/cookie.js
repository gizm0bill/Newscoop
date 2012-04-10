function createCookie(name, value, days, path, domain) {
  var params = "";
  
	if (days) {
		var date = new Date();
		date.setTime(date.getTime() + (days*24*60*60*1000));
		var params = "; expires=" + date.toGMTString();
	}
	
	if (path !== undefined) {
	   params = "; path=" + path; 
	}
	
	if (domain !== undefined) {
	   params = "; domain=" + domain; 
	}
	
	document.cookie = name + "=" + value + params;
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}