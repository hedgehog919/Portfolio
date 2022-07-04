<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<jsp:include page="../default/myNavbar.jsp" />

<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>iMessage</title>
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<style type="text/css">
body {
	background-color: #FFFFF0;
	background-image: url(img/imgText/01.jpg);
 	background-position: bottom ; 
	background-repeat: no-repeat;
 	background-size:  900px; 
}




</style>
</head>
<body>
		
		<div class="container" style="background-color: #FDE3D3;">
			<div class="row justify-content-center">
				<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #FFFACD;">
					<a class="navbar-brand" href="${contextRoot}/messageNavbar">iMessage</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span>
					</button>
			
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav mr-auto">
			
							 <li class="nav-item">
			        			<a class="nav-link" href="${contextRoot}/message/addMsg">新增留言</a>
			      			 </li>	
			      			 
			      			 <li class="nav-item">
			       				 <a class="nav-link" href="${contextRoot}/message/viewMessages">查看最新</a>
			     			 </li>
			
							 <li class="nav-item">
			       				 <a class="nav-link" href="${contextRoot}/message/FAQ/faq">FAQ</a>
			     			 </li>
						</ul>
			
			<!-- 			<form class="form-inline my-2 my-lg-0"> -->
			<!-- 				<input class="form-control mr-sm-2" type="search" -->
			<!-- 					placeholder="Search" aria-label="Search"> -->
			<!-- 				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button> -->
			<!-- 			</form> -->
			
					</div>
				</nav>
				</div>		
			</div>
		</div>

	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

</body>
</html>