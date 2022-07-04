<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>iMedical長照醫療網後台管理</title>
</head>
<body style="background-image: url('${contextRoot}/img/backstage/bg.jfif');">








	<div id="carouselExampleIndicators" class="carousel slide" style="margin: 20px 500px 100px 500px;"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${contextRoot}/img/backstage/slide1.jfif" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="${contextRoot}/img/backstage/slide2.jfif" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="${contextRoot}/img/backstage/slide3.jfif" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-target="#carouselExampleIndicators" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-target="#carouselExampleIndicators" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
		</button>
	</div>









	<div class="content-wrapper" style="min-height: 621px;">
		<div class="container">

			<section class="content-header">

				<ol class="breadcrumb">
					<li><a href="${contextRoot}/"><i class="fa fa-dashboard">點擊連結前台首頁Home</i>
					</a></li>

					<li class="active"></li>
				</ol>
			</section>

			<section class="content">
				<div class="callout callout-info"
					style="background-color: rgb(240, 207, 41); border-radius: 30px; padding: 30px 30px 30px 30px; margin-bottom: 35px;">
					<h4>歡迎來到iMedical後台管理頁面!</h4>
					
					<p>輕鬆管理企業會員、員工、前端網頁...等資料</p>
					<p style="color: red; font-size: large;"> <b>使用結束請務必登出!</b> </p>
				</div>
				<!-- <div class="callout callout-danger" style="background-color: threedhighlight;">
					<h4>在此輸入訊息</h4>
					<p>在此輸入訊息</p>
				</div>
				<div class="box box-default" style="background-color: threedhighlight;">
					<div class="box-header with-border">
						<h3 class="box-title">在此輸入訊息</h3>
					</div>
					<div class="box-body">在此輸入訊息</div>

				</div> -->

			</section>

		</div>

	</div>

	<footer class="main-footer"
		style="margin-top: 100px; background-color: lightgray;">
		<div class="container" style="width: 100%; text-align: center;">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.0.01
			</div>
			<strong>Copyright © 2022-2025 <a href="">iMedical</a>.
			</strong> All rights reserved.
		</div>

	</footer>

</body>
</html>