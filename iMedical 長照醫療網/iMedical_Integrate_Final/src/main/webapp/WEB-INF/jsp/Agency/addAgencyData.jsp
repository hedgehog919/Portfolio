<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<html>

<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>新增機構</title>

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
<br>
<br>

<div class="cotainer">
	<div class="row justify-content-center mb-3">
		<h2>新增機構資料</h2>
	</div>
</div>

<div class="container">
	<div class="row gx-5 justify-content-center">
		<form:form action="${contextRoot}/addAgencys" modelAttribute="agencyDatas" method="post" enctype="multipart/form-data">
			機構名稱:<form:input type="text" path="name" />
			<br />
			機構類型:<form:input type="text" path="agencyType" />
			<br />
<!-- 			機構環境圖片:<input type="file" name="file" value="agencyPhoto"/> -->
			<br />
			機構電話:<form:input type="text" path="telephone" />
			<br />
			機構地址:<form:input type="text" path="addres" />
			<br />
			服務時間:<form:input type="text" path="serveTime" />
			<br />
			房型: <form:input type="text" path="roomType" />
			<br />
			床數: <form:input type="text" path="bedNumber" />
			<br />
			服務對象:<form:input type="text" path="serveTarget" />
			<br />
			政府輔助項目:<form:input type="text" path="governmentSubsidy" />
			<br />
			醫療服務:<form:input type="text" path="medicalService" />
			<br />
			專業照顧:<form:input type="text" path="professionalCare" />
			<br />
			特色服務:<form:input type="text" path="featureService" />
			<br />
			
			<button onclick="return confirm('確定送出嗎?')">送出</button>
<!-- 			<a  type="button" id="button" value="送出" onclick="return confirm('確定送出嗎?')">送出</a> -->
		</form:form>
	
	
			<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
		</div>
	</div>
</body>
</html>