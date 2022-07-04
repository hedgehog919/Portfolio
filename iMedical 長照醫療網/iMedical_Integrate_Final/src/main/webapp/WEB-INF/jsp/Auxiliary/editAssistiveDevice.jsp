<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<jsp:include page="../default/myNavbar.jsp" />
<head>
<meta charset="UTF-8">
<title>編輯頁面</title>
<script type="text/javascript">
	function chk() {
		if (document.form.name.value == '') {
			alert('姓名未填');
			document.form.name.focus();
			return false;
		}
		if (document.form.phone.value == '') {
			alert('電話未填');
			document.form.phone.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<h2>編輯頁面</h2>
	<form:form action="${contextRoot}/postEditDevice"
		modelAttribute="assistiveDevices" method="post" id="form" name="form"
		onsubmit="return chk();">
		<form:input type="hidden" path="id" />
		<br />
		聯絡人姓名 <form:input type="text" id="name" path="name" value="" />
		<br />
		<br />
		性別: <label> <input type="radio" name="gender" value="M">
			<span>先生</span>
		</label>
		<label> <input type="radio" name="gender" value="F"> <span>女士</span>
		</label>
		<br />
		聯絡人電話 <form:input type="text" id="phone" path="telephone" />
		<br />
		<br />
		地址:
		<form:input type="text" path="address" />
		<br />
		<br />
		想申請的輔具:
		<br />
		<input type="checkbox" name="assistiveDevice" value="輪椅" />
		<span>輪椅</span>
		<input type="checkbox" name="assistiveDevice" value="輪椅座墊" />
		<span>輪椅座墊</span>
		<input type="checkbox" name="assistiveDevice" value="助行輔具" />
		<span>助行輔具</span>
		<input type="checkbox" name="assistiveDevice" value="電動輪椅" />
		<span>電動輪椅</span>
		<input type="checkbox" name="assistiveDevice" value="代步車" />
		<span>代步車</span>
		<input type="checkbox" name="assistiveDevice" value="GPS定位器" />
		<span>GPS定位器</span>
		<br />
		<input type="checkbox" name="assistiveDevice" value="氣墊床" />
		<span>氣墊床</span>
		<input type="checkbox" name="assistiveDevice" value="減壓床墊" />
		<span>減壓床墊</span>
		<input type="checkbox" name="assistiveDevice" value="居家照顧床" />
		<span>居家照顧床</span>
		<input type="checkbox" name="assistiveDevice" value="洗澡椅" />
		<span>洗澡椅</span>
		<input type="checkbox" name="assistiveDevice" value="便盆椅" />
		<span>便盆椅</span>
		<input type="checkbox" name="assistiveDevice" value="移位輔具" />
		<span>移位輔具</span>
		<br />
		<input type="checkbox" name="assistiveDevice" value="醫療輔具" />
		<span>醫療輔具</span>
		<input type="checkbox" name="assistiveDevice" value="義肢矯具" />
		<span>義肢矯具</span>
		<input type="checkbox" name="assistiveDevice" value="助聽器" />
		<span>助聽器</span>
		<input type="checkbox" name="assistiveDevice" value="其他" />
		<span>其他</span>
		<br />
		<input type="submit" id="button" value="送出"
			onclick="return confirm('確定送出嗎?')" />
	</form:form>
	<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
</body>
</html>