<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iMedical長照醫療網編輯商品資料頁面</title>

<link href="${contextRoot}/css/backStage.css" rel="stylesheet"
	type="text/css" />

</head>
<body>

	<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 30px;">
		<img alt="圖片" src="${contextRoot}/img/header3.png" style="width: 30%;">

	</div>




	<div style="border: 5px solid; margin:10px 200px 100px 200px;  border-radius: 2em; background-color: white; text-align: center">
	<h1 style=" margin-top: 20px; margin-bottom: 30px; font: 50px bold; text-align: center;">編輯商品資料</h1>
	<div style="border: 4px solid; padding-bottom: 50px; margin: 10px 350px 100px 350px; border-style: groove; border-radius: 2em;  ">


	<form:form action="editCommodities" modelAttribute="someCommodities"
		enctype="multipart/form-data" method="post">

		<form:input type="hidden" path="commodityId"
			value="<%=request.getParameter(\"id\")%>" />
		<br>
		<div class="form-group">
			<label for="commoditiesPic">編輯商品照片:</label> <img alt="尚未上傳圖片"
				src="${contextRoot}/Backstage/downloadImageCommodities/${comId}" />
			<input type="file" name="commoditiesPic" class="form-control-sm"
				aria-describedby="employeePhotoHelp" />
		</div>
		<div class="form-group">
			<label for="commodityName">編輯商品名稱:</label>
			<form:input type="text" path="commodityName" class="form-control-sm"
				id="commodityName" aria-describedby="accountHelp" />
		</div>
		<%-- 		<form:errors path="name" cssClass="error" /> --%>
		<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->




		<div class="form-group">
			<label for="amount">編輯商品金額:</label>
			<form:input type="number" path="amount" class="form-control-sm"
				id="amount" aria-describedby="passwordHelp" />
		</div>
		<div class="form-group">
			<label for="totalAmount">編輯商品總金額:</label>
			<form:input type="number" path="totalAmount" class="form-control-sm"
				id="totalAmount" aria-describedby="nameHelp" placeholder="ex: 王曉明" />
		</div>
		<div class="form-group">
			<label for="totalQuantity">編輯商品總數量:</label>
			<form:input type="number" path="totalQuantity"
				class="form-control-sm" id="totalQuantity"
				aria-describedby="phoneHelp" />
		</div>



		<form:button type="submit" class="btn btn-primary">送出</form:button>
	</form:form>
		</div>
	</div>


	<footer class="main-footer">
		<div class="container">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.0.01
			</div>
			<strong>Copyright © 2022-2025 <a href="">iMedical</a>.
			</strong> All rights reserved.
		</div>

	</footer>






</body>
</html>