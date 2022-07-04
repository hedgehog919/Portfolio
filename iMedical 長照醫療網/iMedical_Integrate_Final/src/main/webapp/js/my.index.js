var resultString = '';

$(document).ready(function() {
	var urlString = 'relatedLink';
	$.ajax({
		method: 'get',
		dataType: 'json',
		url: urlString,
		success: function(result) {
			$.each(result, function(index, value) {
				resultString += '<div class="item" onclick="window.open(\'';
				resultString += value.uri + '\')">';
				resultString += '<div style="font-weight:bold; font-size: 22px">';
				resultString += value.name;
				resultString += '</div></div>';

			});

			$('.owl-carousel').append(resultString);

			var owl = $('.owl-carousel');
			owl.owlCarousel({
				loop: true,
				margin: 8,
				autoplay: true,
				autoplayTimeout: 5000,
				autoplayHoverPause: true,
				responsive: {
					0: {
						items: 1
					},
					600: {
						items: 2
					},
					1000: {
						items: 4
					}
				}
			});

			$('.item').addClass('d-flex justify-content-between mr-2 p-2').css({
//				'cursor': 'pointer',
//				'font-size': '20px',
//				'border': '4px solid #bd3359',
//				'border-radius': '15px',
//				'background': 'linear-gradient(rgba(255,255,255,0.1), rgba(255,255,255,0.1)), url("./img/S__21356548.png")',
//				'background-size': '100%',
//				'background-repeat': 'no-repeat',
//				'-webkit-text-stroke': '0.5px black',
//    			'color': 'black',
//				'background-position': '80% 0%'

			});
			




			$('.item div').addClass('align-content-center m-auto')

			$('.item a').addClass('h5');
			//			$('.item').hover(function () {
			//				$(this).css({
			//					'background-color': '#C5E0E0'
			//				})
			//
			//			}, function () {
			//				$(this).css("background-color", "#ffffff")
			//			})
			
			$('.owl-dots').css({
				'display': 'none',
			})

		},
		error: function(err) {
			console.log(err);
			console.log("輸出失敗");
		}
	});
	
	$('.btn-top-div').click(function(){
	window.location.href = './#top';
	})
	
	
	

});

//最新消息分頁
//function changePage(currPage) {
//
//	var aSize = $('#m_newsBtn a').length + 1;
//
//	$('#m_newsBtn').children().remove();
//	$('#m_newsList li').remove();
//
//	var textHtml = '';
//	var urlString =  localUrl + 'page/' + currPage;
//	var newsUrl = localUrl + 'newsInfo?';
//	$.ajax({
//		method: 'get',
//		url: urlString,
//		dataType: 'json',
//		success: function(result) {
//			$.each(result, function(index, value) {
//				var d = new Date(value.date);
//				// 格式化日期
//				//console.log(d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate());
//				textHtml += '<li>';
//				textHtml += '<a href="';
//				textHtml += newsUrl + 'id=' + value.id + '&' + 'page=' + currPage + '"';
//				textHtml += '>';
				//textHtml += 'target="_blank">';
//				textHtml += '<span>';
//				textHtml += d.getFullYear() + "-" + "0" + (d.getMonth() + 1) + "-" + d.getDate() + " ";
//				textHtml += '</span>';
//				textHtml += '<span>';
//				textHtml += value.title;
//				textHtml += '</span>';
//				textHtml += '</a>';
//				textHtml += '</li>';
//			});

//			$('#m_newsList ul').append(textHtml);

//			var linkString = '';
//			for (var i = 1; i <= aSize; i++) {
//				if (i != currPage) {
//					linkString += '<a href="javascript:void(0);" onclick="changePage(' + i + ')">' + i + '</a>' + " ";
//				} else {
//					linkString += '<span id="m_newsDefault">' + i + '</span>' + " ";
//				}
//
//				if (i < aSize) linkString += '<span class="m_newsToken">|</span>' + " ";
//			}
//
//			linkString += '<span>頁</span>' + " ";
//			$('#m_newsBtn').append(linkString);
//
//			$('#m_newsList li').hover(function() {
//				$(this).css({
//					'border-bottom': '2px solid #DF0060'
//				})
//					.find('span:nth(1)').css({
//						'font-weight': 'bold',
//						'color': '#DF0060'
//					})
//			}, function() {
//				$(this).css({
//					'border-bottom': '2px solid #dddddd'
//				})
//					.find('span:nth(1)').css({
//						'font-weight': '400',
//						'color': '#404040'
//					})
//			})

//		},
//		error: function(err) {
//			console.log(err);
//		}
//	})



//	return false;
//
//}

//$(document).ready(function() {
//	$('#m_newsList li').hover(function() {
//		$(this).find('span:nth(1)')
//		.css({
//			'font-weight': 'bold',
//			'color': '#f55c00'
//		})
//	}, function() {
//		$(this).find('span:nth(1)')
//		.css({
//			'font-weight': '400',
//			'color': '#404040'
//		})
//	});
//
//
//
//})


