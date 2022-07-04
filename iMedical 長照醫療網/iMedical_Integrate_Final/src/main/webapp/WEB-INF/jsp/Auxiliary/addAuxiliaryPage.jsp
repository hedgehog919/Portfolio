<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>新增輔具</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />



</head>
<h2>新增輔具表單</h2>

<form:form class="addAuxiliaryForm" method="post"
	modelAttribute="assistiveDevices">
	<!-- 以下為BOOTStrap -->
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">輔具名稱</span>
		</div>
		<form:input path="name" class="form-control" placeholder="輸入名稱"
			aria-describedby="basic-addon1"/>
	</div>
	
		<div class="form-group">
			<label for="exampleFormControlFile1">傳入照片</label> 
			<form:input path="assistiveDeviceImg" type="file" class="form-control-file" id="exampleFormControlFile1"/>
		</div>
	
	<div class="form-group">
		<label for="exampleFormControlTextarea1">輸入說明欄</label>
		<form:textarea path="assistiveDevice" class="form-control" id="exampleFormControlTextarea1"
			rows="3"/>
	</div>
	<div>
		<form:button type="submit" class="btn btn-primary">上傳</form:button>
	</div>

</form:form>

<%-- 	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script> --%>


