<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="default/myNavbar.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看申請輔具資料</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />


<style type="text/css">
body {
	background-color: #FEF2AA;
	background-image: url("../img/imgText/mes2.jpg");
	background-repeat: no-repeat;
	background-size: 75%;
	background-position: center;
	
}


</style>


</head>
<body>
	<br>
	<br>
	<div class="container">
		<div class="row justify-content-center">
			<h3>查看申請輔具資料</h3>
		</div>
	</div>
			
<!-- 左側選單---------------------------------------------------------------------------------->
		<br>
			<div class="row position-fixed" style="top: 25%; left: 6%; z-index: 10;">	
				<div class="list-group" style="content: counter(20);">
					<a href="${contextRoot}/FrontMember/memberCentre"><button type="button" class="list-group-item list-group-item-action active" aria-current="true" style=" background-color: #00416A; color: white ;">會員中心</button></a>
		  			<a href="${contextRoot}/FrontMember/memberData"><button type="button" class="list-group-item list-group-item-action" aria-current="true">會員資料</button></a>
				    <a href="${contextRoot }/FrontMember/listassistiveDevice"><button type="button" class="list-group-item list-group-item-action">申請輔具清單</button></a>
				    <a href="${contextRoot }/FrontMember/ShoppingCartList"><button type="button" class="list-group-item list-group-item-action">商品清單</button></a>
				</div>
			</div>


<!-- 右側內容 ---------------------------------------->
	
	<br>
	<div class="container">
	<div class="row justify-content-center">
	
			<table class="table">
				<tr>
					<th>id</th>
					<th>姓名</th>
					<th>年齡</th>
					<th>電話</th>
					<th>地址</th>
					<th>輔具</th>
					<th>編輯</th>
					<th>刪除</th>
				</tr>
				<c:forEach var="andAssistiveDevice" items="${assistiveDeviceList }">
					<tr>
						<td>${andAssistiveDevice.id }</td>
						<td>${andAssistiveDevice.name }</td>
						<td>${andAssistiveDevice.gender}</td>
						<td>${andAssistiveDevice.telephone }</td>
						<td>${andAssistiveDevice.address }</td>
						<td>${andAssistiveDevice.assistiveDevice }</td>
						<td><a href="${contextRoot}/editAssistiveDevice/${andAssistiveDevice.id}">編輯</a></td>
						<td><a href="${contextRoot}/deleteDevice/${andAssistiveDevice.id}">刪除</a> </td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
		<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>