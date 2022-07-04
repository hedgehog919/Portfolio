<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>修改輔具頁面</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

</head>
<h1>修改輔具頁面</h1>

<form:form class="addAuxiliaryForm" method="POSt"
	modelAttribute="editAuxiliary">
	<!-- 以下為BOOTStrap -->
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">輔具名稱</span>
		</div>
		<form:input path="auxiliaryName" class="form-control" placeholder="輸入名稱"
			aria-describedby="basic-addon1"/>
	</div>
	
		<div class="form-group">
			<label for="exampleFormControlFile1">傳入照片</label> 
			<form:input path="auxiliaryPhoto" type="file" class="form-control-file" id="exampleFormControlFile1"/>
		</div>
	
	<div class="form-group">
		<label for="exampleFormControlTextarea1">輸入說明欄</label>
		<form:textarea path="context" class="form-control" id="exampleFormControlTextarea1"
			rows="3"/>
	</div>
	<div>
		<form:button type="submit" class="btn btn-primary">上傳</form:button>
	</div>

</form:form>