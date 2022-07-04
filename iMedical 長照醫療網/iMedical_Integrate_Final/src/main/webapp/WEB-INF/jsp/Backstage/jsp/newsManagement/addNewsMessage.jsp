<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" 	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
<link rel="stylesheet" 	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.css">
<meta charset="UTF-8">
<title>新增公告</title>

<style>
	body{
		font-size: 18px;
		color: #212529;
		background-color: rgba(0, 0, 0, 0.25);
	}
	
	
	#formCol{
		box-shadow: 0px 0px 12px rgb(0 ,0 ,0 , 0.2); 
		border: 2px solid #ddd;
		padding: 30px 60px;
		background-color: white;
		
	}
	
	div>label,#updateTimeDiv>span, #ViewsDiv>span,#statusRadioBtn {
		font-weight: bolder;
		font-size:20px;
	}
	
	
	#inputTitleText{
		width: 500px;
		border: 1px solid #ced4da;
		border-radius: 0.25rem;
	}
	
	#inputTitleText:focus,#category:focus{
		background-color: #fff;
	    border-color: #80bdff;
	    outline: 0;
	    box-shadow: 0 0 0 0.2rem rgb(0 123 255 / 25%);
	}
	
	#category{
		width: 200px;
		border: 1px solid #ced4da;
		border-radius: 0.25rem;
	}
	
	legend{
		color: #bd3359;
		font-size: 28px;
		font-weight: bolder;
		margin-bottom: 20px;
/* 		border-bottom: 2px solid #bd3359; */
	}
	textarea{
		font-size: 18px !important;
		color: #212529 !important;
		height: 400px !important;
	}
	
	.fa, .fa-pencil{
		font-size: 24px;
		padding-right: 5px;
	}
	
</style>

</head>
<body>
	
	<div class="container mt-5 mb-5" id="formContainer">
		<div class="row justify-content-center" id="formRow">
			<div class="col-8 " id="formCol">
				<form:form action="addNewsMessage" method="post" modelAttribute="newsMsg">
	    				<legend><i class="fa fa-pencil" aria-hidden="true"></i>公告新增</legend>
						<div class="form-inline mb-3">
						    <label class="pr-3" for="inputTitleText" id="inputLabel">公告標題:</label>
						    <form:input type="text" id="inputTitleText" value="${newsMsg.title}" path="title"/>
						</div>
						<div class="form-inline mb-3">
							<label class="pr-3" for="category">公告類型:</label> 
							<form:select type="text" path="category" id="category">
								<form:option value="最新公告" >最新公告</form:option>
								<form:option value="活動快報" >活動快報</form:option>	
							</form:select>
						</div>
						<div class="form-inline mb-3" id="statusRadioBtn"><span class="pr-3">是否發佈: </span>
							<form:radiobutton path="status" id="true" value="true"/>
							<label class="pr-3" for="true">是</label>
							<form:radiobutton path="status" id="false" value="false"/>
							<label class="pr-3" for="false">否</label>
						</div>
						<div class="form-group mb-5">
							<label for="exampleFormControlTextarea1">內文:</label>
							<form:textarea class="form-control" id="exampleFormControlTextarea1" rows="3" value="${newsMsg.text}" path="text"/>
						</div>
						<div class="d-flex justify-content-end mb-3">
							<form:button type="submit" class="btn btn-secondary mr-3">新增</form:button><button type="button" class="btn btn-secondary" id="cancelBtn">取消</button>
						</div>
				</form:form>
			</div>
		</div>
	</div>		

	<script>
 		$(document).ready(function(){
 			$('#cancelBtn').click(function(){
 				var ans = confirm('確定離開!');
 				if (ans != false) {
 					window.location.href = '/iMedical/Backstage/';
 				}
 				return false;
 	 		})
 	 		
 	 		
 		})
 		
	
	
	
	</script>
	
</body>
</html>