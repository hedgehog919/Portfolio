<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
	
<!DOCTYPE html>
<html>
<jsp:include page="../default/myNavbar.jsp" />
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<meta charset="UTF-8">
<title>輔具介紹</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<!-- my javascript -->
	<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />
	
<style type="text/css">
body{
	background-color: #F5DEB3;
	
	



}

.text-center{
	width: 800px;
	margin: 50px auto;
}

.happy {
	width: 800px;
	margin: 50px auto;
	border: solid 1px gray;
	overflow: hidden;
}

.bdcard {
	width: 300px;
	float: left;
	padding: 20px;
}

.bdcard img {
	display: block;
	width: 100%;
}

.bdtext {
	float: right;
	width: 430px;
	padding: 20px 20px 0px 0px;
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



	<c:forEach var="list" items="${page.content}">

	<div class="text-center">
		<h2>輔具介紹</h2>
		<div class="happy">
		
			<div class="bdcard">
				<img id="DIV1" alt="" src="${contextRoot}/Backstage/downloadImageRealAssistiveDevice/${list.id}">
			</div>
			
			<div class="bdtext">
<!-- 				<h4>輕量型輪椅(輪椅B款)</h4> -->
				<h4>${list.assistiveDeviceName}</h4>
				<div>
					<ul style="text-align: left;">
<!-- 						<li>輕量化設計，外出攜帶方便。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用輔助。</li> -->
							<li>${list.assistiveDeviceDescription}</li>
					</ul>
				</div>
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">長照2.0補助</th>
							<th scope="col">身心障礙補助</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">一般戶：2800元</th>
							<td>一般戶：2000元</td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<td>中低收入戶：3600元</td>
							<td>中低收入戶：3000元</td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<td>低收入戶：4000元</td>
							<td>低收入戶：4000元</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>	
	
	</c:forEach>		
<!-- 		<div class="happy"> -->
<!-- 			<div class="bdcard"> -->
<!-- 				<img id="DIV1" alt="" src="../img/02.jpg"> -->
<!-- 			</div> -->
<!-- 			<div class="bdtext"> -->
<!-- 				<h4>移位型輪椅(輪椅B款+A)</h4> -->
<!-- 				<div> -->
<!-- 					<ul style="text-align: left;"> -->
<!-- 						<li>具可拆掀式扶手、腳靠，方便乘坐者從輪椅移動到他處。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用補助。</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				<table class="table table-striped"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th scope="col">長照2.0補助</th> -->
<!-- 							<th scope="col">身心障礙補助</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<th scope="row">一般戶：7800元</th> -->
<!-- 							<td>一般戶：7000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>中低收入戶：8600元</td> -->
<!-- 							<td>中低收入戶：3000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>低收入戶：9000元</td> -->
<!-- 							<td>低收入戶：9000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="happy"> -->
<!-- 			<div class="bdcard"> -->
<!-- 				<img id="DIV1" alt="" src="../img/03.jpg"> -->
<!-- 			</div> -->
<!-- 			<div class="bdtext"> -->
<!-- 				<h4>躺式輪椅(輪椅B款+A+B)</h4> -->
<!-- 				<div> -->
<!-- 					<ul style="text-align: left;"> -->
<!-- 						<li>乘坐者可由坐姿變換至近仰躺的姿勢，肢體癱瘓者可使用此種輪椅，可使皮膚受壓面積分散，避免壓瘡發生。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用補助。</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				<table class="table table-striped"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th scope="col">長照2.0補助</th> -->
<!-- 							<th scope="col">身心障礙補助</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<th scope="row">一般戶：9800元</th> -->
<!-- 							<td>一般戶：9000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>中低收入戶：10600元</td> -->
<!-- 							<td>中低收入戶：10000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>低收入戶：11000元</td> -->
<!-- 							<td>低收入戶：11000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="happy"> -->
<!-- 			<div class="bdcard"> -->
<!-- 				<img id="DIV1" alt="" src="../img/04.jpg"> -->
<!-- 			</div> -->
<!-- 			<div class="bdtext"> -->
<!-- 				<h4>傾斜式輪椅(輪椅B款+A+C)</h4> -->
<!-- 				<div> -->
<!-- 					<ul style="text-align: left;"> -->
<!-- 						<li>乘坐者可維持坐姿不變，輪椅向後傾斜翹起(類似搖椅般傾斜方式)，肢體癱瘓者可使用此種輪椅，可使皮膚受壓面積分散，避免壓瘡發生。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用補助。</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				<table class="table table-striped"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th scope="col">長照2.0補助</th> -->
<!-- 							<th scope="col">身心障礙補助</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<th scope="row">一般戶：11800元</th> -->
<!-- 							<td>一般戶：11000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>中低收入戶：12600元</td> -->
<!-- 							<td>中低收入戶：12000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>低收入戶：13000元</td> -->
<!-- 							<td>低收入戶：13000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="happy"> -->
<!-- 			<div class="bdcard"> -->
<!-- 				<img id="DIV1" alt="" src="../img/05.jpg"> -->
<!-- 			</div> -->
<!-- 			<div class="bdtext"> -->
<!-- 				<h4>特製輪椅(輪椅C款+A)</h4> -->
<!-- 				<div> -->
<!-- 					<ul style="text-align: left;"> -->
<!-- 						<li>依乘坐者特殊需求訂製。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用補助。</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				<table class="table table-striped"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th scope="col">長照2.0補助</th> -->
<!-- 							<th scope="col">身心障礙補助</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<th scope="row">一般戶：14000元</th> -->
<!-- 							<td>一般戶：14000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>中低收入戶：14000元</td> -->
<!-- 							<td>中低收入戶：14000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>低收入戶：14000元</td> -->
<!-- 							<td>低收入戶：14000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="happy"> -->
<!-- 			<div class="bdcard"> -->
<!-- 				<img id="DIV1" alt="" src="../img/06.jpg"> -->
<!-- 			</div> -->
<!-- 			<div class="bdtext"> -->
<!-- 				<h4>輪椅坐墊B款(連通管氣囊)</h4> -->
<!-- 				<h4>輪椅坐墊C款(液態凝膠)</h4> -->
<!-- 				<div> -->
<!-- 					<ul style="text-align: left;"> -->
<!-- 						<li>減壓坐墊，預防褥瘡。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用補助。</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				<table class="table table-striped"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th scope="col">長照2.0補助</th> -->
<!-- 							<th scope="col">身心障礙補助</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<th scope="row">一般戶：10000元</th> -->
<!-- 							<td>一般戶：10000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>中低收入戶：10000元</td> -->
<!-- 							<td>中低收入戶：10000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>低收入戶：10000元</td> -->
<!-- 							<td>低收入戶：10000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="happy"> -->
<!-- 			<div class="bdcard"> -->
<!-- 				<img id="DIV1" alt="" src="../img/07.jpg"> -->
<!-- 			</div> -->
<!-- 			<div class="bdtext"> -->
<!-- 				<h4>輪椅坐墊D款(固態凝膠)</h4> -->
<!-- 				<h4>輪椅坐墊E款(填充式氣囊)</h4> -->
<!-- 				<div> -->
<!-- 					<ul style="text-align: left;"> -->
<!-- 						<li>減壓坐墊，預防褥瘡。</li> -->
<!-- 						<li>需經輔具中心專業人員評估認定後，才可使用補助。</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				<table class="table table-striped"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th scope="col">長照2.0補助</th> -->
<!-- 							<th scope="col">身心障礙補助</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<th scope="row">一般戶：8000元</th> -->
<!-- 							<td>一般戶：8000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>中低收入戶：8000元</td> -->
<!-- 							<td>中低收入戶：8000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td>低收入戶：8000元</td> -->
<!-- 							<td>低收入戶：8000元</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

</body>
</html>