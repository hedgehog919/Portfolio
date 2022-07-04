<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<jsp:include page="../default/myNavbar.jsp" />

<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>申請免費輔具</title>

<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
<!-- my javascript -->
<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />


<script type="text/javascript" src="${contextRoot}/js/jquery-3.6.0.min.js">

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
	key=new Array(3);
	key[0]=new Array(3);
	key[1]=new Array(3);
	key[2]=new Array(3);
	key[3]=new Array(3);
	key[4]=new Array(3);
	key[5]=new Array(3);
	
	
	key[1][0]="區域";
	key[1][1]="中正區";
	key[1][2]="大同區";
	key[1][3]="中山區";
	key[1][4]="松山區";
	key[1][5]="大安區";

	key[2][0]="區域";
	key[2][1]="平鎮區";
	key[2][2]="龍潭區";
	key[2][3]="楊梅區";
	key[2][4]="新屋區";
	key[2][5]="觀音區";
	
	key[3][0]="區域";
	key[3][1]="中區";
	key[3][2]="東區";
	key[3][3]="南區";
	key[3][4]="西區";
	key[3][5]="北區";
	
	key[4][0]="區域";
	key[4][1]="中西區";
	key[4][2]="中區";
	key[4][3]="南區";
	key[4][4]="北區";
	key[4][5]="安平區";
	
	key[5][0]="區域";
	key[5][1]="屏東市";
	key[5][2]="三地門鄉";
	key[5][3]="霧臺鄉";
	key[5][4]="瑪家鄉";
	key[5][4]="九如鄉";
	function Buildkey(num)
	{
	  document.form.addresss.selectedIndex=0;
	  for(ctr=0;ctr<key[num].length;ctr++){
	    document.form.addresss.options[ctr]=new Option(key[num][ctr],key[num][ctr]);
	  }
	 document.form.addresss.length=key[num].length;
	}
</script>

<style>
body{
	background-color:#C1DDDF;
	background-image: url(../img/申請單.jpg);
	background-position: center;
	background-repeat: no-repeat;
	background-size: contain;



}


.text-center{
	width: 800px;
	margin: 50px auto;
}

</style>

</head>
<body>

<!-- 左側選單-------------------------------------------------------------------------------- -->
		<br>
	<div class="cotainer">
		<div class="row position-absolute top-100% start-100%  bottom-50% ">	
			<div class="list-group">
	  			<a href="${contextRoot }/Auxiliary/assistiveDeviceIntroduce"><button type="button" class="list-group-item list-group-item-action active" aria-current="true">輔具介紹</button></a>
			    <a href="${contextRoot }/Auxiliary/buyAssistiveDevice"><button type="button" class="list-group-item list-group-item-action">申請輔具</button></a>
			</div>
		</div>
	</div>

<!-- 右側內容 -------------------------------------------------------------------------------- -->
	<div class="text-center" >
		<div class="row justify-content-center">
			<h1>我想申請免費輔具</h1>
		</div>
	</div>
	
	<div class="cotainer">
		<div class="row justify-content-center">
			<form:form action="${contextRoot}/addDevices"
				modelAttribute="assistiveDevices" method="post" id="form" name="form"
				onsubmit="return chk();">
				<form:input type="hidden" path="id" />
				<br />
				聯絡人姓名 <input type="text" id="name" name="name" value="" />
				<br />
				<br />
				性別: <label> <input type="radio" name="gender" value="M" checked="checked"/> <span>先生</span>
				</label>
				<label> <input type="radio" name="gender" value="F" /> <span>女士</span>
				</label>
				<br />
				聯絡人電話 <form:input type="text" id="phone" path="telephone" />
				<br />
				<br />
				地址
				<br />
				<select name="address" onchange="Buildkey(this.selectedIndex);">
				    <option>縣市</option>
					<option value="台北市">台北市
					<option value="桃園市">桃園市
					<option value="台中市">台中市
					<option value="台南市">台南市
					<option value="屏東縣">屏東縣
				</select> 
				<select name="address" id="addresss">
				</select>
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
		</div>
	</div>
	
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
</body>
</html>