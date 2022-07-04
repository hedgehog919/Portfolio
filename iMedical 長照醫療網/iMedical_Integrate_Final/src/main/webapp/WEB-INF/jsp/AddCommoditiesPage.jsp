<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="layout/Navbar.jsp"></jsp:include>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>新增商品頁面</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

</head>
<h1>新增商品頁面</h1>
<form:form class="addCommoditiesForm" method="POSt"
	modelAttribute="addCommodities" >
	<!-- 以下為BOOTStrap -->
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">輸入商品名稱</span>
		</div>
		<form:input path="commodityName" class="form-control" placeholder="輸入名稱"
			aria-describedby="basic-addon1" value="毛巾"/>
	</div>
	
		<div class="form-group">
			<label for="exampleFormControlFile1">傳入照片</label> 
			<form:input path="commodityPhoto" type="file" class="form-control-file" id="exampleFormControlFile1"/>
			
		</div>

<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">輸入商品價錢</span>
		</div>
		<form:input path="amount" class="form-control" placeholder="輸入價錢"
			aria-describedby="basic-addon1" value="100"/>
	</div>	
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">輸入商品總數</span>
		</div>
		<form:input path="totalQuantity" class="form-control" placeholder="輸入總數"
			aria-describedby="basic-addon1" value="100"/>
	</div>
	
			<form:input path="totalAmount" type="hidden" value="${addCommoditiesForm.amount*addCommoditiesForm.totalQuantity }"/>
	
	<div>
		<button type="submit" class="btn btn-primary">上傳</button>
	</div>

</form:form>