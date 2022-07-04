<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>iMedical長照醫療網管理機構頁面</title>
</head>
<body>
	<div style="height: 150px;"></div>
	<h1 style="text-align: center;">管理所有機構</h1>

	<div style="width: 100%;">

		<c:forEach var="list" items="${page.content}">


			<%-- <h3>${list.agencyName}</h3> --%>
			<%-- <i class="fa fa-map-marker icon-darker fa-lg fa-fw">${list.agencyAddress} &nbsp</i> --%>
			<%-- <div class="div.left"><img alt="圖片無法顯示" src="${contextRoot}/Backstage/downloadImageAgency/${list.id}"> </div> --%>
			<%-- <div class="div.right"><p>${list.workingHours}</p> </div> --%>
			<!-- <hr> -->


			
			<div class="card" style=" width: 80%; margin-bottom: 150px; margin-left:10%; margin-right:10%;  text-align: center; ">
				<img style="width: 100%;" src="${contextRoot}/Backstage/downloadImageAgency/${list.id}"
					class="card-img-top" alt="...">
				<div class="card-body">
					<h5 class="card-title">機構名稱: ${list.agencyName }</h5>

				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">機構類型: ${list.agencyType}</li>
					<li class="list-group-item">房型: ${list.roomType}</li>
					<li class="list-group-item">機構地址: ${list.agencyAddress}</li>
					<li class="list-group-item">床數: ${list.bedNumber}</li>
					<li class="list-group-item">營業時間: ${list.workingHours}</li>
					<li class="list-group-item">機構電話: ${list.agencyPhone}</li>
				</ul>
				<div class="card-body">
					<span>政府補助: ${list.governmentSubsidy}</span>
				</div>
			<div class="card">
				<h5 class="card-header">Featured</h5>
				<div class="card-body">
					<h5 class="card-title">服務項目</h5>
					<p class="card-text">服務對象: ${list.serveTarget}</p>
					<p class="card-text">醫療服務: ${list.medicalService}</p>
					<p class="card-text">專業照護: ${list.professionalCare}</p>
					<p class="card-text">特色服務: ${list.featureService}</p>
				</div>
			</div>
			<p>
				<a href="${contextRoot}/Backstage/goEditAgency?id=${list.id}"
						>編輯此機構</a>
			</p>
			
			<p>
				<a href="${contextRoot}/Backstage/deleteAgency?id=${list.id}"
						onclick="return confirm('確認刪除嗎?')">刪除此機構</a>
			</p>
			</div>
			

			
			<hr>
		</c:forEach>


		<div class="row justify-content-center" style="text-align: center;">
			<div class="col-9">
				<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
					<c:choose>
						<c:when test="${page.number!=pageNumber-1 }">
							<a href="${contextRoot}/Backstage/getAllAgency?p=${pageNumber}">
								<c:out value="${pageNumber}"></c:out>
							</a>
						</c:when>
						<c:otherwise>
							<c:out value="${pageNumber}"></c:out>
						</c:otherwise>


					</c:choose>
					<c:if test="${pageNumber != page.totalPages}"></c:if>

				</c:forEach>
			</div>
		</div>

	</div>



	<footer class="main-footer" style="margin-top: 100px;">
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