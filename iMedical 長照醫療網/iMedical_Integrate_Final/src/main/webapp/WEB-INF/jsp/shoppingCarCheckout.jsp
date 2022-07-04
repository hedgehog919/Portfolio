<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="default/myNavbar.jsp"></jsp:include>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>結帳</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

<script src="${contextRoot }/js/shoppingCart.js"></script>
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />


<style type="text/css">
body{
	background-color: #D2B48C;


}

</style>

</head>
<body>

		<div>
		
			
		<div>
			<br>
			<br>
			<div class="container">
				<div class="row justify-content-center">
				<h2>恭喜您 <sec:authentication property="name" /> ~ 結帳成功 </h2>			
				</div>
			</div>
			
			<div>
				<sec:authorize access="authenticated" var="authenticated" />
						<c:choose>
							<c:when test="${authenticated}">
							
<%-- 								<a class="nav-link" href="${contextRoot}/ShoppingCartPage"> --%>
									<br>
									<br>
									<div class="container">
										<div class="row justify-content-center">
											<form action="Commodities">
												<button type="submit">返回商店</button>
											</form>
										</div>
									</div>
<!-- 									<span class="fas fa-user-cog"></span> -->
									
										
<!-- 								</a> -->
								
							</c:when>
						</c:choose>
			</div>
			
			
		</div>
			
			
		</div>
		
		
		<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
		
</body>
</html>