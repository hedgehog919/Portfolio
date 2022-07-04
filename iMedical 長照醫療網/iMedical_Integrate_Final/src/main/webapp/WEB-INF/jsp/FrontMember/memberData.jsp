<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../default/myNavbar.jsp"></jsp:include>


<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="${contextRoot }/css/membersStyle.css">
<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>會員資料</title>

<style type="text/css">
body {
	background-color: #FEF2AA;
	background-image: url("../img/imgText/mes2.jpg");
	background-repeat: no-repeat;
	background-size: 60%;
	background-position: center;
}




</style>



</head>
<body>

	<br>
	<br>
	
	<div  class="container">
		<div class="row justify-content-center">
				<div class="col-4 " style="text-align: center">
				<h2>會員資料</h2>
				</div>
		</div>
	</div>

<!-- 左側選單---------------------------------------------------------------------------------->
		<br>
			<div class="row position-fixed" style="top: 25%; left: 6%; z-index: 10;">	
				<div class="list-group" style="content: counter(20);">
					<a href="${contextRoot}/FrontMember/memberCentre"><button type="button" class="list-group-item list-group-item-action active" aria-current="true" style=" background-color: #00416A; color: white ;">會員中心</button></a>
		  			<a href="${contextRoot}/FrontMember/memberData"><button type="button" class="list-group-item list-group-item-action" aria-current="true">會員資料</button></a>
				    <a href="${contextRoot }/FrontMember/listassistiveDevice"><button type="button" class="list-group-item list-group-item-action">申請輔具清單</button></a>
				    <a href="${contextRoot }/FrontMember/ShoppingCartList"><button type="button" class="list-group-item list-group-item-action">商品清單</button></a>
				</div>
			</div>


<!-- 右側內容 ---------------------------------------->

<div class="container">
	<div class="row justify-content-center">
	
	<br>
	    <div class="col-4">
	
	    	<div class="row">
	    		<div class="col-10 container">
		<form:form  modelAttribute="memberNewData"
				method="post" class="data">
				
				<form:input type="hidden" path="id" />
				<br>
		
				<div class="form-group">
					<label for="account">會員帳號:</label>
					<form:input type="text" path="memberAccount"
						class="form-control-sm" id="account" aria-describedby="accountHelp"  value="${data.getMemberAccount }"/>
				</div>
		<!-- 		<div id="message"> -->
		<!-- 			可以判斷密碼長度或非法字元 -->
		<!-- 		</div> -->
		<%-- 		<form:errors path="name" cssClass="error" /> --%>
		<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->
				<div class="form-group">
					<label for="password">會員密碼:</label>
					<form:input type="hidden" path="memberPassword"
		 				class="form-control-sm" id="password" aria-describedby="passwordHelp" value="${data.getMemberPasswordt }"/>
				</div>
				
				<!-- 		新增權限 -->
				<div>
					<form:input path="memberAuthority" type="hidden" value="normal,ROLE_menber"/>
				</div>
				
				<div class="form-group">
					<label for="name">會員姓名:</label>
					<form:input type="text" path="memberName" class="form-control-sm"
						id="name" aria-describedby="nameHelp" placeholder="ex: 王曉明" value="${data.getMemberName }"/>
				</div>
				<div class="form-group">
					<label for="phone">會員電話號碼:</label>
					<form:input type="number" path="memberPhone" class="form-control-sm"
						id="phone" aria-describedby="phoneHelp" value="${data.getMemberPhone }"/>
				</div>
				
				<div class="form-group">
					<label for="lineid">會員Line ID:</label>
					<form:input type="text" path="memberLineId" class="form-control-sm"
						id="lineid" aria-describedby="LineIdHelp" value="${data.getMemberLineId }"/>
				</div>		
				
				
				<div class="form-group">
					<label for="address">會員地址:</label>
					<form:input type="text" path="memberAddress" class="form-control-sm"
						id="address" aria-describedby="addressHelp" value="${data.getMemberAddress }" />
				</div>
				<div class="form-group">
					<label for="email">會員電子郵件:</label>
					<form:input type="email" path="memberEmail" class="form-control-sm"
						id="email" aria-describedby="emailHelp" placeholder="xxxxx@gmail.com" value="${data.getMemberEmail }"/>
				</div>		
		
				<div class="form-group">
					<label for="birthday">會員生日:</label>
					<form:input type="date" path="memberBirthday" class="form-control-sm"
						id="birthday" aria-describedby="birthdayHelp" placeholder="ex: 1998/08/08" value="${data.getMemberBirthday }" />
				</div>		
				
				<div class="form-group">
					<label for="gender">會員性別:</label>
					<form:input type="text" path="memberGender" class="form-control-sm"
						id="gender" aria-describedby="genderHelp" value="${data.getMemberGender }"/>
				</div>		
				
				<div style="text-align:center">	
				<form:button type="submit" class="btn btn-primary" >送出</form:button>
				</div>
			</form:form>
					</div>
		    	</div>
	
	
	        
	    </div>
	
	</div>
</div>
<!-- ----------------------------------------------------------------------------------------------------------------------------- -->

<script>

	$(function(){

		$(".membersNameBtn").click(function(){
			updataName();
		})
		
		function updataName(){
			$(".membersName").hide();
			$(".updataMembersName").show();
		}

		$(".membersGenderBtn").click(function(){
			updateGender();
		})

		function updateGender(){
			$(".membersGender").hide();
		}

		$(".membersBirthdayBtn").click(function(){
			updateBirthday();
		})

		function updateBirthday(){
			$(".membersBirthday").hide();
		}

		$(".membersPhoneBtn").click(function(){
			updatePhone();
		});

		function updatePhone(){
			$(".membersPhone").hide();
		}

		$(".membersEmailBtn").click(function(){
			updateEmail();
		})

		function updateEmail(){
			$(".membersEmail").hide();
		}

		$(".membersAddressBtn").click(function(){
			updateAddress();
		})

		function updateAddress(){
			$(".membersAddress").hide();
		}






	})

</script>



</body>
</html>