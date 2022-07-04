<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>後台輔具頁面</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
</head>

	<h1>後台全部輔具頁面</h1>

	<!-- item=Control的GetMapping的put().content  -->
	<ul class="list-group list-group-horizontal">
		<c:forEach var="oneOfListAuxiliary" begin="0" end="3"
			items="${listAuxiliary}">
			<li class="list-group-item">
				<a class="Auxiliar-list" href="點擊">
						<figure>
							<img src="圖片位置" alt="目標輔具">
							<figcaption>
								<span> 
									<c:out value="${oneOfListAuxiliary.auxiliaryName }"></c:out>
								</span>
							</figcaption>
						</figure>
				</a> <!-- value=上方的var, Bean的值 --> 
				<c:out	value="內容${oneOfListAuxiliary.context }"></c:out>
				<div class="edit-link">
					<a href="${contextRoot }/Auxiliary/manageAuxiliary/updateAuxiliary?auxiliaryId=${oneOfListAuxiliary.auxiliaryId}">編輯</a>
				</div>
			</li>
		</c:forEach>
	</ul>

