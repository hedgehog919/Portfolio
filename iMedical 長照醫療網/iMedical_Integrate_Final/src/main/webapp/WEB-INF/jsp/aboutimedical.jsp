 <%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<jsp:include page="default/myNavbar.jsp" />
<head>
<meta charset="UTF-8">
<title>關於Imedical</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" />
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />


<style>

body{
	background-color: #fce39d;


}
#aging-img {
	width: 300px;
	float: left;
	padding: 20px;
}

h3{
	text-align:center;
	font-size:45px;
	letter-spacing:0.2em;

}

p{
/* 	text-align:center; */
	font-size:30px;

}


</style>
</head>
<body>
<!-- 	<h2 style="">關於Imedical</h2> -->
	
	<br>
	br
	<div id="aboutImedical" class="center" aria-labelledby="headingOne" data-parent="#accordionExample">
		<div class="about-body" style="">
			<h3>iMedical構想</h3>
				<p> 因現今社會各國人口已緩慢邁向老年人口大於壯年人口的比例，近年來我國整體人口年齡也逐漸快速邁向高齡，<br>
				國際上將65歲以上人口占總人口比率達到7%(高齡化社會)、14%(高齡社會)及20%(超高齡)，<br>
				據我國行政原院的數據，我國65歲以上老年人口占總人口的16.85%，比率逐年上升，扶養比增為41，<br>
				人口老化指數（以65歲以上人數除以未滿15歲人數所得之數）增至136.30，<br>
				而國家發展協會2021年底的統計，我國1993年時已達高齡化(7.1%)，2018年轉為高齡(14.6%)。<br> </p>
				
				<div class="aging-img"> <!-- 高齡化 -->
					<img id="aging" alt="" src="../img/高齡化.jpg">
				</div>
		</div>
		
		<div class="center">
			<h3><img alt="iMedical" src="img/iMedicalLogo.jpg" width="25%" height="8%" align="bottom"> iMedical</h3>	
			
			<br>
			<br>
			<p> iMedical主要以使用者及業者中間角色設計出的長照醫療網， <br>
				網頁設計發想是想讓會使用3C產品的長者易操作且可依分類性去查詢他們想要的資訊， <br>
				故iMeidical將長照2.0醫療相關資訊及程式設計結合起來，底色背景部分也選擇有溫度的顏色。 </p>
		</div>
	
	</div>
	
	
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>