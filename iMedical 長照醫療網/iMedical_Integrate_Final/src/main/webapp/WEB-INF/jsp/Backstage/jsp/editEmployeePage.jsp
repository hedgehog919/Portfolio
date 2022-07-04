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
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>iMedical長照醫療網編輯員工資料頁面</title>

<link href="${contextRoot}/css/backStage.css" rel="stylesheet"
	type="text/css" />

</head>
<body>





	<div
		style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 30px;">
		<img alt="圖片" src="${contextRoot}/img/header3.png" style="width: 30%;">

	</div>


	<div
		style="border: 5px solid; margin: 10px 200px 100px 200px; border-radius: 2em; background-color: white; text-align: center">
		<h1
			style="margin-top: 20px; margin-bottom: 30px; font: 50px bold; text-align: center;">編輯員工資料</h1>
		<div
			style="border: 4px solid; padding-bottom: 50px; margin: 10px 350px 100px 350px; border-style: groove; border-radius: 2em;">



			<form:form action="editEmployee" modelAttribute="someEmployee"
				enctype="multipart/form-data" method="post">

				<form:input type="hidden" path="id"
					value="<%=request.getParameter(\"id\")%>" />
				<br>
				<div class="form-group">
					<label for="employeePhoto">編輯員工照片:</label> <img alt="圖片無法顯示"
						src="${contextRoot}/Backstage/downloadImage/${empId}" /> <input
						type="file" name="employeePic" class="form-control-sm"
						aria-describedby="employeePhotoHelp" />
						
				
			
				</div>
				<div style="max-width: 100%;">
					<img style="flex: auto;" id="thumbnail" alt="尚未上傳圖片" src="" />
				</div>
				<div class="form-group">
					<label for="account">編輯員工帳號:</label>
					<form:input type="text" path="employeeAccount"
						class="form-control-sm" id="account"
						aria-describedby="accountHelp" />
				</div>
				<%-- 		<form:errors path="name" cssClass="error" /> --%>
				<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->




				<div class="form-group">
					<label for="password">編輯員工密碼:</label>
					<form:input type="password" path="employeePassword"
						class="form-control-sm" id="password"
						aria-describedby="passwordHelp" />
				</div>
				<div class="form-group">
					<label for="name">編輯員工姓名:</label>
					<form:input type="text" path="employeeName" class="form-control-sm"
						id="name" aria-describedby="nameHelp" placeholder="ex: 王曉明" />
				</div>
				<div class="form-group">
					<label for="phone">編輯員工電話號碼:</label>
					<form:input type="number" path="employeePhone"
						class="form-control-sm" id="phone" aria-describedby="phoneHelp" />
				</div>

				<div class="form-group">
					<label for="email">編輯員工電子郵件:</label>
					<form:input type="email" path="employeeEmail"
						class="form-control-sm" id="email" aria-describedby="emailHelp"
						placeholder="xxxxx@gmail.com" />
				</div>

				<div class="form-group">
					<label for="address">編輯員工地址:</label>
					<form:input type="text" path="employeeAddress"
						class="form-control-sm" id="address"
						aria-describedby="addressHelp" />
				</div>
				<div class="form-group">
					<label for="birthday">編輯員工生日:</label>
					<form:input type="date" path="employeeBirthday"
						class="form-control-sm" id="birthday"
						aria-describedby="birthdayHelp" placeholder="ex: 1998/08/08" />
				</div>

				<div class="form-group">
					<label for="level">編輯員工職等:</label>
					<form:input type="number" path="employeeLevel"
						class="form-control-sm" id="level" aria-describedby="levelHelp" />
				</div>

				<div class="form-group">
					<label for="salary">編輯員工薪資:</label>
					<form:input type="number" path="employeeSalary"
						class="form-control-sm" id="salary" aria-describedby="salaryHelp" />
				</div>

				<div class="form-group">
					<label for="onboard">編輯員工到職日期:</label>
					<form:input type="date" path="employeeOnboard"
						class="form-control-sm" id="onboard"
						aria-describedby="onboardHelp" placeholder="ex: 2020/03/04" />
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