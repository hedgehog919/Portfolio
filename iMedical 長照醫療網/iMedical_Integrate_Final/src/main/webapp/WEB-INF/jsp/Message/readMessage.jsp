<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="../default/messageNavbar.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看訊息頁面</title>
</head>
<body>
<div class="container">
   <h1>查看訊息頁面</h1>
   
   <c:forEach var="Message" items="${page.content}">
      <div class="row justify-content-center">
		<div class="col-9">
			<div class="card">
				<div class="card-header">新增時間: <fmt:formatDate pattern="yyyy-MM-dd 'at' HH:mm:ss EEEE  " value="${workMessages.added}" /> </div>
				<div class="card-body">
				   <div>
				    <c:out value="${workMessages.text}"></c:out>
				    <div class="edit-link">
				       <a href="${contextRoot}/Messsage/editMessage/${Message.id}">編輯</a> |
				       <a href="${contextRoot}/Message/deleteMessage/${Message.id}"  onclick="return confirm('確認刪除嗎?')">刪除</a>
				    </div>
                  </div>
				</div>
			</div>
		</div>
	</div>
   </c:forEach>
   
   
   <div class="row justify-content-center">
		<div class="col-9">
       <c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
          <c:choose>
          
          <c:when  test="${page.number != pageNumber-1 }">
              <a href="${contextRoot}/Message/readMessage?p=${pageNumber}"><c:out value="${pageNumber}"></c:out></a>
          </c:when>
          
          
          <c:otherwise>
             <c:out value="${pageNumber}"></c:out>
          </c:otherwise>
          
          </c:choose>
   
          <c:if test="${pageNumber != page.totalPages}">
          |
          </c:if>
   
       </c:forEach>
   </div>
   </div>
   
   

</div>
</body>
</html>