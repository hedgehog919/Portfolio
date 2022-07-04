<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="contextRoot" value="${pageContext.request.contextPath}" />
    <jsp:include page="../default/myNavbar.jsp"></jsp:include>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員訂單</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<style type="text/css">
body {
	background-color: #FEF2AA;
	background-image: url("../img/imgText/mes2.jpg");
	background-repeat: no-repeat;
	background-size: 60%;
	background-position: center;}


</style>
</head>
<body>


	<br>
	<br>
	
		<div  class="container">
			<div class="row justify-content-center">
					<div class="col-4 " style="text-align: center">
					<h2>會員訂單</h2>
					</div>
			</div>
		</div>
		
<!-- 左側選單---------------------------------------------------------------------------------->
		<br>
			<div class="row position-fixed" style="top: 25%; left: 6%; z-index: 10;">	
				<div class="list-group" style="content: counter(20);">
					<a href="${contextRoot}/FrontMember/memberCentre"><button type="button" class="list-group-item list-group-item-action active" aria-current="true" style=" background-color: #00416A; color: white ;">會員中心</button></a>
		  			<a href="${contextRoot}/FrontMember/memberData"><button type="button" class="list-group-item list-group-item-action" aria-current="true">會員資料</button></a>
				    <a href="${contextRoot }/FrontMember/listassistiveDevice"><button type="button" class="list-group-item list-group-item-action">申請輔具清單</button></a>
				    <a href="${contextRoot }/FrontMember/ShoppingCartList"><button type="button" class="list-group-item list-group-item-action">商品清單</button></a>
				</div>
			</div>


<!-- 右側內容 ---------------------------------------->
<!-- 		<div class="container"> -->
<!-- 			<div class="row justify-content-center" style="width: 30cm; height: 80cm;"> -->
<!-- 				<table class="table"> -->
<!-- 						<tr> -->
<!-- 							<th>訂單編號</th> -->
<!-- 							<th>時間</th> -->
<!-- 							<th>商品名稱</th> -->
<!-- 							<th>數量</th> -->
<!-- 							<th>備註</th> -->
<!-- 						</tr> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
	
	<br>
<div class="container" style="size: 30px; ">
	<div class="row justify-content-center">
		<div class="col-4 " style="text-align: center ; font-size: 20px; ">
				<c:forEach var="shoppingCartList" items="${shoppingCartSet}">
				<ul>
					<li>
						<c:out value="訂單編號: ${shoppingCartList.shoppingCartId }"></c:out>	
							<tr>
								<td>
									<c:out value="時間: ${shoppingCartList.shoppingCartDate }"></c:out>
								</td>
								
								<td>
									<c:out value="備註: ${shoppingCartList.remark }"></c:out>
								</td>
								
								<td>
								
		<%-- 							<c:forEach var="name" items="${scName}"> --%>
		<!-- 								<div> -->
		<%-- 									<c:out value="商品名稱: ${name }"></c:out>	 --%>
		<!-- 								</div> -->
		<%-- 							</c:forEach> --%>
									<c:forEach var="nameAndNum" items="${fn:split(shoppingCartList.shoppingCartList,'|')}">
										<div>
											<c:set var="a" value="${fn:split(nameAndNum,',')}"></c:set>
											<c:forEach var="name" items="${a[0]}">
												<c:out value="商品名稱: ${name }"></c:out>	
											</c:forEach>
											<c:forEach var="num" items="${a[1]}">
												<c:out value="數量: ${num }"></c:out>	
											</c:forEach>
										</div>
									</c:forEach>
								</td>
							</tr>
						</li>
						
				</ul>
			</c:forEach>
			</div>
		</div>
	</div>
	

</body>
</html>