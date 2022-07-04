<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="default/myNavbar.jsp"></jsp:include>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編輯頁面</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<!-- 修改照片可以用另一個葉面或AJAX -->

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

</head>
<body>
<h1>編輯商品頁面</h1>
	<ul class="list-group list-group-horizontal">
		<c:forEach var="oneOfListCommodities"
			items="${listCommodities}">
			<li class="list-group-item">
				<a class="Auxiliar-list" href="${contextRoot }/ProducePage?commodityId=${oneOfListCommodities.commodityId}">
						<figure>
							<img src="${contextRoot }/img/${oneOfListCommodities.commodityPhoto }" alt="無商品圖片" width="300">
							<figcaption><c:out value="Name: ${oneOfListCommodities.commodityName }"></c:out></figcaption>
						</figure>
				</a> <!-- value=上方的var, Bean的值 --> 
				<c:out	value="金額: ${oneOfListCommodities.amount }"></c:out>
				<c:out	value="總數量: ${oneOfListCommodities.totalQuantity }"></c:out>
				<c:out	value="總金額: ${oneOfListCommodities.amount*oneOfListCommodities.totalQuantity }"></c:out>
				<div><a href="${contextRoot }/EditCommodity?commodityId=${oneOfListCommodities.commodityId}">修改</a></div>	
				<div><a href="${contextRoot }/DeletCommodity?commodityId=${oneOfListCommodities.commodityId}">刪除</a></div>	
				
			</li>
		</c:forEach>
	</ul>
				<div><a href="${contextRoot }/AddCommodities">新增</a></div>

		<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>


</body>
</html>