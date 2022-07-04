<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>機構介紹</title>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
<!-- my javascript -->
<link rel="stylesheet" href="${contextRoot}/css/my.index.css" />
<!-- my javascript -->
<link rel="stylesheet" href="${contextRoot}/css/myAgency.css" />

</head>

<body>





	<!-- 左側選單-------------------------------------------------------------------------------- -->
	<br>
	<div class="cotainer">
		<div class="row position-absolute top-100% start-100%  bottom-50% ">
			<div class="list-group">
				<a href="${contextRoot}/Agency/viewAgency"><button type="button"
						class="list-group-item list-group-item-action active"
						aria-current="true">機構介紹</button></a> <a
					href="${contextRoot }/Agency/selectAgencyData"><button
						type="button" class="list-group-item list-group-item-action">搜尋機構</button></a>
				<%-- 			    <a href="${contextRoot }/Agency/allAgencyData"><button type="button" class="list-group-item list-group-item-action">機構列表</button></a> --%>
			</div>
		</div>
	</div>

	<c:forEach var="list" items="${agencyDatas.content}">

		<!-- 右側內容 ---------------------------------------------------------------------->
		<br>
		<div class="cotainer">
			<div class="row justify-content-center ">
				<h1>機構介紹</h1>
			</div>
		</div>

		<!-- BootStap 方法1 圖左文右 -->
		<div class="cotainer">
			<div class="container  translate-middle">
				<div class="card border-dark mb-3" style="max-width: 1500px;">
					<div class="row g-0">

						<div class="col-md-6">
							<div class="card-body" style="">
								<h4 class="agencyImgWord">機構圖片</h4>
								<br> <br> <br> <br> <br>
								
								<div class="agencyImg col-md-8">
									<img class="agencyImg" style="max-width: 100%; margin: 0px 0px 0px 0px; " alt="尚未上傳圖片"
										src="${contextRoot}/Backstage/downloadImageAgency/${list.id}">
									<!--       		     <img class="agencyImg" alt="" src="../img/AgencyImg/聖和老人長期照顧中心/01.jpg" > -->
									<!-- 靜態圖片 -->
								</div>
							</div>
						</div>

						<div class="col-md-6">
							<div class="card-body" style="">
								<h3 class="card-Vatitle">機構資料</h3>

								<div class="table-bordered  border-dark">

									<table>
										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">機構名稱 :</p>
											</td>

											<td class="card-text">
												<p style="font-size: 25px; ">
													${list.agencyName}</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">機構類型 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.agencyType}</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">機構電話 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.agencyPhone }</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">機構地址 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.agencyAddress }</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">服務時間 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.workingHours }</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">房型 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.roomType}</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">床數 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.bedNumber}</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">服務對象 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.serveTarget }</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">政府補助項目 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.governmentSubsidy}</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">醫療服務 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.medicalService }</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">專業照護 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.professionalCare}</p>
											</td>
										</tr>

										<tr>
											<td class="card-text">
												<p style="font-size: 25px;">特色服務 :</p>
											</td>
											<td class="card-text">
												<p style="font-size: 25px;">${list.featureService}</p>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>



		</div>

	</c:forEach>

	<!-- BootStap 方法2 圖上文下 -->
	<!-- 		<div class="card mb-3 translate-middle"> -->
	<!-- 		<br> -->
	<!--       		<h4 class="agencyImgWord">機構圖片</h4> -->
	<!--   			<img src="../img/AgencyImg/聖和老人長期照顧中心/01.jpg" class="card-img-top" alt="..." style="width: 50%; height: 100%; margin:auto"> -->
	<!--   		</div> -->

	<!--   		<div class="card-body"> -->
	<!--     		<h5 class="card-title">機構資料</h5> -->
	<!--     	<div class="card-footer bg-transparent border-success">  -->
	<!--         	<p class="card-text">機構名稱 :</p> -->
	<!--         	<p class="card-text">機構類型 :</p> -->
	<!--         	<p class="card-text">機構電話 :</p> -->
	<!--         	<p class="card-text">機構地址 :</p> -->
	<!--         	<p class="card-text">服務時間 :</p> -->
	<!--         	<p class="card-text">房型 :</p> -->
	<!--         	<p class="card-text">床數 :</p> -->
	<!--         	<p class="card-text">服務對象 :</p> -->
	<!--         	<p class="card-text">政府補助項目 :</p> -->
	<!--         	<p class="card-text">醫療服務 :</p> -->
	<!--         	<p class="card-text">專業照顧 :</p> -->
	<!--         	<p class="card-text">特色服務 :</p> -->

	<!--       	</div> -->
	<!--   		</div> -->

	<!-- Css 原版  -->
	<!-- 	<div class="container"> -->
	<!-- 	<table class="table width-100px" > -->
	<!-- 		<tr> -->
	<!-- 			<th>id</th> -->
	<!-- 			<th>機構環境圖片</th> -->
	<!-- 			<th>機構名稱</th> -->
	<!-- 			<th>機構類型</th> -->
	<!-- 			<th>機構電話</th> -->
	<!-- 			<th>機構地址</th> -->
	<!-- 			<th>服務時間</th> -->
	<!-- 			<th>房型</th> -->
	<!-- 			<th>床數</th> -->
	<!-- 			<th>服務對象</th> -->
	<!-- 			<th>政府輔助項目</th> -->
	<!-- 			<th>醫療服務</th> -->
	<!-- 			<th>專業照顧</th> -->
	<!-- 			<th>特色服務</th> -->
	<!-- 		</tr> -->
	<!-- 	</table> -->
	<!-- 	</div> -->

	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

</body>
</html>