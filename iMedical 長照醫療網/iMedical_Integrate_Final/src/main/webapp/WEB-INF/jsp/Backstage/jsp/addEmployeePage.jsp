<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="tags" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">

<link href="${contextRoot}/css/backStage.css" rel="stylesheet" type="text/css" />


<title>iMedical長照醫療網新增員工頁面</title>
</head>
<body>

<div style="width:100%; text-align: center; padding-top: 20px; padding-bottom: 30px;">
<img alt="圖片" src="${contextRoot}/img/header3.png" style="width: 30%;">

</div>


	<div style="border: 5px solid; margin:10px 200px 100px 200px;  border-radius: 2em; background-color: white; text-align: center">
	<h1 style=" margin-top: 20px; margin-bottom: 30px; font: 50px bold; text-align: center;">新增員工資料</h1>
	<div style="border: 4px solid; padding-bottom: 50px; margin: 10px 350px 100px 350px; border-style: groove; border-radius: 2em;  ">
	
			<div style="max-width: 100%;">
					<img style="flex: auto;"  id="thumbnail" alt="尚未上傳圖片" src=""/>
			</div> 
			
		<form:form action="addEmployee" modelAttribute="employeeBean"  enctype="multipart/form-data"
			method="post">
			
			<form:input type="hidden" path="id" />
			<br>
			<div class="form-group" >
				<span>新增員工照片: </span>
				<input type="file" name="employeePic" id="fileImage" required="required" />
<!-- 				<input type="file" name="employeePhoto"   accept=".jpg, .png" -->
<!-- 					class="form-control-sm" id="fileImage" aria-describedby="fileImageHelp" required="required" /> -->
					
			</div>
	
			<div class="form-group" >
				<label for="account">新增員工帳號:</label>
				<form:input type="text" path="employeeAccount"  lang="en"
					class="form-control-sm" id="account" aria-describedby="accountHelp" required="required" />
			</div>
	<%-- 		<form:errors path="name" cssClass="error" /> --%>
	<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->
			<div class="form-group">
				<label for="password">新增員工密碼:</label>
				<form:input type="password" path="employeePassword" 
					class="form-control-sm" id="password" aria-describedby="passwordHelp" required="required"/>
			</div>
			<div class="form-group">
				<label for="name">新增員工姓名:</label>
				<form:input type="text" path="employeeName" class="form-control-sm"
					id="name" aria-describedby="nameHelp" placeholder="ex: 王曉明" required="required" />
			</div>
			<div class="form-group">
				<label for="phone">新增員工電話號碼:</label>
				<form:input type="number" path="employeePhone" class="form-control-sm" minlength="9" maxlength="10"
					id="phone" aria-describedby="phoneHelp" required="required"/>
			</div>
			
			<div class="form-group">
				<label for="email">新增員工電子郵件:</label>
				<form:input type="email" path="employeeEmail" class="form-control-sm"
					id="email" aria-describedby="emailHelp" placeholder="xxxxx@gmail.com" required="required"/>
			</div>		
	
			<div class="form-group">
				<label for="address">新增員工地址:</label>
				<form:input type="text" path="employeeAddress" class="form-control-sm"
					id="address" aria-describedby="addressHelp" required="required"/>
			</div>
			<div class="form-group">
				<label for="birthday">新增員工生日:</label>
				<form:input type="date" path="employeeBirthday" class="form-control-sm"
					id="birthday" aria-describedby="birthdayHelp" placeholder="ex: 1998/08/08" required="required" />
			</div>		
			
			<div class="form-group">
				<label for="level">新增員工職等:</label>
				<form:input type="number" path="employeeLevel" class="form-control-sm" min="1" max="10"
					id="level" aria-describedby="levelHelp" required="required"/>
			</div>		
			
			<div class="form-group">
				<label for="salary">新增員工薪資:</label>
				<form:input type="number" path="employeeSalary" class="form-control-sm" min="26000" max="100000"
					id="salary" aria-describedby="salaryHelp" required="required"/>
			</div>		
			
			<div class="form-group">
				<label for="onboard">新增員工到職日期:</label>
				<form:input type="date" path="employeeOnboard"  class="form-control-sm" 
					id="onboard" aria-describedby="onboardHelp" placeholder="ex: 2020/03/04" required="required"/>
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
	
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		$('#fileImage').change(function(){
			showImageThumbnail(this);
		});
		
		
	});
	
	function showImageThumbnail(fileInput){
		file = fileInput.files[0];
		reader = new FileReader();
		
		reader.onload = function(e){
			$('#thumbnail').attr('src', e.target.result);
		};
		
		reader.readAsDataURL(file);
		
	}
	
	
	
	</script>


</body>
</html>