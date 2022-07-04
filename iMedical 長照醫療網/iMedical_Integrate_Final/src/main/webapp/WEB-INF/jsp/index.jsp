<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

			<!DOCTYPE html>
			<html lang="en">

			<head>
				<title>首頁</title>
				<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
				<link href="${contextRoot}/css/jquery-ui.min.css" rel="stylesheet" />
				<!-- Bootstrap Stylesheets -->
				<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
				<!-- Owl Stylesheets -->
				<link rel="stylesheet" href="${contextRoot}/css/owl.carousel.min.css">
				<link rel="stylesheet" href="${contextRoot}/css/owl.theme.default.min.css">
				<!-- font-awesome -->
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.css">
				<!-- my javascript -->
				<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />
				<!-- Leaflet -->
				<link rel="stylesheet" href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css"
					integrity="sha512-hoalWLoI8r4UszCkZ5kL8vayOGVae1oxXe/2A4AO6J9+580uKHDO3JdHb7NzwwzK5xr/Fs0W40kiNHxM9vyTtQ=="
					crossorigin="" />
				<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

				<style>
					.item{
						cursor: pointer;
						font-size: 20px;
						border: 4px solid #bd3359;
						border-radius: 15px;
						background: linear-gradient(rgba(255,255,255,0.1), rgba(255,255,255,0.1)), url("./img/S__21356548.png");
						background-size: 100%;
						background-repeat: no-repeat;
						-webkit-text-stroke: 0.5px black;
		    			color: black;
						background-position': 80% 0%;
					}
				</style>

			</head>

			<body style="position: relative">
				<div class="btn-top-div" style="position: fixed; z-index: 5; right: 1%; bottom: 2%;">
					<a >
						<span class="fa fa-arrow-circle-up fa-2x"></span>
						<br>
						TOP
					</a>
				</div>
				<!-- header block-->
				<jsp:include page="default/myNavbar.jsp" />

				<!--slideshow start-->
				<jsp:include page="default/mySlideShow.jsp" />



				<!--main content start-->

				<section id="m_newsBlock">
					<jsp:include page="default/myNews.jsp" />
				
			
					<div class="container mt-3 mb-4" id="toolBtnContainer">
						<div class="row justify-content-center">
							<div class="toolBtn" onclick="window.open('${contextRoot}/assistiveDevice')" id="deviceBtn">
								找輔具</div>
							<div class="toolBtn" onclick="window.open('${contextRoot}/agencyData')" id="deviceBtn">找機構</div>
							<div class="toolBtn" onclick="window.open('${contextRoot}/subsidy')" id="supplyBtn">長照2.0
							</div>
							<div class="toolBtn" onclick="window.open('${contextRoot}/gosubsidy')" id="supplyBtn">長照補助
							</div>
						</div>
					</div>
				</section>
				

				<section  id="videoBlock" >
					<div class="container" id="videoContainer">
						<!-- news -->
						<div class="row h-100 m-auto justify-content-between">
							<div class="col-6">
								<div  class="videobox_outter">
									<h3 style="position: relative"><span><span style="position:relative; bottom: 3px">: </span><span>長照介紹</span></span></h3>
									<iframe width="560" height="315" src="https://www.youtube.com/embed/AFSm1ixiFow" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
									
								</div>
							</div>
							<div class="col-6">
								<div  class="videobox_outter">
									<h3 style="position: relative"><span><span style="position:relative; bottom: 3px">: </span>長照介紹</span></h3>
									<iframe width="560" height="315" src="https://www.youtube.com/embed/SCdZn0U7QhM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
									</iframe>
									
								</div>
							</div>
						</div>
					</div>
				</section>


				<!-- <hr id="r_hr"  -->
				<section id="r_block">
					<!-- related link block-->
					<div >
						<div class="container" id="r_div">
							<h3 ><span style="position: relative"><span style="position:relative; bottom: 3px">: </span>相關連結</span></h3>
							<div class="d-flex justify-content-center">
								<div class="col-12 text-center">
									<div class="owl-carousel owl-theme"></div>
								</div>
							</div>
						</div>
					</div>
				</section>

				<!--main content end-->


				<!-- contact us -->
				<jsp:include page="default/myFooter.jsp" />


				<!-- javascript block -->

				<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
				<script src="${contextRoot}/js/jquery-ui.min.js"></script>
				<script src="${contextRoot}/js/owl.carousel.js"></script>
				<script src="${contextRoot}/js/my.index.js"></script>
				<script src="${contextRoot}/js/my.map.js"></script>
				<script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"
					integrity="sha512-BB3hKbKWOc9Ez/TAwyWxNXeoV9c1v6FIeYiBieIWkpLjauysF18NzgR1MBNBXf8/KABdlkX68nAhlwcDFLGPCQ=="
					crossorigin=""></script>

			</body>
		
		</html>