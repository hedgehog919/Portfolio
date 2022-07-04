<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

body{
	background-color:#a3fff7;
	background-position: center;
	background-size: cover;
	height: 450px;
	background-repeat: no repeat;

}

</style>
</head>
<body>
	<div class="container">
		<c:forEach var="andAgencyData" items="${listAg }">
			<a href="${contextRoot }/agIdd">${andAgencyData.name }</a>
			
		</c:forEach>
	</div>
</body>
</html>