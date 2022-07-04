<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="2,url=${contextRoot}/Backstage">
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">

<title>登入成功</title>
</head>
<body>
<div style="margin:100px 500px 500px 500px;">
<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg" style="color: rgb(0, 160, 0); font-size: 10rem;"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg>
<br>
<h3>登入成功! 您好 ${loginEmployee[0].employeeName} !... 將在2秒後自動跳轉至後台首頁</h3>
</div>




	<footer class="main-footer"
		style="margin-top: 100px; background-color: lightgray;">
		<div class="container" style="width: 100%; text-align: center;">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.0.01
			</div>
			<strong>Copyright © 2022-2025 <a href="">iMedical</a>.
			</strong> All rights reserved.
		</div>

	</footer>

</body>
</html>