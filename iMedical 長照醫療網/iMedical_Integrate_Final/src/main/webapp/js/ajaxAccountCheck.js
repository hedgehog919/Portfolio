$(document).ready(function() {
	$(`#account`).keyup(function() {
		let account = $(`#account`).val();
		let dtoObject = { "memberAccount": account };
		let dtoJsonString = JSON.stringify(dtoObject);

		$.ajax({
			url: `http://localhost:8080/iMedical/FrontMember/goAddMember`,
			contentType: `application/json; charset=UTF-8`,
			dataType: `json`,
			method: `POST`,
			data: dtoJsonString,
			success: function(result) {
				//如果回傳1,即有同樣帳號
				if (result == 1) {
					$(`#message`).text(`這個帳號已有人使用`).css('color', 'red');
				} else {
					$(`#message`).text(`可以使用`).css('color', 'green');
				}

			},
			error: function(err) {
				console.log(err);
				alert(`error`)
			}
		})
	})
})
