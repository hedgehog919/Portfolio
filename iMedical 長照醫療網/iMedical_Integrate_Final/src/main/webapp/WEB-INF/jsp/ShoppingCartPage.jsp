<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="default/myNavbar.jsp"></jsp:include>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

<script src="${contextRoot }/js/shoppingCart.js"></script>
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
<div id="myCart">

<br>
<br>
	<div>
		<div class="container">
			<div class="row justify-content-center" >
				<h1>購物車</h1>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row justify-content-center">
			<header id="cartList">
			
				<table style="border-bottom:1px solid #ddd;">
					<tr class="itemHead">
						<td style="width:200px;">商品列表</td>
						<td style="width:280px;">商品名稱</td>
						<td style="width:170px;">單價($)</td>								
						<td style="width:60px;">數量(s)</td>
						<td style="width:170px;">總金額($)</td>	
					</tr>					
				</table>
	
				<!-- 動態新增開始 -->
				<!-- 
				<div>
					<table>
						<tr class="item">
							<td style="width:200px;">
								<img src="./imgs/formosa.jpg" width="70">
							</td>
							<td style="width:280px;" id="A1001">
								<p>Formosa</p>
								<button>Delete</button>
							</td>
							<td style="width:170px;">
								<p>5000</p>
							</td>								
							<td style="width:60px;">
								<input type="number" value="1" min="1">
							</td>
							<td style="width:170px;">總金額
								<p>xxxxx</p>
							</td>	
						</tr>					
					</table>
				</div> 
				-->
				<!-- 動態新增結束 -->
			</header>  
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			  <div class="container">
			  		<div class="row justify-content-center">
						<footer style="text-align:right;">
							Total : <span id="total">0</span>
							<form method="POST">
							<button type="submit" onclick="goCheckout()" class="btn btn-primary addButton">結帳</button>
							</form>
						</footer>
			  		</div>
			  </div>       
		</div>
		</div>
	</div>	
		
		<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
		
</body>
</html>