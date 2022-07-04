<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<title>網頁導覽</title>
</head>
<body>
	
	<button type="button" class="btn btn-info" href="/">首頁</button>
	
	<div class="list-group">
		<a href="#" class="list-group-item list-group-item-action active"
			aria-current="true" style="font-size: 30px;  w3-block; w3-black;" > 網頁導覽</a> 
		
		<a href="#" class="list-group-item list-group-item-action" href="aboutimedical" >關於imedical</a>
		
		<a href="#" class="list-group-item list-group-item-action" href="">找機構</a> 
		
		<a href="#" class="list-group-item list-group-item-action" href="">找輔具</a> 
		
		<a href="#" class="list-group-item list-group-item-action" href="subsidy">找補助</a>
		
		<a href="#" class="list-group-item list-group-item-action" href="">購物車</a>
		
		<a href="#" class="list-group-item list-group-item-action" href="">留言板</a>
		
		<a href="#" class="list-group-item list-group-item-action" href="">FAQ</a>
		
		<a href="#" class="list-group-item list-group-item-action" href="memberCentre">會員中心</a>
		
		
	</div>
	</nav>

	<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
</body>
</html>