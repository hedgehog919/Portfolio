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


<title>iMedical長照醫療網新增機構頁面</title>
</head>
<body>

<div style="width:100%; text-align: center; padding-top: 20px; padding-bottom: 30px;">
<img alt="圖片" src="${contextRoot}/img/header3.png" style="width: 30%;">

</div>


	<div style="border: 5px solid; margin:10px 200px 100px 200px;  border-radius: 2em; background-color: white; text-align: center">
	<h1 style=" margin-top: 20px; margin-bottom: 30px; font: 50px bold; text-align: center;">新增機構資料</h1>
	<div style="border: 4px solid; padding-bottom: 50px; margin: 10px 350px 100px 350px; border-style: groove; border-radius: 2em;  ">
			<div style="max-width: 300px; margin-left: 25%; ">
					<img style="width:300px;"  id="thumbnail" alt="尚未上傳圖片" src=""/>
			</div> 
		<form:form action="addAgency" modelAttribute="agencyBean"  enctype="multipart/form-data"
			method="post">
			
			<form:input type="hidden" path="id" />
			<br>
			<div class="form-group" >
				
<!-- 				<input type="file" name="employeePhoto"   accept=".jpg, .png" -->
<!-- 					class="form-control-sm" id="fileImage" aria-describedby="fileImageHelp" required="required" /> -->
						<div class="form-group">
				<label for="name">新增機構照片:</label>
				<input type="file" name="agencyPic" class="form-control-sm"
					id="fileImage" aria-describedby="agencyPicHelp"  required="required" />
			</div>		
			</div>
	
			<div class="form-group" >
				<label for="agencyName">新增機構名稱:</label>
				<form:input type="text" path="agencyName"  lang="en"
					class="form-control-sm" id="agencyName" aria-describedby="agencyNameHelp" required="required" />
			</div>
	<%-- 		<form:errors path="name" cssClass="error" /> --%>
	<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->
			<div class="form-group">
				<label for="agencyType">新增機構類型:</label>
				<form:input type="text" path="agencyType" 
					class="form-control-sm" id="agencyType" aria-describedby="agencyTypeHelp" required="required"/>
			</div>

			<div class="form-group">
				<label for="phone">新增機構電話號碼:</label>
				<form:input type="text" path="agencyPhone" class="form-control-sm" minlength="9" maxlength="10"
					id="phone" aria-describedby="phoneHelp" required="required"/>
			</div>
			
			<div class="form-group">
				<label for="email">新增機構地址:</label>
				<form:input type="text" path="agencyAddress" class="form-control-sm"
					id="agencyAddress" aria-describedby="agencyAddressHelp"  required="required"/>
			</div>		
	
			<div class="form-group">
				<label for="workingHours">新增機構營業時間:</label>
				<form:input type="text" path="workingHours" class="form-control-sm"
					id="workingHours" aria-describedby="workingHoursHelp" required="required"/>
			</div>
			<div class="form-group">
				<label for="birthday">新增房型:</label>
				<form:input type="text" path="roomType" class="form-control-sm"
					id="roomType" aria-describedby="roomTypeHelp"  required="required" />
			</div>		
			
			<div class="form-group">
				<label for="bedNumber">新增床數:</label>
				<form:input type="number" path="bedNumber" class="form-control-sm" 
					id="bedNumber" aria-describedby="bedNumberHelp" required="required"/>
			</div>		
			
			<div class="form-group">
				<label for="serveTarget">新增服務對象:</label>
				<form:input type="textarea" path="serveTarget" class="form-control-sm" 
					id="serveTarget" aria-describedby="serveTargetHelp" required="required"/>
			</div>		
			
			<div class="form-group">
				<label for="governmentSubsidy">新增政府補助:</label>
				<form:input type="text" path="governmentSubsidy"  class="form-control-sm" 
					id="governmentSubsidy" aria-describedby="governmentSubsidyHelp"  required="required"/>
			</div>		
			<div class="form-group">
				<label for="medicalService">新增醫療服務:</label>
				<form:input type="text" path="medicalService"  class="form-control-sm" 
					id="medicalService" aria-describedby="medicalServiceHelp"  required="required"/>
			</div>	
			<div class="form-group">
				<label for="professionalCare">新增專業照護:</label>
				<form:input type="text" path="professionalCare"  class="form-control-sm" 
					id="professionalCare" aria-describedby="professionalCareHelp" required="required"/>
			</div>
			<div class="form-group">
				<label for="featureService">新增特色服務:</label>
				<form:input type="text" path="featureService"  class="form-control-sm" 
					id="featureService" aria-describedby="featureServiceHelp"  required="required"/>
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