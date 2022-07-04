<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<jsp:include page="../default/myNavbar.jsp"></jsp:include>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src=" ${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>



<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

<%-- <script src="${contextRoot}/js/ajaxAccountCheck.js"></script> --%>

<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>這裡是註冊會員Page</title>

<style type="text/css">
body {
	background-color: #FEF2AA;
	background-image: url("../img/imgText/mes2.jpg");
	background-repeat: no-repeat;
	background-position: center;
	background-size: 40%;
	
	}



</style>

</head>
<body>
<!-- 左側選單---------------------------------------------------------------------------------->
		<br>
			<div class="row position-fixed" style="top: 40%; left: 6%; z-index: 10;">	
				<div class="list-group" style="content: counter(20);">
					<a href="${contextRoot}/FrontMember/memberCentre"><button type="button" class="list-group-item list-group-item-action active" aria-current="true" style=" background-color: #ffff99; color: black;">會員中心</button></a>
		  			<a href="${contextRoot}/FrontMember/memberData"><button type="button" class="list-group-item list-group-item-action" aria-current="true">會員資料</button></a>
				    <a href="${contextRoot }/FrontMember/listassistiveDevice"><button type="button" class="list-group-item list-group-item-action">申請輔具清單</button></a>
				    <a href="${contextRoot }/FrontMember/ShoppingCartList"><button type="button" class="list-group-item list-group-item-action">商品清單</button></a>
				</div>
			</div>


<!-- 右側內容 ---------------------------------------->

	<br>
		<div  class="container">
			<div class="row justify-content-center">
				<div class="col-7 " style="text-align: center">
					<h2>這裡是註冊會員</h2>
				</div>
			</div>
		</div>

<br>
<br>

	<div class="container" style="width: 50cm; height: 100cm;">
		<div class="row justify-content-center">
			<div class="col-5 " style="text-align: center">
				<form:form action="addMember" modelAttribute="memberBean"
						method="post">
						
						<form:input type="hidden" path="id" />
						<br>
				
						<div class="form-group">
							<label for="account">新增會員帳號:</label>
							<form:input type="text" path="memberAccount"
								class="form-control-sm" id="account" aria-describedby="accountHelp"  value="aaaa"/>
						</div>
						<div id="message">
							可以判斷密碼長度或非法字元
						</div>
				<%-- 		<form:errors path="name" cssClass="error" /> --%>
				<!-- 		<span id="name.errors" class="error">此帳號已有人使用</span> -->
						<div class="form-group">
							<label for="password">新增會員密碼:</label>
							<form:input type="password" path="memberPassword"
								class="form-control-sm" id="password" aria-describedby="passwordHelp" value="bbb"/>
						</div>
						
						<!-- 		新增權限 -->
						<div>
							<form:input path="memberAuthority" type="hidden" value="normal,ROLE_menber"/>
						</div>
						
						<div class="form-group">
							<label for="name">新增會員姓名:</label>
							<form:input type="text" path="memberName" class="form-control-sm"
								id="name" aria-describedby="nameHelp" placeholder="ex: 王曉明" value="陳晴芳"/>
						</div>
						<div class="form-group">
							<label for="phone">新增會員電話號碼:</label>
							<form:input type="number" path="memberPhone" class="form-control-sm"
								id="phone" aria-describedby="phoneHelp" value="0966688599"/>
						</div>
						
						<div class="form-group">
							<label for="lineid">新增會員Line ID:</label>
							<form:input type="text" path="memberLineId" class="form-control-sm"
								id="lineid" aria-describedby="LineIdHelp" value="aa15246"/>
						</div>		
						
						
						<div class="form-group">
							<label for="address">新增會員地址:</label>
							<form:input type="text" path="memberAddress" class="form-control-sm"
								id="address" aria-describedby="addressHelp" value="701台南市東區大學路1號" />
						</div>
						<div class="form-group">
							<label for="email">新增會員電子郵件:</label>
							<form:input type="email" path="memberEmail" class="form-control-sm"
								id="email" aria-describedby="emailHelp" placeholder="xxxxx@gmail.com" value="bbb123@gmail.com"/>
						</div>		
				
						<div class="form-group">
							<label for="birthday">新增會員生日:</label>
							<form:input type="date" path="memberBirthday" class="form-control-sm"
								id="birthday" aria-describedby="birthdayHelp" placeholder="ex: 1998/08/08" value="1998/08/08" />
						</div>		
						
						<div class="form-group">
							<label for="gender">新增會員性別:</label>
							<form:input type="text" path="memberGender" class="form-control-sm"
								id="gender" aria-describedby="genderHelp" value="女"/>
						</div>		
						
						<form:button type="submit" class="btn btn-primary" href="/FrontMember/addMember">送出</form:button>
					</form:form>
					
				</div>
			</div>
		</div>
			
</body>
</html>