$('#selectPage').on('change', function() {
	var queryString = '?page=' + this.value;
	window.location.href = queryString;

})

$('#newsMsgList li').hover(function() {
	$(this).css({
		'background-color': '#f4f0e3',
		'border-bottom': '3px dashed #308F8F',
		
	}).find('a span:nth(1)').css({
		'font-weight': 'bold',
		'color': '#444',

	})

}, function() {
	$(this).css({
		'background-color': '#f8f9fa',
		'border-bottom': '3px dashed #ddd',
		
	}).find('a span:nth(1)').css({
		'font-weight': '400',
		'color': '#404040',

	})

})


