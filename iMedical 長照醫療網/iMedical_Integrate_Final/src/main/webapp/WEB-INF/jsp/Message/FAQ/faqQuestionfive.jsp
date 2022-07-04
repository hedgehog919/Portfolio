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
<title>FAQ 第五篇</title>

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
				<li class="breadcrumb-item"><a href="/myapp/faqQuestionfive">預防延緩失能與照護計畫</a></li>
			</ol>
		</nav>
		<h3 style="text-align:center">預防延緩失能與照護計畫</h3>
		<hr class="my-4">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="pills-home-tab" data-toggle="pill"
				href="#pills-home" role="tab" aria-controls="pills-home"
				aria-selected="false">服務個案</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
				role="tab" aria-controls="pills-profile" aria-selected="false">篩檢及評估
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact-tab" data-toggle="pill" href="#pills-contact"
				role="tab" aria-controls="pills-contact" aria-selected="false">特約單位申請資格
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact2-tab" data-toggle="pill" href="#pills-contact2"
				role="tab" aria-controls="pills-contact2" aria-selected="false">特約單位場地規範
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact3-tab" data-toggle="pill" href="#pills-contact3"
				role="tab" aria-controls="pills-contact3" aria-selected="false">特約單位服務給付
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact4-tab" data-toggle="pill" href="#pills-contact4"
				role="tab" aria-controls="pills-contact4" aria-selected="false">方案及師資
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact5-tab" data-toggle="pill" href="#pills-contact5"
				role="tab" aria-controls="pills-contact5" aria-selected="false">資源管理平台操作
			</a></li>
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
											新住民或華僑是否可使用本服務？</button>
									</h2>
								</div>
								<div id="collapseOne" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										因目前長照服務只針對臺灣國民提供相關補助，故仍以具臺灣國民身分證者得接受本項服務補助。</div>
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
											如在開班課程進行中參加個案有異動，請問須於何時登錄完畢？</button>
									</h2>
								</div>
								<div id="collapseOne2" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.考量實際執行彈性，開班前二週可容許個案異動，於課程進行中，如有個案確定退出，新個案最晚應於第二週課程結束前加入，並於第三週開始確認開班服務個案名單。
										<br /> 2.於第三週加入之新個案，其前二週出席紀錄須列為缺席，並請完整紀錄個案前後測評估結果。
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
											data-toggle="collapse" data-target="#collapseOne3"
											aria-expanded="false" aria-controls="collapseOne3">
											住在機構的老人是否也可以至社區參加預防照護介入服務？</button>
									</h2>
								</div>
								<div id="collapseOne3" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.本計畫主要服務對象為社區之衰弱老人及輕、中度失能（智）長者，雖機構之老人非本計畫對象，惟服務對象已彈性調整擴至社區亞健康及健康長者也可混班參加，故機構內之長者也可至社區參加預防照護服務。
										<br />2.為轉介接受合適之介入方案班(衰弱或失能或失智)，有關機構老人之評估工作，本計畫服務對象並無強制規範須由照專進行評估，且已彈性開放特約單位亦可進行SOF及IADL篩檢，或可由已受訓人員經簡易評估量表(出院準備版)評估個案之失能程度。
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
											data-toggle="collapse" data-target="#collapseOne4"
											aria-expanded="false" aria-controls="collapseOne4">
											有請外勞看護之長者可否使用本服務？</button>
									</h2>
								</div>
								<div id="collapseOne4" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">長者經評估符合本計畫服務對象者，即可至社區特約單位接受服務。</div>
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
											特約單位是否可以進行SOF+IADL篩檢?衰弱老人及健康/亞健康長者的定義為何?</button>
									</h2>
								</div>
								<div id="collapseOne5" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.特約單位可主動開班：特約單位可進行篩檢評估，主動發現符合本計畫服務對象開班，並將開班名冊送長照管理中心備查。(*原規定需先送照專複核→現修改為備查即可)
										<br /> 2.衰弱老人定義：SOF≧2項+IADL≧1項之失能長者；健康/亞健康長者即尚未達前述衰弱之狀況。
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
											data-toggle="collapse" data-target="#collapseOne6"
											aria-expanded="false" aria-controls="collapseOne6">
											如個案於接受服務期間發生意外，是否有責任歸屬之虞？</button>
									</h2>
								</div>
								<div id="collapseOne6" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										建議於介入前進行專業評估(如參考個案前測結果安排合適的方案)，告知可能的風險，如請個案簽署活動參與同意書，並留下緊急聯絡人聯絡方式，以應意外事件之需，本部提供同意書範本供參(如附件1)，可依各特約單位特性及需求逕行增刪。
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
											data-toggle="collapse" data-target="#collapseOne7"
											aria-expanded="false" aria-controls="collapseOne7">
											同一個案是否可連續參與多期服務？</button>
									</h2>
								</div>
								<div id="collapseOne7" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										第一年試辦，無強制限制個案僅能接受一期服務，惟考量資源普及性，應以未接受過服務之個案為優先，並經評估後，依個案失能程度及情況安排合適之預防介入方案。
										<br /> <br /> 107年依作業須知規定每人以3期/年為限。
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
											data-toggle="collapse" data-target="#collapseOne8"
											aria-expanded="false" aria-controls="collapseOne8">
											身心障礙者可否使用本服務？</button>
									</h2>
								</div>
								<div id="collapseOne8" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										本計畫服務對象應以衰弱老人及輕、中度失能（智）長者為主。另，如符合長照2.0之服務對象亦可接受本項服務。</div>
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
											data-toggle="collapse" data-target="#collapseOne9"
											aria-expanded="false" aria-controls="collapseOne9">
											前、後測是於何時進行測驗？如何於平台新增？</button>
									</h2>
								</div>
								<div id="collapseOne9" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.前測需要在開班前1週內施測有效，開班後2週內需輸入系統，後測為課程結束1週內施測。 <br />
										2.於功能選單中->開班管理->開班資料（點選操作編輯開班班級）->進入開班資料後點選學員資料->點選學員操作即可新增前後測資料。
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
											data-toggle="collapse" data-target="#collapseOne10"
											aria-expanded="false" aria-controls="collapseOne10">
											去年已參加的個案，還需再次填寫前後測資料嗎？</button>
									</h2>
								</div>
								<div id="collapseOne10" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										前後測主要為評估個案參加服務後是否有變化，凡參加新1期服務皆要填寫前後測。</div>
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
											data-toggle="collapse" data-target="#collapseOne11"
											aria-expanded="false" aria-controls="collapseOne11">
											前後測部分，若長輩第一期已實行過前後測，第二期是否需要再做一次？</button>
									</h2>
								</div>
								<div id="collapseOne11" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										原則上每一期服務均須進行前測及後測，若長輩的狀況並無顯著變化，在前後測時間間隔短的情況下，可將第一期後測做為第二期的前測；若長輩已有明顯改變或間隔時間過長，則必須重新執行第二期前測。
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
											data-toggle="collapse" data-target="#collapseOne12"
											aria-expanded="false" aria-controls="collapseOne12">
											地方政府執行服務滿意度調查是否需參照本部公告之公版調查表？</button>
									</h2>
								</div>
								<div id="collapseOne12" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										為利本部進行全國服務滿意度之統計與分析，請各地方政府以本部公告之滿意度調查表(如附件4)為主，另各地方政府可依在地所需，增列項目。
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
											data-toggle="collapse" data-target="#collapseOne13"
											aria-expanded="false" aria-controls="collapseOne13">
											失智症個案之評估方式？</button>
									</h2>
								</div>
								<div id="collapseOne13" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										已領有醫師開立的CDR診斷或身心障礙證明之失智症者，不需再經由照專評估。</div>
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
											data-toggle="collapse" data-target="#collapseOne14"
											aria-expanded="false" aria-controls="collapseOne14">
											個案介入前後測評估(Kihon Checklist)之個案回答，如非為能力問題，而是意願問題，應如何評分？</button>
									</h2>
								</div>
								<div id="collapseOne14" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										本量表所評的是表現，不涉個人需不需要做、想不想要做，只看表現。所謂的表現，不管他要不要、想不想或是有沒有辦法，我們看到的是有還是沒有。
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
											data-toggle="collapse" data-target="#collapseOne15"
											aria-expanded="false" aria-controls="collapseOne15">
											衛生所、診所、里長辦公室可以申請為特約單位嗎？服務提供場地可否設在以上地點？新增型及延續型的據點該如何分別？</button>
									</h2>
								</div>
								<div id="collapseOne15" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										<ol>
											<li>107年新增特約服務點，需為社區整體照顧服務體系之C級單位或失智照護服務計畫之失智社區服務據點。106年已核定之特約服務點若符合前述兩項申請資格，亦為「新增型」服務單位。</li>
											<li>非C級單位、亦非失智社區服務據點之106年受核定單位，於107年得以「延續型」服務單位續辦。</li>
											<li>特約單位提供服務地點須以社區為主，得在衛生所、診所或社區式機構內，但不得在住宿式機構及醫院內，惟如機構或醫院提供方案之服務地點於其機構或醫院場域以外之社區(須有相關文件佐證)，經地方政府審核同意，則不限制；另山地離島及偏遠地區，考量其資源與地理環境等限制及社區範圍小，則另以個案處理。</li>
											<li>
												診所屬醫事機構，若符合本部公告之特約單位申請資格，惟若在診所內執行方案，需評估場地是否合適，應考量空間足夠性、門診業務與團體開班是否會有排擠效應等，建議可至社區找其他服務場地。</li>
											<li>
												申請單位可結合里長辦公室作為服務提供場地，並請地方政府依在地需求分配資源，如實有需求者，里長辦公室可申請為特約單位。</li>
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
											data-toggle="collapse" data-target="#collapseOne16"
											aria-expanded="false" aria-controls="collapseOne16">
											如同一單位同時申請兩項服務計畫，是否有資源重疊之疑慮？</button>
									</h2>
								</div>
								<div id="collapseOne16" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.每一特約單位可申請之特約服務據點數量及期數，請地方政府依在地資源、分配之公平性及佈點均衡性進行評量，如特約資源足夠者，特約單位應避免集中於少數幾家，以避免引發爭議。
										<br /> 2.如同時申請失智照護計畫、ABC加值服務等，服務提供時間應獨立分開，並避免資源重複補助及職業老人等情形。
									</div>
								</div>
							</div>
						</div>
					</li>
				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact2" role="tabpanel"
				aria-labelledby="pills-contact1-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne17"
											aria-expanded="false" aria-controls="collapseOne17">
											特約單位場地如何認定？合法立案之定義為何？</button>
									</h2>
								</div>
								<div id="collapseOne17" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										係以符合最基本安全考量為原則，且為登記有案之場地。「107年度預防及延緩失能照護計畫申請作業須知」中特約單位審查表
										(地方政府使用) 所載之「2.
										場地設置基本規範-(1)合法立案」，申請單位如以C級單位核定文件佐證者，得免付合法立案證明文件。</div>
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
											data-toggle="collapse" data-target="#collapseOne18"
											aria-expanded="false" aria-controls="collapseOne18">
											沒有無障礙空間是否就不能作為據點？</button>
									</h2>
								</div>
								<div id="collapseOne18" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										本計畫有關特約(據點)單位場地設置基本規範為以符合最基本安全考量為原則，以具無障礙空間為佳，且若服務場地位於地下樓層或2樓以上者需備有電梯。
									</div>
								</div>
							</div>
						</div>
					</li>

				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact3" role="tabpanel"
				aria-labelledby="pills-contact1-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne19"
											aria-expanded="false" aria-controls="collapseOne19">
											如個案因住院、死亡、傳染病隔離等原因於開班期間內退出課程，應如何核銷？</button>
									</h2>
								</div>
								<div id="collapseOne19" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										如個案因不可抗力因素(例如:生病、搬遷至外縣市…等，得由各地方政府依個案事實認定)無法繼續參加課程，經向地方政府報備同意後，則後續平均出席率可不計入該個案出席情形。
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
											data-toggle="collapse" data-target="#collapseOne20"
											aria-expanded="false" aria-controls="collapseOne20">
											方案介入之相關材料應由特約單位或方案帶領師資準備?</button>
									</h2>
								</div>
								<div id="collapseOne20" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										有關方案介入所需相關材料，請特約單位及方案帶領師資雙方於開班前即先進行溝通及協調，經協調結果如由特約單位準備，相關經費可由開班補助之經費支應。
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
											data-toggle="collapse" data-target="#collapseOne21"
											aria-expanded="false" aria-controls="collapseOne21">
											師資鐘點費須由特約單位提供扣繳憑單及領據嗎？</button>
									</h2>
								</div>
								<div id="collapseOne21" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										因師資鐘點費係由特約單位支付，原則上應由特約單位核發。有關扣繳憑單申報及相關規定等可洽詢各縣市國稅局。</div>
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
											data-toggle="collapse" data-target="#collapseOne22"
											aria-expanded="false" aria-controls="collapseOne22">
											同一特約(據點)單位如針對同一班個案，結合2個不同方案介入，應如何紀錄前後測、出席率及辦理核銷作業?</button>
									</h2>
								</div>
								<div id="collapseOne22" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.依方案分班紀錄，請特約(據點)單位確實於資訊平台分別建置開班資料，並分別依該班個案出席率辦理經費核銷。 <br />
										2.請特約單位依限於該期方案介入前後各評估一次，並分別於2項方案之開班資料同步登打紀錄。
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
											data-toggle="collapse" data-target="#collapseOne23"
											aria-expanded="false" aria-controls="collapseOne23">
											如C級單位僅服務8位個案是否可開班?服務費用應如何給付?</button>
									</h2>
								</div>
								<div id="collapseOne23" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										C級單位如亦為提供預防照護方案之特約服務據點，屬新增型服務單位，8人可開班，惟須確保平均出席皆有5人以上方得給付相關費用，核銷給付規定依新增型。
									</div>
								</div>
							</div>
						</div>
					</li>

				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact4" role="tabpanel"
				aria-labelledby="pills-contact1-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne24"
											aria-expanded="false" aria-controls="collapseOne24">
											若是自提課程送審單位，關於方案模組，地方審查專家學者意見是課程師資須經過方案模組訓練完成，但由於方案模組仍在送審中，關於這部分如何開班？</button>
									</h2>
								</div>
								<div id="collapseOne24" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										本計畫方案分為三階段建置，第一階段與第二階段方案模組皆須由本部審查通過公告後方為可使用之方案暨師資人才，第三階段為地方政府自徵自審方案，須依地方政府相關作業規定，也同樣需要核定通過公告後方可使用，故送審中之方案及其師資人才尚無法供各特約服務點選用。
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
											data-toggle="collapse" data-target="#collapseOne25"
											aria-expanded="false" aria-controls="collapseOne25">
											地方政府詢問地方自徵自審已通過之方案模組，需要先函文檢送人才給衛福部後，才能通知特約單位開班嗎？</button>
									</h2>
								</div>
								<div id="collapseOne25" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">

										依本部訂定相關原則自徵自審之第三階段方案模組，自106年9月18日起請依本部訂定之審核原則審查並公告，毋須另函報核備。</div>
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
											data-toggle="collapse" data-target="#collapseOne26"
											aria-expanded="false" aria-controls="collapseOne26">
											特約單位是否可自行選擇每週開課為1次或2次？</button>
									</h2>
								</div>
								<div id="collapseOne26" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										研發單位申請方案須寫明方案每週進行1次或2次，特約單位選用方案開班時則可與研發單位聯繫，依開班服務對象之需要選擇該方案每週進行1次或2次，並與方案帶領師資配合。若選擇24次方案模組，可拆成2期辦理(1期12週，每週1次，2期共24次)，或每週辦理2次(惟補助最高1期12次，另外12次相關費用須自籌)。
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
											data-toggle="collapse" data-target="#collapseOne27"
											aria-expanded="false" aria-controls="collapseOne27">
											專業師資可否至社區帶領照護方案？師資鐘點費應如何支付？</button>
									</h2>
								</div>
								<div id="collapseOne27" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										本計畫師資人才分為專業師資、指導員及協助員，資格越高可擔任較低資格之角色(如專業師資可作為指導員或協助員)，並依實際擔任角色給付費用，指導員及協助員支付標準如下：
										<br />
										1.作為指導員角色(主要帶領者)：具有師級證照之專業醫事人員，支付1,200元/小時；非醫事專業人員，支付1,000元/小時。
										<br /> 2.作為協助員 (協同帶領者)：不限為專業人員為原則，支付500元/小時。
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
											data-toggle="collapse" data-target="#collapseOne28"
											aria-expanded="false" aria-controls="collapseOne28">
											方案模組的專業師資可培訓指導員及協助員，專業師資如何認證？</button>
									</h2>
								</div>
								<div id="collapseOne28" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										專業師資應為已完成相關專業教育訓練且實際有培訓社區方案帶領人之經驗者，各研發單位於方案模組中亦應訂定其須具備資格及培訓機制。
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
											data-toggle="collapse" data-target="#collapseOne29"
											aria-expanded="false" aria-controls="collapseOne29">
											如因颱風等天候因素，課程是否可延期？</button>
									</h2>
								</div>
								<div id="collapseOne29" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">如為人事行政局發布之公告訊息，可暫停當次課程，惟應建立補課機制。</div>
								</div>
							</div>
						</div>
					</li>

				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact5" role="tabpanel"
				aria-labelledby="pills-contact1-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne30"
											aria-expanded="false" aria-controls="collapseOne30">
											如何匯出核銷清單？</button>
									</h2>
								</div>
								<div id="collapseOne30" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										於功能選單中->核銷作業>特約(據點)單位核銷 <br />
										請先確認所查詢開班日期區間之「開班資料」中「開班型態」欄位是否有填寫，否則無法列印報表！
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
											data-toggle="collapse" data-target="#collapseOne31"
											aria-expanded="false" aria-controls="collapseOne31">
											如何登打出席率？如何匯出開班資料學員之出席率？</button>
									</h2>
								</div>
								<div id="collapseOne31" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										登打出席率： <br /> 於功能選單中->開班管理->每周課程紀錄->編輯->登打完確認送出 <br />
										匯出出席率： <br />
										於功能選單中->開班管理->開班審查->點選要匯出之班級最右邊選項操作底下的列印->即可匯出Excel表單 <br />
										開啟Excel表單點選啟用編輯可看到Sheet1有師資名冊，點選Sheet2則有個案出席紀錄表，即可看到出席率及前後測分數資料。
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
											data-toggle="collapse" data-target="#collapseOne32"
											aria-expanded="false" aria-controls="collapseOne32">
											前、後測是於何時進行測驗？如何於平台新增？</button>
									</h2>
								</div>
								<div id="collapseOne32" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.前測需要在開班前1週內施測有效，開班後2週內需輸入系統，後測為課程結束1週內施測。 <br />
										2.於功能選單中->開班管理->開班資料（點選操作編輯開班班級）->進入開班資料後點選學員資料->點選學員操作即可新增前後測資料。
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
											data-toggle="collapse" data-target="#collapseOne33"
											aria-expanded="false" aria-controls="collapseOne33">
											若辦了兩期課程，於平台上是否必須新增？</button>
									</h2>
								</div>
								<div id="collapseOne33" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">是，若辦理兩期課程則需要有兩期開班資料。</div>
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
											data-toggle="collapse" data-target="#collapseOne34"
											aria-expanded="false" aria-controls="collapseOne34">
											登打個案資料時，誤上傳了評估單，造成有多筆評估單，是否可刪除？是否影響平台使用操作？</button>
									</h2>
								</div>
								<div id="collapseOne34" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										無法刪除多餘的評估單，評估單為累加儲存，會為個案當時狀態做紀錄。多餘的評估單不會影響操作平台或後續作業流程。</div>
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