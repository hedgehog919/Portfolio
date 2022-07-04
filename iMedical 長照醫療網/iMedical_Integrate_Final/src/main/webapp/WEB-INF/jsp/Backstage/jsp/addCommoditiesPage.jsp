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


<title>iMedical長照醫療網新增商品頁面</title>
</head>
<body>

<div style="width:100%; text-align: center; padding-top: 20px; padding-bottom: 30px;">
<img alt="圖片" src="${contextRoot}/img/header3.png" style="width: 30%;">

</div>


	<div style="border: 5px solid; margin:10px 200px 100px 200px;  border-radius: 2em; background-color: white; text-align: center">
	<h1 style=" margin-top: 20px; margin-bottom: 30px; font: 50px bold; text-align: center;">新增商品資料</h1>
	<div style="border: 4px solid; padding-bottom: 50px; margin: 10px 350px 100px 350px; border-style: groove; border-radius: 2em;  ">
			<div style="max-width: 300px;">
					<img style="width: 300px;"  id="thumbnail" alt="尚未上傳圖片" src=""/>
			</div> 
		<form:form action="addCommodities" modelAttribute="commoditiesBean"  enctype="multipart/form-data"
			method="post">
			
			<form:input type="hidden" path="commodityId" />
			<br>
			<div class="form-group" >
				<span>新增商品照片: </span>
				<input type="file" name="commoditiesPic" id="fileImage" required="required"/>
<!-- 				<input type="file" name="employeePhoto"   accept=".jpg, .png" -->
<!-- 					class="form-control-sm" id="fileImage" aria-describedby="fileImageHelp" required="required" /> -->
					
			</div>
	
			<div class="form-group" >
				<label for="commodityName">新增商品名稱:</label>
				<form:input type="text" path="commodityName"  lang="en"
					class="form-control-sm" id="commodityName" aria-describedby="accountHelp" required="required" />
			</div>
	<%-- 		<form:errors path="name" cssClass="error" /> --%>
	<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->
			<div class="form-group">
				<label for="amount">新增商品金額:</label>
				<form:input type="number" path="amount" 
					class="form-control-sm" id="amount" aria-describedby="passwordHelp" required="required"/>
			</div>

			<div class="form-group">
				<label for="totalQuantity">新增商品總數量:</label>
				<form:input type="number" path="totalQuantity" class="form-control-sm" 
					id="totalQuantity" aria-describedby="phoneHelp" required="required"/>
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