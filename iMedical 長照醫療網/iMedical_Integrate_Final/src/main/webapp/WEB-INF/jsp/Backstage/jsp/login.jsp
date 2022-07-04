<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>

<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/js/bootstrap.bundle.min.js " rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>iMedical長照醫療網後台登入頁面</title>

</head>
<body>

<div class="jumbotron jumbotron-fluid">
  <div class="container">
    <h1 class="display-4"><img alt="icon" src="${contextRoot}/img/icon.png" width="90" height="90"  />iMedical後臺管理頁面登入</h1>
    <p class="lead"></p>
  </div>
</div>
	
	
	
	<div class="card border-dark " style="max-width: 18rem; margin:10px auto 10px auto; ">
  <div class="card-header">登入</div>
  <div class="card-body text-dark">
    <p class="card-text">
    
    
    <form action="employeepost" method="post">
		<div class="main-box large-padding size-500x350 middle-align">
				
			<label for="username" style=""><b>帳號:</b></label> <input type="text"
				placeholder="Enter Username" name="username" required="required">
				<br/>
				<br/>
			<label for="password"><b>密碼:</b></label> <input
				type="password" placeholder="Enter Password" name="password"
				required="required"> 
			<p style="color: red"> <b>${loginError}</b> </p>
			<button class="btn-primary" type="submit" style="margin:10px auto 10px 95px;">登入</button>
			<p style="color:red"><b>${logoutMessage}</b></p>
		</div>
	</form>
    
    
    
  </div>
</div>

	<footer class="main-footer"
		style="margin: 300px 0px 0px 0px; background-color: lightgray;">
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