<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<title>iMedical輔具</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />


<style type="text/css">
body {
	background-image: url(img/AssristiveDevice/02.jpg);
	background-repeat: no repeat;
	background-size: cover;
}


</style>

</head>

<body>
	<!-- 	<h1>輔具頁面</h1> -->

	<!-- item=Control的GetMapping的put().content  -->
	
	<jsp:include page="../default/myNavbar.jsp"></jsp:include>
	<ul class="list-group list-group-horizontal">
		<c:forEach var="oneOfListAuxiliary" begin="0" end="3"
			items="${listAuxiliary}">
			<li class="list-group-item"><a class="Auxiliar-list" href="點擊">
					<figure>
						<img src="${oneOfListAuxiliary.auxiliaryPhoto }" alt="目標輔具">
						<figcaption>
							<span> <c:out
									value="Name: ${oneOfListAuxiliary.auxiliaryName }"></c:out>
							</span>
						</figcaption>
					</figure>
			</a> <!-- value=上方的var, Bean的值 --> <c:out
					value="內容${oneOfListAuxiliary.context }"></c:out></li>
		</c:forEach>
	</ul>

	<div class="container">
		<div class="row justify-content-center">
		<nav class="navbar navbar-light bg-light" style="margin-left:28px; margin-top:10px;">
			<form class="container-fluid justify-content-start">
			
<!-- 				<div> -->
<%-- 					<a href="${contextRoot }/Auxiliary/addAuxiliaryPage" role="button" class="btn btn-info" >新增輔具</a> --%>
<!-- 				</div> -->
			
				<div>
					<a href="${contextRoot }/Auxiliary/assistiveDeviceIntroduce" role="button" class="btn btn-info" >輔具介紹</a>
				</div>
				
				<div>
       				<a href="${contextRoot }/Auxiliary/buyAssistiveDevice" role="button" class="btn btn-info" >申請免費輔具</a>
				</div>

			</form>
		</nav>
		</div>
	</div>

	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

</body>
</html>