<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
		<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
		 

		<header class="h_block" id="top">
			<div class="container-fluid m-auto" id="h_div1">
				<nav class="navbar navbar-expand-lg navbar-light d-flex justify-content-between p-0">
					<div id="h_title">
						<a class="navbar-brand d-flex justify-content-start align-items-center m-auto" style="flex: 1"
							href="${contextRoot}">
							iMedical
						</a>
					</div>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<div id="h_items" style="flex: 1;">
							<div class="container-fluid d-flex justify-content-end p-0" style="max-width: 1280px;">
								<div class="topLink-box">
									<ul class="nav">
									
<!-- 									登出 -->
										<sec:authorize access="authenticated" var="authenticated" />
										<c:choose>
											<c:when test="${authenticated}">
												<form action="${contextRoot}/logout">
														<button type="submit" class="btn btn-outline-dark">登出</button>
													</form>
											</c:when>
										</c:choose>
<!-- 									/登出 -->
									
										<li class="nav-item">
										
<!-- 											//判斷有無登錄後台 -->
											<sec:authorize access="authenticated" var="authenticated" />
											<c:choose>
												<c:when test="${authenticated}">
													<a class="nav-link" href="${contextRoot}/Backstage">
														<span class="fas fa-tools"></span> 後台管理
													</a>
												</c:when>
												<c:otherwise>
													<a class="nav-link" href="${contextRoot}/Backstage/employeelogin">
														<span class="fas fa-tools"></span> 後台管理
													</a>
												</c:otherwise>
											</c:choose>
<!-- 											// -->
										
										</li>
										<li class="nav-item">
<!-- 											//判斷有無登錄會員 -->
											<sec:authorize access="authenticated" var="authenticated" />
											<c:choose>
												<c:when test="${authenticated}">
													<a class="nav-link" href="${contextRoot}/FrontMember/memberCentre">
														<span class="fas fa-user-cog"></span>
														歡迎,
														<sec:authentication property="name" />
													</a>
												</c:when>
												<c:otherwise>
													<a class="nav-link" href="${contextRoot}/frontMemberLogin">
														<span class="fas fa-user-cog"></span> 會員中心
													</a>
												</c:otherwise>
											</c:choose>
<!-- 											// -->
										</li>
										<li class="nav-item">
											<a class="nav-link" href="${contextRoot}/ShoppingCart">
												<span class="fas fa-shopping-cart"></span> 購物車
											</a>
										</li>
									</ul>
								</div>
							</div>
							<!-- navbar block -->
							<div class="container-fluid p-0" style="max-width: 1280px;" id="my-navbar">
								<nav class="navbar navbar-expand-lg" style="width: 50%">
									<div class="d-flex navbar-nav nav-fill w-100">
										<a class="nav-item nav-link" href="${contextRoot}/aboutimedical">關於我們</a>
										<a class="nav-item nav-link" href="${contextRoot}/agencyData">找機構</a>
										<a class="nav-item nav-link" href="${contextRoot}/assistiveDevice">找輔具</a>
										<a class="nav-item nav-link" href="${contextRoot}/subsidy">長照2.0</a>
										<a class="nav-item nav-link" href="${contextRoot}/gosubsidy">長照補助</a>
										<a class="nav-item nav-link" href="${contextRoot}/messageNavbar">留言板</a>
										<a class="nav-item nav-link" href="${contextRoot}/Commodities">商店</a>
									</div>
								</nav>
								<form id="SiteSearchForm" class="form-inline " method="post">
									<input type="search" class="form-control" placeholder="search">
									<button class="btn btn-outline-secondary" type="button" id="h_searchBtn">搜尋</button>
								</form>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</header>