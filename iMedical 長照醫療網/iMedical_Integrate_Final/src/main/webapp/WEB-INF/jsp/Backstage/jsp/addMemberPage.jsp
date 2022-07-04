<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextRoot}/css/backStage.css" rel="stylesheet" type="text/css" />

<title>新增會員頁面</title>
</head>
<body>

<div style="width:100%; text-align: center; padding-top: 20px; padding-bottom: 30px;">
<img alt="圖片" src="${contextRoot}/img/header3.png" style="width: 30%;">

</div>



	<div style="border: 5px solid; margin:10px 200px 100px 200px;  border-radius: 2em; background-color: white; text-align: center">
	<h1 style=" margin-top: 20px; margin-bottom: 30px; font: 50px bold; text-align: center;">新增會員資料</h1>
	<div style="border: 4px solid; padding-bottom: 50px; margin: 10px 350px 100px 350px; border-style: groove; border-radius: 2em;  ">


<form:form action="../addMember" modelAttribute="memberBean"
		method="post" id="memberForm">
		
		<form:input type="hidden" path="id" />
		<br>

		<div class="form-group">
			<label for="account">新增會員帳號:</label>
			<form:input type="text" path="memberAccount"
				class="form-control-sm" id="account" aria-describedby="accountHelp" required="required"/>
		</div>
<%-- 		<form:errors path="name" cssClass="error" /> --%>
<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->
		<div class="form-group">
			<label for="password">新增會員密碼:</label>
			<form:input type="password" path="memberPassword"
				class="form-control-sm" id="password" aria-describedby="passwordHelp" required="required"/>
		</div>
		<div class="form-group">
			<label for="name">新增會員姓名:</label>
			<form:input type="text" path="memberName" class="form-control-sm"
				id="name" aria-describedby="nameHelp" placeholder="ex: 王曉明" required="required"/>
		</div>
		<div class="form-group">
			<label for="phone">新增會員電話號碼:</label>
			<form:input type="number" path="memberPhone" class="form-control-sm"
				id="phone" aria-describedby="phoneHelp" required="required"/>
		</div>
		
		<div class="form-group">
			<label for="lineid">新增會員Line ID:</label>
			<form:input type="text" path="memberLineId" class="form-control-sm"
				id="lineid" aria-describedby="LineIdHelp" required="required"/>
		</div>		
		
		
		<div class="form-group">
			<label for="address">新增會員地址:</label>
			<form:input type="text" path="memberAddress" class="form-control-sm"
				id="address" aria-describedby="addressHelp" required="required"/>
		</div>
		<div class="form-group">
			<label for="email">新增會員電子郵件:</label>
			<form:input type="email" path="memberEmail" class="form-control-sm"
				id="email" aria-describedby="emailHelp" placeholder="xxxxx@gmail.com" required="required"/>
		</div>		

		<div class="form-group">
			<label for="birthday">新增會員生日:</label>
			<form:input type="date" path="memberBirthday" class="form-control-sm"
				id="birthday" aria-describedby="birthdayHelp" placeholder="ex: 1998/08/08" required="required"/>
		</div>		
		
		<div class="form-group">
			<label for="gender">新增會員性別:</label>
			<form:select form="memberForm" path="memberGender" class="form-control-sm" id="gender" aria-describedby="genderHelp" required="required">
			<form:option value="男" />
			<form:option value="女" />
			</form:select>
			
<%-- 			<form:input type="" value="12" path="memberGender" class="form-control-sm" --%>
<%-- 				id="gender" aria-describedby="genderHelp" required="required"/> --%>
		</div>		
		
				
		<form:button type="submit" class="btn btn-primary">送出</form:button>
	</form:form>
		</div>
	</div>
	
	
	

	<footer class="main-footer">
		<div class="container">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.0.01
			</div>
			<strong>Copyright © 2022-2025 <a href="">iMedical</a>.
			</strong> All rights reserved.
		</div>

	</footer>






</body>
</html>