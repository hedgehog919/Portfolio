<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<title>註冊成功</title>

<meta http-equiv="refresh" content="2,url=frontMemberLogin">

</head>
<body>
	<h3>您好 ${addMember[0].memberName} !</h3>
	<h4>註冊成功~請您前往會員登入重新登入</h4>

<!-- 	<div> -->
<!-- 		<ul class="breadcrumb"> -->
<!-- 			<li><i class="fa fa-dashboard">點擊連結回登入頁面</i></li> -->
		
<!-- 		<li class="active"><a href="../frontMemberLogin"style="margin: 10px auto 10px 100px; font-size: 25px; background-color: #f7d565; color: white; border-radius: 25%; color: black;">會員登入</a></li> -->
<!-- 		</ul> -->
<!-- 	</div> -->

	
</body>
</html>
<%-- <jsp:include page="../index.jsp"></jsp:include> --%>