<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>查看機構</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<style type="text/css">
body{
	background-image: url("${contextRoot}/img/AgencyImg/aI02.jpg");
 	background-attachment: scroll; 
	background-position: center;
	background-size: cover;
	background-repeat: no repeat;
	background-opacity: 0;
	
}

.row{
	justify-content: center;
}
</style>
</head>

<body>

<!-- 左側選單-------------------------------------------------------------------------------- -->
		<br>
	<div class="cotainer">
		<div class="row position-absolute top-100% start-100%  bottom-50% ">	
			<div class="list-group">
	  			<a href="${contextRoot}/Agency/viewAgency"><button type="button" class="list-group-item list-group-item-action active" aria-current="true">機構介紹</button></a>
			    <a href="${contextRoot }/Agency/selectAgencyData"><button type="button" class="list-group-item list-group-item-action">搜尋機構</button></a>
			    <a href="${contextRoot }/Agency/allAgencyData"><button type="button" class="list-group-item list-group-item-action">機構列表</button></a>
			</div>
		</div>
	</div>


<!-- 右側table --------------------------------------------------->
<br>
<br>
<div class="cotainer">
	<div class="row justify-content-center">
		<h3>查看所有機構列表</h3>
	</div>
</div>

	<div class="container">
	<table class="table width-100px" >
		<tr>
			<th>id</th>
			<th>機構環境圖片</th>
			<th>機構名稱</th>
			<th>機構類型</th>
			<th>機構電話</th>
			<th>機構地址</th>
			<th>服務時間</th>
			<th>房型</th>
			<th>床數</th>
			<th>服務對象</th>
			<th>政府輔助項目</th>
			<th>醫療服務</th>
			<th>專業照顧</th>
			<th>特色服務</th>
		</tr>
		<c:forEach var="listAgency" items="${andAgencyDataList }">
			<tr>
				<td>${andAgencyData.id }</td>
				<td><img width="100" src="${contextRoot}/listImage/${andAgencyData.agencyPhoto}" /></td>
				<td>${andAgencyData.name }</td>
				<td>${andAgencyData.agencyType}</td>
				<td>${andAgencyData.telephone }</td>
				<td>${andAgencyData.addres }</td>
				<td>${andAgencyData.serveTime }</td>
				<td>${andAgencyData.roomType }</td>
				<td>${andAgencyData.bedNumber }</td>
				<td>${andAgencyData.serveTarget }</td>
				<td>${andAgencyData.governmentSubsidy }</td>
				<td>${andAgencyData.medicalService }</td>
				<td>${andAgencyData.professionalCare }</td>
				<td>${andAgencyData.featureService }</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>