<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<jsp:include page="../default/messageNavbar.jsp" />
<head>
<meta charset="UTF-8">
<title>新增留言</title>
</head>

<div class="container">
	<div class="row justify-content-center">
		<div class="col-9">
		<br>
			<h1>新增留言</h1>
			<br>
			<div class="card mb-3">
			<div class="card-header">新增留言</div>
				<div class="card-body">
					<form:form action="${contextRoot}/message/add" method="post"
						modelAttribute="Message">

						<div class="input-group">
							<form:textarea path="message_content" class="form-control" />
						</div>
						<input type="submit" name="submit" value="新增訊息">
					</form:form>
				</div>
			</div>
			
				<div class="row justify-content-center ">
					<div class="col-9">
						<div class="card">
							<div class="card-header">新增時間:<fmt:formatDate pattern="yyyy-MM-dd 'at' HH:mm:ss EEEE  "
									value="${latestMsg.adddate}"/>
							</div>
							<div class="card-body">

								<c:out value="${latestMsg.message_content}"></c:out>

							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		</div>