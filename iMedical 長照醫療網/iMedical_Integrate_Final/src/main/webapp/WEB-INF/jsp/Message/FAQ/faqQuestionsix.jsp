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
<title>FAQ 第六篇</title>

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
<!-- 路徑待重新確認 -->

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
				<li class="breadcrumb-item"><a href="/myapp/faqQuestion">其他</a></li>
			</ol>
		</nav>
		<h3 style="text-align:center">其他</h3>
		<hr class="my-4">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="pills-home-tab" data-toggle="pill"
				href="#pills-home" role="tab" aria-controls="pills-home"
				aria-selected="false">整體性議題</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
				role="tab" aria-controls="pills-profile" aria-selected="false">其他議題</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact-tab" data-toggle="pill" href="#pills-contact"
				role="tab" aria-controls="pills-contact" aria-selected="false">長照基金獎助申請</a>
			</li>
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
											「高齡政策白皮書」與「人口白皮書」，這兩者的關係為何？何者應優先適用？</button>
									</h2>
								</div>
								<div id="collapseOne" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										(一)
										人口政策白皮書所關注的人口議題包含了少子女化、高齡化、移民，高齡社會白皮書主要針對高齡者及未來高齡社會提出四大願景與相關具體行動措施。雖兩者皆有針對高齡化提出相關對策，但為因應人口老化迅速、家庭與生活型態改變與社會價值變遷的挑戰，我國必須針對當今社會之高齡多元需求，同時參考國際經驗與趨勢，必須即早提出更前瞻且整體性的政策規劃，以滿足我國高齡者能夠享有健康生活、幸福家庭、活力社會與友善環境，達到延長國人健康年數、減少失能老年人口的目標，並且整體提升高齡者生活幸福感。
										<br /> (二)
										人口政策白皮書與高齡社會白皮書兩者並無衝突與適用之優先順序，高齡社會白皮書亦有融合人口政策白皮書之理念，並特別針對未來高齡人口需求延伸提出高齡政策之前瞻性架構與規劃，以共同實踐政府政策之願景。
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
											data-toggle="collapse" data-target="#collapseOne2"
											aria-expanded="false" aria-controls="collapseOne2">
											台灣的失智症長照服務資源量能？</button>
									</h2>
								</div>
								<div id="collapseOne2" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										一、為因應我國快速增加的老年及失智人口，延緩及減輕失智症對社會及家庭的衝擊，並提供失智症及其家庭所需的醫療及照護需求，本部於102年8月公布「失智症防治照護政策網領」，訂定兩大目標及七大面向，以作為我國失智症照護發展方向。並結合跨部會機關依據政策綱領七大面向提出行動方案32項，並依各工作項目之效益指標達成目標，以完善失智症照護防治體系。
										<br /> <br /> 二、為提升失智症社區服務普及性，擴增失智症長照服務量能，已推動措施如下： <br /> <br />
										(一)97年起失智者已納入長照十年計畫，失智症長者可經一般失能之基本日常生活活動能力(ADL)或臨床失智評估量表（CDR）評估，判定失能或失智程度，核定補助時數，按老人之需求，提供失智老人適切長照服務。長照服務個案中失智症患者約占9.7%，截至104年5月底，提供失智症長照服務個案約1萬5千多人。
										<br /> <br /> (二)完善社區照護網絡-多元、在地服務及家庭照顧者： <br /> <br />
										<ol>
											<li>已完成185個多元日照服務單位(日照中心159個、日托據點26個)，預計105年完成「一鄉鎮一日照」。</li>
											<li>失智專責服務：已設置日間照顧服務(17縣市共25處)、老人團體家屋(10個單位/83床)
												、瑞智學堂(19縣市/60處)、失智症社區服務據點（28據點）、有失智症專區之機構
												(41家，計1,317床；另規劃中7家239床)。</li>
											<li>建構家庭照顧者服務支持網絡：已設置失智症諮詢關懷專線，針對長照十年個案高風險家庭提供諮詢服務（1,141人/年)；提供家庭照顧者照顧訓練（908/場；17,137人次/年），及建立失智症互助家庭（2,451人次)。</li>
										</ol>
										<br /> <br />
										(三)充足長照服務人力：已完成醫事長照專業三個階段培訓課程並展開訓練，至104年8月已訓練約30,000人次；又為讓在地人照顧在地人，擴大培養在地長照人力，100-104年8月止約訓練3200人次。
										<br /> <br /> (四) 提升民眾對失智症防治及照護的認知： <br /> <br />
										<ol>
											<li>全民教育：拍攝紀錄片如「被遺忘的時光」、「昨日的記憶」、憶起愛相隨」、「照顧者心情故事-居家服務」、製作失智症衛教手冊、認識失智症單張；辦理學校、職場宣導講座等進行教育宣導。</li>
											<li>社區健康促進網絡如結合社區關懷據點（1,978個) 辦理老人健康促進活動（6,359場；超過10萬人)。</li>
											<li>.建構高齡友善機構及城市方面：通過認證機構，醫院有105家、長照機構有3家及1家衛生所；並於22縣市全面推動高齡友善城市，讓
												280萬之長者受惠。</li>
										</ol>
										三、未來規劃： <br /> <br /> (一)
										104年5月已完成長期照顧服務法立法，可依法設置長照基金，發展服務及人力資源。 <br /> (二)
										整合原有之長照十年計畫與長照服務網基礎，推動長期照顧服務量能提升計畫。
									</div>
								</div>
							</div>
						</div>
					</li>
				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact" role="tabpanel"
				aria-labelledby="pills-contact-tab">
				<ol>
				   <li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne4"
											aria-expanded="false" aria-controls="collapseOne4">
											長照基金獎助之申請程序？</button>
									</h2>
								</div>
								<div id="collapseOne4" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										<ol>
										<li>本部長照十年計畫2.0-106年度補助計畫，106年部分，本部社家署已於106年1月12日以衛授家字第1060800004號函送本部「106年度運用社會福利基金辦理長照十年計畫2.0補助項目及基準」，將補助案件分為主軸計畫、整合型計畫及專案計畫等三類，可依該三類之補助項目、基準、作業程序辦理。</li>
										<li>107年（含）以後及非屬上開長照十年計畫2.0-106年度補助計畫經費之申請程序與相關作業規範，本部將另訂長照基金獎助作業要點。</li>
										</ol>
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
											data-toggle="collapse" data-target="#collapseOne5"
											aria-expanded="false" aria-controls="collapseOne5">
											有關長照服務資源不足地區的定義，建議重新檢討及訂定檢討年限？</button>
									</h2>
								</div>
								<div id="collapseOne5" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
									<ol>
									<li>現行長照服務資源不足地區，係依本部99年及103年辦理長照服務資源盤點所規劃之長照服務網區域劃分。</li>
									<li>本辦法第三條已明定「至少每五年辦理長照服務資源供需之調查」。</li>
									<li>將依前項辦理之調查結果，定期檢討長照服務資源不足地區之定義。</li>
									</ol>
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
</body>
</html>