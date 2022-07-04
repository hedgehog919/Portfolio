<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<meta charset="UTF-8">
<title>找機構</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<style type="text/css">

body{
	background-image: url("img/AgencyImg/aI01.jpg")  !important;
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
	<jsp:include page="../default/myNavbar.jsp"></jsp:include>
	<section>
	<br>
	<br>
	<div class="container">
	<div class="row justify-content-center">
		<nav class="navbar navbar-light" style="w-300">
  			<form id="agencys-navbar" class="container-fluid justify-content-start">
  				<ul class="agencys-navbar-center d-flex d-flex-row mb-3 ">
					<li><a href="${contextRoot}/Agency/viewAgency"  class="btn btn-outline-success col-me-12" type="button" style="width: 150px ">機構介紹</a></li>
    				<li><a href="${contextRoot }/Agency/selectAgencyData"  class="btn btn-outline-success col-me-12" type="button" style="width: 150px">搜尋機構</a></li>
<%--     				<li><a href="${contextRoot }/Agency/allAgencyData"  class="btn btn-outline-success col-me-12" type="button" style="width: 150px ">機構列表</a></li> --%>
  				</ul>
  			</form>
		</nav>
	
	</div>
	</div>
</section>
	
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	


</body>
</html>