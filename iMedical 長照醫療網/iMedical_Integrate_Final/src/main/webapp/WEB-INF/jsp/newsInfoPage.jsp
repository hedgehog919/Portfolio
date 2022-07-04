<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>公告消息</title>
			<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
			<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.css">
			<!-- my javascript -->
			<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />
			<link rel="stylesheet" href="${contextRoot}/css/my.newsInfo.css" />
			<link rel="stylesheet" href="${contextRoot}/css/my.newsInfoPage.css" />
			<link rel="stylesheet" href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css"
					 />
		</head>

		<body>
			<!-- header block-->
			<jsp:include page="default/myNavbar.jsp" />

			<section class="pt-5 pb-5 " id="newsInfoPageSection">
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-8" id="newsInfoPageCol">
							<div class="mb-4">
								<span class="fa fa-home" aria-hidden="true">
								</span> 
								<a href="${contextRoot}">首頁
								</a> >> 
								<c:choose>
									<c:when test="${newsMsg.category == '活動快報'}">
										<span>活動快報</span>
									</c:when>
									<c:otherwise>
										<span>最新公告</span>
									</c:otherwise>	
								</c:choose>
							</div>
							<div id="newsInfoPageArticle">
								<div class="mb-3">
									<p>
										<span id="title">公告標題:</span> 
										<span>${newsMsg.title}</span>
									</p>
									<hr/>
									<i class="fas fa-caret-right mr-1"></i><span> <fmt:formatDate pattern="yyyy-MM-dd" value="${newsMsg.date}"/></span>
								</div>
								<div class="page-font d-flex justify-content-between mb-1 p-1">
									<div>
										內文:
									</div>
                                    <div class="inline-block">
	                                    字級大小：
										<span style="cursor: pointer" onclick="changeSize(0);">大</span>
	                                    <span style="cursor: pointer" onclick="changeSize(1);">中</span>
	                                    <span style="cursor: pointer" onclick="changeSize(2);">小</span>
                                	</div>
                                </div>
								<div id="text">
									<p>${newsMsg.text}</p>
								</div>
							</div>	
							<div class="d-flex justify-content-center mt-3 mb-3">
								<a href="javascript:history.back()" title="回上一頁">
									<button type="button" class="btn btn-info">
										回上一頁
									</button>
								</a>	
							</div>
						</div>
					</div>
				</div>
			</section>
			<jsp:include page="default/myFooter.jsp"/>
				
			<script>	
				function changeSize(s) {				
					if (s == 0) {
						$('#text p').animate({
							'font-size':'26px',
						})
						
					} else if (s == 1)
						$('#text p').animate({
							'font-size':'20px',
						})
					else {
						$('#text p').animate({
							'font-size':'18px',
						})
					}
				}
			</script>

			<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
			<script src="${contextRoot}/js/my.map.js"></script>
			<script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"
					></script>
		</body>

		</html>