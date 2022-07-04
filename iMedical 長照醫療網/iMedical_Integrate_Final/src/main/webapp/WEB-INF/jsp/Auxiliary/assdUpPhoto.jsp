<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>上傳輔具圖片頁面</title>
</head>
<body>
<h1>上傳輔具照片</h1>
	
	<form action="fileUpload" method="post" enctype="multipart/form-data">
		輔具名: <input id="AssistiveDeviceName" name="AssistiveDeviceName">
	
		<br>
	
		輔具照片: <input type="file" name="file">
	
	</form>
	
</body>
</html>