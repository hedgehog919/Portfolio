<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<jsp:include page="../../default/messageNavbar.jsp" />
<head>
<meta charset="UTF-8">
<link href="${contextRoot}/css/myStyle.css" rel="stylesheet" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

<title>常見問題</title>

<style type="text/css">
body{
	background-color: #C1DDDF;
	background-image: url(../../img/imgText/oldpeople01.jpg);
	background-size: 40%;
	background-repeat: no-repeat;
	background-position: center;

}

#faqIme{
	width: 10cm;
	height: 4cm;

}


</style>


</head>
<body>
	
	
	
	
	
<!-- 右側內容 -------------------------------------------------->	
	<div class="container">
	<br>
	<br>
		<div class="container">
			<div class="row justify-content-center">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<a href="${contextRoot}/">
								<img id="faqIme" class="img-iMedical" alt="..." src="../../img/iMedicalLogo.jpg">
							</a>
						</li>
						
					</ol>
					<br>
						<div class="container">
							<div class="row justify-content-center">
								<h2>長照常見問題</h2>
							</div>
						</div>
				</nav>
			</div>
		</div>
		
			<br>
		<div class="container" style="font-size: 30px;">
			<div class="row justify-content-center">
					<ol>
						<li><a href="${contextRoot}/message/FAQ/faqQuestion">長期照顧特別扣除額</a></li>
						<li><a href="${contextRoot}/message/FAQ/faqQuestiontwo">長照服務申請及評估</a></li>
						<li><a href="${contextRoot}/message/FAQ/faqQuestionthree">長照機構法人</a></li>
						<li><a href="${contextRoot}/message/FAQ/faqQuestionfour">長照服務法相關規定</a></li>
						<li><a href="${contextRoot}/message/FAQ/faqQuestionfive">預防延緩失能與照護計畫</a></li>
						<li><a href="${contextRoot}/message/FAQ/faqQuestionsix">其他</a></li>
					</ol>
			</div>
	 	</div>




	</div>
</body>
</html>