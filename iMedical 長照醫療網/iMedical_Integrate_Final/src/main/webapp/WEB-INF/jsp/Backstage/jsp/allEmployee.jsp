<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="default/myNavbar.jsp"></jsp:include>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iMedical長照醫療網管理員工頁面</title>
<link href="${contextRoot}/css/backStage.css" rel="stylesheet"
	type="text/css" />


</head>
<body>

	<div
		style="width: 100%; text-align: center; padding-top: 0px; background-color: rgba(255, 255, 255, 0.69);">
		<img alt="圖片" src="${contextRoot}/img/header4.png" style="width: 40%; ">
	</div>











	<div
		style="width: 100%; text-align: center; margin-top: 20px; margin-bottom: 30px;">
		<form action="../Backstage/searchEmployee">
			<input name="id" type="search" required="required"
				style="border-radius: 10px; width: 50%;" placeholder="">
			<input type="submit" value="查詢" 
				style="border-style: groove; border-radius: 5px;">

		</form>
	</div>




	<div
		style="border: 2px groove; width:100%; background-color:highlighttext; border-radius: 2em; padding: 30px 30px 30px 30px; text-align: center;">

		<h1>管理全部員工</h1>




		<table class="table table-hover table-bordered" style="background-color: white;">
			<tr
				style="margin: 30px 30px 30px 30px; background-color: silver;">
				<th>員工編號</th>
				<th>員工照片</th>
				<th>員工帳號</th>
				<th>員工姓名</th>
				<th>員工電話</th>
				<th>員工信箱</th>
				<th>員工地址</th>
				<th>員工生日</th>
				<th>員工職等</th>
				<th>員工薪資</th>
				<th>員工到職日</th>
				<th></th>
				<th></th>
			</tr>



			<c:forEach var="list" items="${page.content}">
				<tr>
					<td>${list.id}</td>
					<td> <img style="width: 50%; max-width: 50%;" alt="尚未上傳照片" src="${contextRoot}/Backstage/downloadImage/${list.id}"> </td>
					<td>${list.employeeAccount}</td>
					<td>${list.employeeName}</td>
					<td>${list.employeePhone}</td>
					<td>${list.employeeEmail}</td>
					<td>${list.employeeAddress}</td>
					<td>${list.employeeBirthday}</td>
					<td>${list.employeeLevel}</td>
					<td>${list.employeeSalary}</td>
					<td>${list.employeeOnboard}</td>
					<td><a
						href="${contextRoot}/Backstage/editemployee?id=${list.id}"
						
						>編輯</a>
					</td>
					<td><a
						href="${contextRoot}/Backstage/deleteEmployee?id=${list.id}"
						onclick="return confirm('確認刪除嗎?')">刪除</a></td>
				</tr>

			</c:forEach>






		</table>

		<div class="row justify-content-center" style="text-align: center;">
			<div class="col-9">
				<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
					<c:choose>
						<c:when test="${page.number!=pageNumber-1 }">
							<a href="${contextRoot}/Backstage/getallEmployee?p=${pageNumber}">
								<c:out value="${pageNumber}"></c:out>
							</a>
						</c:when>
						<c:otherwise>
							<c:out value="${pageNumber}"></c:out>
						</c:otherwise>


					</c:choose>
					<c:if test="${pageNumber != page.totalPages}"></c:if>

				</c:forEach>
			</div>
		</div>
	</div>





	<footer class="main-footer" style="margin-top: 100px;">
		<div class="container" style="width: 100%; text-align: center;">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.0.01
			</div>
			<strong>Copyright © 2022-2025 <a href="">iMedical</a>.
			</strong> All rights reserved.
		</div>

	</footer>


</body>
</html>