<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品頁面</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<script src="${contextRoot }/js/productToSoppingCart.js"></script>
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<style type="text/css">
body{
	background-color: #f8f9fa;


}
</style>

</head>
<body>
<br>
<br>

		<div class="container">
			<div class="row justify-content-center">
				<h1>${produce.commodityName }頁面</h1>
			</div>
		</div>

		<div class="container">
			<div class="row justify-content-center">
				<!-- item=Control的GetMapping的put().content  -->
				<ul class="list-group list-group-horizontal">
						<li class="list-group-item">
							<a class="Auxiliar-list" href="點擊">
									<figure>
										<img src="${contextRoot }/img/${produce.commodityName }.jpg" alt="無商品圖片">
										<figcaption><c:out value="Name: ${produce.commodityName }"></c:out></figcaption>
									</figure>
							</a> <!-- value=上方的var, Bean的值 --> 
							<c:out	value="金額: ${produce.amount }"></c:out>
							<c:out	value="剩餘數量: ${produce.totalQuantity }"></c:out>
							<div>
								<span id="A${produce.commodityId}" class="btn btn-primary addButton">
									加入購物車
									<input type="hidden" value="${produce.commodityName}|${produce.commodityPhoto}|${produce.amount}|1|${produce.amount}">
			<!-- 						value="品名|照片名|金額|總數|總金額" -->
								</span>
							</div>
						</li>
				</ul>
			</div>
		</div>

	    <script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>