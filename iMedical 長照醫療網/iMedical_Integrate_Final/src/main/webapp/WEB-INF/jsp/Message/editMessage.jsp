<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="../default/messageNavbar.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改訊息頁面</title>
</head>
<body>

<div class="container">
	<div class="row justify-content-center">
		<div class="col-9">
			<div class="card">
				<div class="card-header">修改訊息</div>
				<div class="card-body">

					<form:form action="${contextRoot}/postEditMessage" method="post"
						modelAttribute="workMessage">
						<form:input type="hidden" path="id"/>
						<form:input type="hidden" path="added"/>

						<div class="input-group">
							<form:textarea path="text" class="form-control" />
						</div>

						<input type="submit" name="submit" value="修改訊息">


					</form:form>

				</div>
			</div>
		</div>
	</div>

 </div>
</body>
</html>