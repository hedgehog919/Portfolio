<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>查看機構</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<style type="text/css">
body{
	background-image: url("${contextRoot}/img/AgencyImg/aI02.jpg");
 	background-attachment: scroll; 
	background-position: center;
	background-size: cover;
	background-repeat: no repeat;
	background-opacity: 0;
	
}

.row{
	justify-content: center;
}
</style>
</head>
<body>


<!-- 左側選單-------------------------------------------------------------------------------- -->
		<br>
	<div class="cotainer">
		<div class="row position-absolute top-100% start-100%  bottom-50% ">	
			<div class="list-group">
	  			<a href="${contextRoot}/Agency/viewAgency"><button type="button" class="list-group-item list-group-item-action active" aria-current="true">機構介紹</button></a>
			    <a href="${contextRoot }/Agency/selectAgencyData"><button type="button" class="list-group-item list-group-item-action">搜尋機構</button></a>
<%-- 			    <a href="${contextRoot }/Agency/allAgencyData"><button type="button" class="list-group-item list-group-item-action">機構列表</button></a> --%>
			</div>
		</div>
	</div>
	


<!-- 右側選單----------------------------------------------------- -->
<br>
<br>
	<div class="cotainer">
		<div class="row justify-content-center">
			<h3>查看機構</h3>	
		</div>
	</div>
		
		<div class="container border border-dark border-6">
		<div class="row gx-5 justify-content-c1enter">

				<form:form action="${contextRoot }/listname" >
					<p style="font-size: 25px">關鍵字:</p><input type="text" name="name" id="name"  value="${name }" />
				<br />
					<br>
					<h4>機構類型</h4>
					<div class="container" style="font-size: 25px;">
					<div class="row">
						<label ><input type="radio" name="name" id="" value="" ><span>全部</span></label> <br>
						<label><input type="radio" name="name" id="name2" value="${name2 }"><span>長期照顧中心(養護中心)</span></label>
						<label><input type="radio" name="name" id="" value="a"><span>護理之家</span></label>
						<label><input type="radio" name="name" id="" value="a"><span>安養中心(安養院)</span></label>
						<label><input type="radio" name="name" id="" value="a"><span>住宿長照機構</span></label>
						<label><input type="radio" name="name" id="" value="a"><span>日間照顧中心</span></label>
					</div>
					</div>
						<br>
					<div class="text-center"><input type="submit" value="搜尋"></div>
						<br>
				</form:form>
				</div>
			</div>
	
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>