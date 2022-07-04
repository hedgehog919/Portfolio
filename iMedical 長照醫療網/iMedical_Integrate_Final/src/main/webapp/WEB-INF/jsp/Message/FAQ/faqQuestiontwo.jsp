<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" /> 

<!DOCTYPE html>
<html>
<jsp:include page="../../default/messageNavbar.jsp" />
<head>
<%-- 	<c:set var="contextRoot" value="${pageContext.request.contextPath }" />  --%>
<%-- 	<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">  --%>
	<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
	<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<%-- 	<link href="${contextRoot}/css/myMessage.css" rel="stylesheet"> --%>

<meta charset="UTF-8">
<title>FAQ 第二篇 </title>

<style>
		ol{
			padding: 0px;
		}
		
		.container>.row{
/* 			border-top: 1px solid #aaa; */
/* 			border-bottom: 1px solid #aaa; */
/* 			padding: 5px; */
		}
		
	</style>

</head>
<body style="position: relative">

<!-- 左側選單---------------------------------------------------------------------------------->

		<br>
			<div class="row position-fixed" style="top: 20%; left: 4%; z-index: 10;">	
			<div class="list-group">
	  			<a href="${contextRoot}/message/FAQ/faqQuestion"><button type="button" class="list-group-item list-group-item-action active" aria-current="true">長期照顧特別扣除額</button></a>
			    <a href="${contextRoot}/message/FAQ/faqQuestiontwo"><button type="button" class="list-group-item list-group-item-action">長照服務申請及評估</button></a>
			    <a href="${contextRoot}/message/FAQ/faqQuestionthree"><button type="button" class="list-group-item list-group-item-action">長照機構法人</button></a>
			    <a href="${contextRoot}/message/FAQ/faqQuestionfour"><button type="button" class="list-group-item list-group-item-action">長照服務法相關規定</button></a>
			    <a href="${contextRoot}/message/FAQ/faqQuestionfive"><button type="button" class="list-group-item list-group-item-action">預防延緩失能與照護計畫</button></a>
			    <a href="${contextRoot}/message/FAQ/faqQuestionsix"><button type="button" class="list-group-item list-group-item-action">其他</button></a>
			</div>
		</div>

<!-- 右側內容 --------------------------------------------------------------------------------->
	<div class="container">
		<div class="row justify-content-center ">
		<div class="col-12 p-0">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="/myapp">首頁</a></li>
					<li class="breadcrumb-item"><a href="/myapp/faq">常見問題</a></li>
					<li class="breadcrumb-item"><a href="/myapp/faqQuestiontwo">長照服務申請及評估</a></li>
				</ol>
			</nav>
		<h3 style="text-align:center">長照服務申請及評估</h3>
		<hr class="my-4">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="pills-home-tab" data-toggle="pill"
				href="#pills-home" role="tab" aria-controls="pills-home"
				aria-selected="false">照顧管理-照管中心議題</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
				role="tab" aria-controls="pills-profile" aria-selected="false">
					失智議題</a></li>
		</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-home"
				role="tabpanel" aria-labelledby="pills-home-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne"
											aria-expanded="false" aria-controls="collapseOne">
											如何確保照管中心的服務品質？</button>
									</h2>
								</div>
								<div id="collapseOne" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										一、為提供長照單一窗口服務，本部已協同22縣市建置長期照顧管理中心，並配置人力，可評估申請民眾之失能程度給予補助，並連結民眾所需服務及轉介。
										<br />
										二、另為維持照管中心服務品質，從接案到轉介皆訂有基本且一致的流程，各縣市照管中心再依在地化特色擬定服務作業流程，另本部定期辦理業務實地考評，將照管中心人力資源管理、服務輸送時效及服務品質納入考評指標，由專家學者進行實地輔導考評，了解各縣市服務執行情形。
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne2"
											aria-expanded="false" aria-controls="collapseOne2">
											民眾何時可以申請十年長照的補助？該向什麼單位申請？</button>
									</h2>
								</div>
								<div id="collapseOne2" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										為提供失能、失智長者便利之長照整合性服務，目前已推動之長期照顧十年計畫，當民眾家中有人需要長期照顧服務時，可以直接撥打長照服務專線，不分縣市直撥1966；本專線提供長照資源的專業諮詢，將有專人協助您了解您的所在地有哪些長照資源及長照服務。
									</div>
								</div>
							</div>
						</div>
					</li>
				</ol>
			</div>
			<div class="tab-pane fade" id="pills-profile" role="tabpanel"
				aria-labelledby="pills-profile-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne4"
											aria-expanded="false" aria-controls="collapseOne4">
											失智者如何得到照護服務？</button>
									</h2>
								</div>
								<div id="collapseOne4" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
									一、民眾可經由利用「1966長照服務專線」、醫院出院準備服務，以及親自洽詢當地照管中心等方式申請長照服務，長期照顧管理中心將派專員到家中進行評估，共同擬定個別化的長照服務計畫，並依需求提供量身訂做的長照服務。
										<br />
										(一)失智未失能者，協助轉介至失智共同照護中心或失智社區服務據點接受服務：
										<br /> 
										1.失智共同照護中心：將協助疑似失智個案之就醫確診、醫療照護及個案管理；協調個案及照顧者需要之照顧服務使用、轉介及追蹤服務情形；陪伴照顧者於失智不同階段獲得其所需要之生活照顧與醫療照護之諮詢、服務、協調、轉介與追蹤；協助照顧者於失智個案急性症狀之諮詢與安排轉介、照顧服務。
										<br />
										<br /> 
										2.失智社區服務據點：提供失智症個案照護及家庭照顧者支持之需求服務項目為主，包含認知促進、緩和失智；安全看視；家屬支持團體(輔導諮商)；家屬照顧課程及其他創新服務等。
										<br /> 
										<br /> 
										(二)失智且失能者，依失能等級不同提供日間照顧、家庭托顧、喘息服務、居家復能照護、小規模多機能、居家無障礙環境改善等服務。
										<br /> 
										二、設置失智症諮詢關懷專線(0800-474-580失智時，我幫您)，提供失智者及家庭照顧者諮詢服務。
									</div>
								</div>
							</div>
						</div>
					</li>
				</ol>
			</div>
		</div>
		</div>
		</div>
		</div>
		<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
		<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
</body>
</html>