
	$(".ticker-sort input").click(function(){
		var control = $('.ticker-sort input');
		var is_selected = true;
		
		$.each(control, function(index, value) {
			if($(this).attr("checked") === 'checked' && $(this).attr("id") !== 'alle-ressorts') {
				is_selected = false;
			}
		});

		if(is_selected === true) {
			$('#alle-ressorts').attr('checked', 'checked');
		} else {
			$('#alle-ressorts').removeAttr('checked', 'checked');

		}
		
	});
