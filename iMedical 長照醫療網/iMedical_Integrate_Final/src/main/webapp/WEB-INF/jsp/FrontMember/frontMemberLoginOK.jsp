<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <jsp:include page="../index.jsp"></jsp:include> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<title>登入成功</title>

<meta http-equiv="refresh" content="2,url=FrontMember/memberCentre">

</head>
<body>
<h2>您好 ${loginMember[0].memberName} !</h2>
<h1>登入成功</h1>
	<a href="${contextRoot}/FrontMember/login"><button>返回首頁</button></a>


</body>
</html>