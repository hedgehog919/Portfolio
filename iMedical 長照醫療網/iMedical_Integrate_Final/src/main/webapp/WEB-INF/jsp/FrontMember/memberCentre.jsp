<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 	<jsp:include page="../index.jsp"></jsp:include> --%>
	<jsp:include page="../default/myNavbar.jsp"></jsp:include>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />
<title>iMedical會員中心</title>


<style type="text/css">
body {
	background-color: #FEF2AA;
	background-image: url("../img/imgText/mes2.jpg") ;
/* 	background-opacity: 0.5;  */
	background-repeat: no-repeat;
	background-size: 60%;
	background-position: center;
}




</style>
</head>

<body>

	<br>
	
		<div  class="container">
			<div class="row justify-content-center">
					<div class="col-7 " style="text-align: center">
						<h3>歡迎來到~ </h3>
						<br>
						<h2>iMedical長照醫療網的會員中心 ^^ </h2>
					</div>
			</div>
		</div>
		
<!-- 		<div> -->
<%-- 			<a href="${contextRoot}/"><button>首頁</button></a> --%>
<!-- 		</div> -->
		
		<br>
		<br>
		<br>
		<div class="container">
			<div class="row justify-content-center">
			<nav class="navbar navbar-expand-lg navbar navbar-light" style="font-size: 30px; background-color: #FCDD6E;">
				<div class=container-fluid>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li><a class="nav-link active" href="${contextRoot}/FrontMember/memberData">會員資料</a></li>
<%-- 							<li><a class="nav-link active" href="${contextRoot}/Agency/selectAgencyData">收藏機構</a></li> --%>
							<li><a class="nav-link active" href="${contextRoot }/FrontMember/listassistiveDevice">申請輔具清單</a></li>
							<li><a class="nav-link active" href="${contextRoot }/FrontMember/ShoppingCartList">商品清單</a></li>
							
<!-- 							<li><a class="nav-link active" href="#">購物清單</a></li> -->
<!-- 							<li><a class="nav-link active" href="#">留言紀錄</a></li> -->
							
<!-- 							<li> -->
<!-- 				                <a class="nav-link active" href="#" data-bs-toggle="modal" data-bs-target="#signOut">登出</a> -->
<!-- 				            </li> -->
						</ul>
					</div>
				</div>
			</nav>
			</div>
		</div>

<!-- ----------------------------------------------------------------------------------------------------------------------------- -->

<!-- 會員登出 -->
<div class="modal fade" id="signOut" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">會員登出</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                您確定要登出嘛?
            </div>
            
            <div class="modal-footer">
                <a href="signOut">
                    <button type="button" class="btn btn-primary">登出</button>
                </a>
            </div>
        </div>
    </div>
</div>





<!-- 會員中心 Css版 -->

	<!-- 	<div class="list-group"> -->
	<!-- 		<h2> 歡迎來到~iMedical長照醫療網的會員中心 ^^ </h2> -->
	<!-- 		<a href="#" class="list-group-item list-group-item-action active" -->
	<!-- 			aria-current="true">會員基本資料</a> <a href="#" -->
	<!-- 			class="list-group-item list-group-item-action">收藏機構</a> <a href="#" -->
	<!-- 			class="list-group-item list-group-item-action">參訪記錄</a> <a href="#" -->
	<!-- 			class="list-group-item list-group-item-action">收藏輔具</a> <a -->
	<!-- 			class="list-group-item list-group-item-action disabled">詢問記錄</a> -->
	<!-- 	</div> -->
</body>
</html>