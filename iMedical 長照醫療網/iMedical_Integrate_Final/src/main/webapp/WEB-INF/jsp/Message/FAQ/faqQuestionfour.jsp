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
<title>FAQ 第四篇</title>

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
				<li class="breadcrumb-item"><a href="/myapp/faqQuestionfour">長照服務法相關規定</a></li>
			</ol>
		</nav>
		<h3 style="text-align:center">長照服務法相關規定</h3>
		<hr class="my-4">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="pills-home-tab" data-toggle="pill"
				href="#pills-home" role="tab" aria-controls="pills-home"
				aria-selected="false">整體性議題</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
				role="tab" aria-controls="pills-profile" aria-selected="false">長照服務法施行細則
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact-tab" data-toggle="pill" href="#pills-contact"
				role="tab" aria-controls="pills-contact" aria-selected="false">長照服務機構評鑑辦法
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact2-tab" data-toggle="pill" href="#pills-contact2"
				role="tab" aria-controls="pills-contact2" aria-selected="false">長照人員訓練認證繼續教育及登錄辦法
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact3-tab" data-toggle="pill" href="#pills-contact3"
				role="tab" aria-controls="pills-contact3" aria-selected="false">人力議題
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact4-tab" data-toggle="pill" href="#pills-contact4"
				role="tab" aria-controls="pills-contact4" aria-selected="false">長照機構議題
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact5-tab" data-toggle="pill" href="#pills-contact5"
				role="tab" aria-controls="pills-contact5" aria-selected="false">長期照顧服務法
			</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact6-tab" data-toggle="pill" href="#pills-contact6"
				role="tab" aria-controls="pills-contact6" aria-selected="false">其他議題
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
											長照服務法經過哪些會議、審查，由誰訂定？</button>
									</h2>
								</div>
								<div id="collapseOne" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										長照服務法草案初擬為98年委託財團法人長期照護專業協會研擬，原長期照顧服務法案7章55條，自民國99年送出行政院開始，期間整合朝野多達17個草案版本，歷經4次專案報告、4次條文討論、5場公聽會，其中包含99年召開團體溝通座談會，100年召開4場長照服務法綜合分區說明會，101年長照服務法專家諮詢會議等，並於103年1月8日由立法院社福衛環委員會完成審議，後經9次協商業於104年5月15日由立法院完成三讀，共7章66條，並已於106年6月3日施行。
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
											什麼是家庭托顧？相關設置規定為何？</button>
									</h2>
								</div>
								<div id="collapseOne2" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										(一)
										家庭托顧係一種介於居家與社區照顧間的服務模式，由托顧家庭於日間協助照顧失能老人，目前每一托顧家庭收托不得超過4人，每日收托時間以10小時為原則，不超過12小時，如同保母在自己的家裡照顧幼兒一樣，我們將家裡的老人或身心障礙者送到照顧服務員的住所（托顧家庭）接受照顧，照顧服務員在照顧自己家人同時，可以在家創業穩定經濟收入，維持其家庭功能的完整性。
										<br /> <br /> <br /> (二)
										家庭托顧乃屬長期照顧服務法所定之社區式服務，其服務內容包括身體照顧、日常生活照顧服務與安全性照顧。對於有意成立托顧家庭之照顧服務員，政府亦有提供包含衛浴設備之防滑措施及扶手等住所設施設備改善之費用，以利建置友善照顧環境，提升照顧服務員辦理家庭托顧服務之意願；另就托顧家庭之設置標準，應依「長期照顧服務機構設立標準」第11條辦理。
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
											長照服務法施行後，對身心障礙福利機構的影響？</button>
									</h2>
								</div>
								<div id="collapseOne3" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										（一）長照服務法62條明定，於106年6月3日前，已依其他法律規定，從事本法鎖定長照服務之機關(構)、法人、團體、合作社、事務所等，仍得依原適用法令繼續提供長照服務。
										<br />
										（二）另按長服法第22條第3項，於該法施行前提供機構住宿式長照服務之身心障礙福利機構，除有擴充或遷移之情事外，亦得繼續提供服務，不須設立長照服務機構法人。
										<br />
										（三）至有意願轉型為長照機構之身心障礙福利機構，則可依長期照顧服務機構設立許可及管理辦法、長期照顧服務機構設立標準等規定辦理。
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
											醫師出具之意見書，應簡化申請程序及減輕民眾經濟負擔，建議得以3個月內之就診紀錄或病歷摘要替代？</button>
									</h2>
								</div>
								<div id="collapseOne4" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										長服法第8條第3項意旨，醫師出具意見後，當事人須經照管中心或地方主管機關評估，又為能達評估參考之效，於施行細則規定除意見書外，亦彈性開放可以其他具公信力之證明文件(如3個月內之病歷摘要或診斷書)代替。
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
											第11條第3項規定爭議處理會之委員任期為1年，建議任期宜為2年及增列「長照服務機構代表」為爭議處理會之委員。</button>
									</h2>
								</div>
								<div id="collapseOne5" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.委員任期之年限訂為1年或2年各有其優缺點，爰現行規定為1年，期滿得續聘，保留彈性。 <br />
										2.長照服務機構代表列屬為「長照服務、長照管理及醫護之學者專家」範圍中，並於逐條說明之說明欄中載明。
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
											針對居家護理個案，每2個月醫師診察紀錄，係依現行書寫格式?還是需參照醫師意見書格式?</button>
									</h2>
								</div>
								<div id="collapseOne6" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										醫師意見書之目的及用途，係為使接受醫事照護之長照服務者，經提供醫師出具意見書，供長期照顧管理中心或直轄市、縣(市)主管機關評估之用，與居家護理醫師定期巡診紀錄之用途不同。
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
											data-toggle="collapse" data-target="#collapseOne7"
											aria-expanded="false" aria-controls="collapseOne7">
											長照機構評鑑結果分為合格及不合格，無法展現等第屬於特優者。</button>
									</h2>
								</div>
								<div id="collapseOne7" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.長期照顧服務機構評鑑辦法第9條第1項有關長照機構評鑑結果分為合格及不合格之規定，業於法案研擬階段歷經數次與外界團體溝通，意見分歧，最終達共識之結論，仍為區分合格及不合格兩類。
										<br />
										2.同條第2項已訂有評鑑之評等類別，主辦機關得依政策目標或機構類別、特色，於評鑑作業程序定之，故已保有彈性及空間。
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
											居家式長照機構評鑑均由地方辦理?還需辦理督考嗎?</button>
									</h2>
								</div>
								<div id="collapseOne8" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依長期照顧服務機構評鑑辦法第3條第2款規定，居家式長照機構、社區式長照機構及不含住宿式長照機構之綜合式服務類長照機構之評鑑，係由直轄市、縣(市)主管機關辦理。另按長期照顧服務法第39條第1項規定，主管機關對長照機構應予輔導、監督、考核、檢查及評鑑，爰地方主管機關基於對長照機構管理之責，應辦理前開相關事項；又為加強輔導查核效能，長期照顧服務機構設立許可及管理辦法第31條第2項明定，直轄市、縣（市）主管機關應每年至少辦理一次不預先通知檢查，並結合各目的事業主管機關辦理之。
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
											data-toggle="collapse" data-target="#collapseOne9"
											aria-expanded="false" aria-controls="collapseOne9">
											評鑑委員之聘請，建議應先徵詢各醫事專業之公學會參與，以落實評鑑上各專業醫事人員之意見。</button>
									</h2>
								</div>
								<div id="collapseOne9" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依據長期照顧服務機構評鑑辦法第6條第1項規定，所稱具長照服務實務經驗者，其包含具長照服務實務經驗之相關醫事專業人員。又主辦單位辦理評鑑實地訪查時得聘請委員，故對於徵詢相關醫事專業之公學會參與評鑑之意見納參。
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
											data-toggle="collapse" data-target="#collapseOne10"
											aria-expanded="false" aria-controls="collapseOne10">
											長照人員實務上應如何支援報備？長照人員的登錄及支援可否於事後補報？</button>
									</h2>
								</div>
								<div id="collapseOne10" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.長照人員至非登錄處所提供長照服務，應依長期照顧服務人員訓練認證繼續教育及登錄辦法第18條規定，應於事前由登錄之長照機構敘明支援之地點、期間、時段及理由，報機構所在地直轄市、縣（市）主管機關核定。
										2.依照長期照顧服務法及本辦法規定，長照人員的登錄及支援應在事前完成。</div>
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
											長期照顧服務法第18條公告之長照服務特定項目，應由長照人員為之，故該特定項目為何？</button>
									</h2>
								</div>
								<div id="collapseOne11" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依本部107年5月17日衛部顧字第1071960570號公告，長照服務特定項目如下： <br />
										一、長照機構針對長照服務需要者提供之身體照顧服務、日常生活照顧服務、家事服務、臨時住宿服務、住宿服務、醫事照護服務。 <br />
										二、家庭照顧者支持服務提供之喘息服務。 <br /> 三、長照需要之評估服務。
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
											未完成繼續教育是否有罰則？</button>
									</h2>
								</div>
								<div id="collapseOne12" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										未完成繼續教育將無法辦理認證證明文件更新，依長服法第58條規定，未依限完成認證證明文件更新處新臺幣3,000元以上1萬5,000元以下罰鍰。
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
											人民團體主管機關為內政部，登錄辦法第13條是否應修正？</button>
									</h2>
								</div>
								<div id="collapseOne13" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										長期照顧服務人員訓練認證繼續教育及登錄辦法第13條規定為以衛生福利部為目的事業主管機關之團體，故無修正之必要。</div>
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
											data-toggle="collapse" data-target="#collapseOne14"
											aria-expanded="false" aria-controls="collapseOne14">
											目前偏遠地區照服員人力缺乏，有證照的更是稀有，將來恐怕會面臨照護人力不足的窘境，建議需事先規劃</button>
									</h2>
								</div>
								<div id="collapseOne14" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										(一)
										本部之長照服務網計畫建置普及式服務網絡，充實量能發展在地資源：偏遠地區居家式服務據點：100年至104年7月底止已建置89個據點，已服務8,758人，315萬8,616人次；另，為瞭解各服務據點之實務運作，辦理每年實地輔導作業。
										<br /> (二) 充實照顧服務人力之具體策略： <br />
										(1)增加誘因：透過長照基金獎勵資源不足地區之人力、服務資源發展，透過服務能量的提升，改善薪資待遇，並增加國人投入誘因。 <br />
										(2)賦予專業定位：長照服務法已明定照顧服務員之專業定位，未來無論是在居家、社區或機構任職的照顧服務員，均需通過訓練及認證，並登錄於長照機構，後續將盡速訂定相關認證及管理的辦法。另為建立照顧服務員專業形象，本部業於103年補助失智老人基金會拍攝以照顧服務員為主題相關紀錄片「長情的告白」，業於104年6月12日上映，以宣傳其職業價值與意義，提升其尊榮感。
										<br />
										(3)強化職涯規劃：目前刻正積極鼓勵照顧服務員晉升居家服務督導員、規劃對於任職居家服務提供單位領有照顧服務員技術士證之照顧服務員給予專業加給，並針對提供失智症照顧者之照顧加給，讓從事第一線服務的照顧服務員有多元晉升管道，創造職涯發展願景。
										<br />
										(4)加強人才培育：據勞動部調查從事照顧服務工作之人口特性，主要仍為45至64歲之女性為主，可見有意願投入照顧服務工作之勞動力，仍多為中高齡或二度就業人口，基此，除持續透過勞動部職業訓練體系培訓照顧服務人力，鼓勵中高齡及二度就業人口從事照顧服務工作；並與教育部合作，促進老人照顧相關科系與長照單位實習機制及產學合作，吸引年輕世代投入。
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
											data-toggle="collapse" data-target="#collapseOne15"
											aria-expanded="false" aria-controls="collapseOne15">
											政府是否有規劃以大專院校培養長照人才？</button>
									</h2>
								</div>
								<div id="collapseOne15" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										一、依教育部統計，至104學年度，技專校院計有29校開設與長期照顧類之相關所系科，招生名額計4,448名。為加強長期照顧服務人力學校培育、職業訓練與就業媒合事宜，本部業與教育部、勞動部成立長照人才培育跨部會業務協商溝通平臺，每3個月定期召開工作會議，本部就照顧人力需求缺口與相關所系科設立之方向，持續會同與教育部進行政策協調與研議。
										<br />
										二、目前提供國內長期照顧服務主要人力，係屬任職於居家服務提供單位、日間照顧中心及老人福利機構之照顧服務員，其資格依老人福利服務專業人員資格及訓練辦法第5條規定，包含下列資格之一：（1）領有照顧服務員訓練結業證明書；（2）領有照顧服務員職類技術士證；（3）高中（職）以上學校護理、照顧相關科（組）畢業。
										<br />
										三、為鼓勵國人參加照顧服務員訓練課程，對於取得結業證書之結訓學員，如符合特殊身分者(如具就業保險被保險人之失業者、特定弱勢對象身分者、中低收入戶…等），檢具相關證明文件，全額補助訓練費用；其餘學員每人補助80%；另為擴大招募來源，照顧服務員訓練計畫已取消國小學歷限制，以加強輔導新住民參與培訓課程。
										<br />
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
											對於照顧服務人力不足，政府有何策略？</button>
									</h2>
								</div>
								<div id="collapseOne16" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.增加誘因：透過長照基金獎勵資源不足地區之人力、服務資源發展，透過服務能量的提升，改善薪資待遇，增加國人投入誘因。 <br />
										2.賦予專業定位：長照服務法已明定照顧服務員之專業定位，未來無論是在居家、社區或機構任職的照顧服務員，均需通過訓練及認證，並登錄於長照機構，後續將盡速訂定相關認證及管理的辦法。
										<br />
										3.強化職涯規劃：目前刻正積極規劃依不同對象(如失智)訂定不同補助標準、推動照顧服務指導員試辦計畫，讓從事第一線服務的照顧服務員有多元晉升管道，創造職涯發展願景。
										<br />
										4.建立培訓制度：持續透過職業訓練體系培訓照顧服務人力，鼓勵中高齡及二度就業人口從事照顧服務工作；並與教育部合作，促進老人照顧相關科系與長照單位實習機制及產學合作，吸引年輕世代投入。
										<br />
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
											data-toggle="collapse" data-target="#collapseOne17"
											aria-expanded="false" aria-controls="collapseOne17">
											為何小規模多機能是由日照中心擴充，而非由小型機構擴充？</button>
									</h2>
								</div>
								<div id="collapseOne17" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										(一)長照2.0開放個人、民間營利單位投入辦理，小型老人福利機構倘具服務量能，可依長期照顧服務機構設立標準設立小規模多機能長照機構。
										<br /> <br />
										(二)為鼓勵各界投入長照服務產業，充實服務供給量能，本部自107年1月1日起推動給付及支付新制，私立小型老人福利機構經向服務所在地主管機關完成特約程序後，提供民眾日間照顧、居家服務、交通接送、輔具服務，以及喘息服務等長照服務項目，可依實際提供服務情形申請支付費用。
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
											data-toggle="collapse" data-target="#collapseOne18"
											aria-expanded="false" aria-controls="collapseOne18">
											在長照機構碰到問題時，是否有陳情管道？</button>
									</h2>
								</div>
								<div id="collapseOne18" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										有關於民眾陳情機構處理管道如下: 1.如有發生陳情或反映事件，可先行向機構反映，於第一時間由機構作妥善處理。 <br />
										2.可向地方政府或長期照顧管理中心提出陳情，相關專業人員會進行相關瞭解及查處。 <br />
										3.向本部提出陳情，本部依「行政程序法」及「行政院暨所屬各機關處理人民陳情案件要點」辦理，轉請地方政府進行相關瞭解及查處，並回復陳情人查處情形；查處過程將對陳情人之身分資料嚴加保密。
										<br />
										4.有關合約及消費糾紛，可向直轄市、縣（市）政府消費者保護官申訴(https://goo.gl/lZ54YI)。 <br />
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
											data-toggle="collapse" data-target="#collapseOne19"
											aria-expanded="false" aria-controls="collapseOne19">
											為何要評鑑長照機構及未來方向？</button>
									</h2>
								</div>
								<div id="collapseOne19" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.為落實主管機關對長照機構之管理責任，保障接受長照服務者權益並提供優質長照服務，長服法第39條明定，主管機關對長照機構應予輔導、監督、考核、檢查及評鑑；長照機構應配合主管機關通知，提供必要協助。
										<br /> <br />
										2.依長照服務機構評鑑辦法第7條，長照機構之評鑑項目包括「經營管理效能」、「專業照護品質」、「安全環境設備」、「個案權益保障」4大面向，本部刻正規劃各類長照機構評鑑項目之評鑑基準及評鑑程序，朝向整合各類評鑑指標、基準，並簡化評鑑作業流程，減少服務單位評鑑文書作業之方向前進。
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
											請問私人獨資機構是否可提供長照服務？</button>
									</h2>
								</div>
								<div id="collapseOne20" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										(一)
										長照服務法第21條規定，長照機構依其服務內容，分為居家式服務類、社區式服務類、機構住宿式服務類、綜合式服務類及其他經中央主管機關公告之服務類。居家式及社區式長照機構，僅須符合長服法及其子法相關規定，私人獨資亦可申請設立。
										<br /> (二) 新設立之住宿式長照機構或住宿式服務之綜合式長照機構，應由長照機構法人(財團或社團法人設立)設立。
									</div>
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
											data-toggle="collapse" data-target="#collapseOne21"
											aria-expanded="false" aria-controls="collapseOne21">
											現行提供安養、養護及日間照顧服務之公立老人福利機構，其機構屬性為何?</button>
									</h2>
								</div>
								<div id="collapseOne21" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依長期照顧服務法第62條規定，該法施行前，已依其他法律規定，從事該法所定長照服務之機關（構）、法人、團體、合作社、事務所等，仍得依原適用法令繼續提供長照服務。意即現行老人福利機構仍得依老人福利法之規定賡續提供服務，維持原老人福利機構屬性。
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
											data-toggle="collapse" data-target="#collapseOne22"
											aria-expanded="false" aria-controls="collapseOne22">
											長期照顧服務法之裁罰基準，中央預定何時公告？</button>
									</h2>
								</div>
								<div id="collapseOne22" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依據長期照顧服務法第60條規定，罰則由地方主管機關處罰之，爰長期照顧服務法之裁罰基準，宜由地方主管機關本權責訂定之。</div>
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
											長照機構法人可否買經營不善的護理之家或老人福利機構？</button>
									</h2>
								</div>
								<div id="collapseOne23" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.依長期照顧服務機構法人條例之規定，該法人之設立宗旨係為以設立長期照顧服務機構，提供機構住宿式長期照顧服務；又依法人條例第6條規定，長期照顧服務機構法人經主管機關許可，除可設立長期照顧服務機構外，並得設立社會福利機構(如老人福利機構)或提供經中央主管機關公告之服務。
										<br /> <br />
										2.護理之家或老人福利機構如經營不善，應辦理歇業，至長期照顧服務機構法人如欲承接該機構之經營，應依長期照顧服務機構設立許可及管理辦法之規定，申請住宿式服務類長期照顧服務機構之籌設許可後，再申請設立許可。
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
											data-toggle="collapse" data-target="#collapseOne24"
											aria-expanded="false" aria-controls="collapseOne24">
											全國性社會福利團體(如老五老)分設於縣市之服務據點或提供單位(無立案申請)，是否需依長期照顧服務法？</button>
									</h2>
								</div>
								<div id="collapseOne24" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										個人或團體如提供長服法所定之長期照顧服務，即需依長期照顧服務機構設立標準、長期照顧服務機構設立許可及管理辦法辦理設立各類長期照顧服務機構，始得提供長照服務。
									</div>
								</div>
							</div>
						</div>
					</li>
				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact6" role="tabpanel"
				aria-labelledby="pills-contact1-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne25"
											aria-expanded="false" aria-controls="collapseOne25">
											綜合式長照機構因提供不同服務項目，其防火管理人是否由同一人負責?</button>
									</h2>
								</div>
								<div id="collapseOne25" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										有關長期照顧服務機構之防火管理人，因涉內政部消防署權管消防法相關規定，請逕向該署洽詢。</div>
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
											一般農地可否變更作為設立長期照顧服務機構使用?</button>
									</h2>
								</div>
								<div id="collapseOne26" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										考量土地可分為都市土地及非都市土地，因分涉內政部權管之都市計畫法、區域計畫法及非都市土地使用管制規則等，倘符合相關規定並向主管機關提出申請獲准，亦可變更使用作為設立長照機構之用，至相關法規之適用則請逕向該部洽詢。
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
											長期照顧服務機構是否須將收容概況月報表報主管機關?</button>
									</h2>
								</div>
								<div id="collapseOne27" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">有關辦理相關長期照顧服務機構統計作業，地方主管機關將視需求辦理。</div>
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
											長期照顧服務機構是否須申請統一編號?</button>
									</h2>
								</div>
								<div id="collapseOne28" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										本部業已通函各地方政府，有關長照機構統編稅編之辦理原則，原則上本部及財政部並無規定設立長照機構須編配單獨之統編及稅編，惟涉各地方政府與服務提供單位簽訂特約之簽約主體，須有不同之配套作法。
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
											未來老人福利法及相關子法修法方向為何?</button>
									</h2>
								</div>
								<div id="collapseOne29" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										因應106年6月3日施行之長期照顧服務法暨相關授權子法，為利各法規之銜接與適用，本部後續將修正老人福利法及相關授權子法，並以與長期照顧服務法暨相關授權子法一致為修正原則。
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