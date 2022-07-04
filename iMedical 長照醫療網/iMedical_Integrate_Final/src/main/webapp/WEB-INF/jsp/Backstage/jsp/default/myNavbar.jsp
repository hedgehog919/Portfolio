<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
</head>
<body>



		
	<nav class="navbar navbar-expand-lg navbar-light bg-light ">
		<a class="navbar-brand" href="${contextRoot}/Backstage"> <img alt="" src="${contextRoot}/img/icon.png" width="30" height="30"> iMedical長照醫療後台管理</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target=#navbarNav aria-controls="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="dropdown" style="margin-left: 20px">
			<button class="btn btn-secondary dropdown-toggle" type="button"
				id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false">管理
			</button>
		
				
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item" href="${contextRoot}/Backstage/getallEmployee">管理所有員工</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/getAllMember">管理所有會員</a> 
				<a class="dropdown-item" href="${contextRoot}/Backstage/getAllRealAssistiveDevice">管理所有輔具</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/getAllAssistiveDeviceApplicationForm">管理所有輔具申請表單</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/getAllAgency">管理所有機構</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/getAllCommodities">管理所有商品</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/searchAllNews">管理公告訊息</a>
			</div>
		</div>

		<div class="dropdown" style="margin-left: 20px">
			<button class="btn btn-secondary dropdown-toggle" type="button"
				id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false">
				新增</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item" href="${contextRoot}/Backstage/goAddEmployee">新增員工</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/goAddMember">新增會員</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/goAddRealAssistiveDevice">新增輔具</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/goAddAgency">新增機構</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/goAddCommodities">新增商品</a>
				<a class="dropdown-item" href="${contextRoot}/Backstage/addNewsMessage">新增公告</a>
			</div>
		</div>
		
		<div class="btn btn-secondary" style="margin-left: 20px">
				<a style="color:background; text-decoration: none;" class="navbar-nav" href="${contextRoot}/Backstage/getAllEditLog">查看所有後台編輯紀錄</a>
		</div>
		

		<div style="margin-left: auto; margin-right: 0px;">
		<c:choose>
			<c:when test="${loginSession!=null}">
				<div class="navbar" id="navbarNav" >
						<img alt="尚未上傳照片" style="width: 40px; height: 40px; margin-right: 10px; font-size: xx-small;" src="${contextRoot}/Backstage/downloadImage/${loginSession[0].id}"><img/>
					<ul class=navbar-nav>
						<ins style="vertical-align:bottom;">登入者 ${loginSession[0].employeeName} </ins> 
					  <li class="nav-item"><a class="nav-link" href="${contextRoot}/Backstage/logout">登出</a></li>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="navbar" id="navbarNav" >
<!-- 					<ul class=navbar-nav> -->
						<span class="nav-item" ><a class="nav-link" 
							href="${contextRoot}/Backstage/employeelogin">登入</a></span>
<!-- 					</ul> -->
				</div>
			</c:otherwise>
		</c:choose>
		</div>














	</nav>















































</body>
</html>