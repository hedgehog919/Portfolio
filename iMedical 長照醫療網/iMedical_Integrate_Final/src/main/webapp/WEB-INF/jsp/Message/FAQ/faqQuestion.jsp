<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<jsp:include page="../../default/messageNavbar.jsp" />
<head>
<%-- <%-- <c:set var="contextRoot" value="${pageContext.request.contextPath }" /> --%>
<%-- <link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet"> --%>
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<%-- <link href="${contextRoot}/css/myMessage.css" rel="stylesheet"> --%>
<meta charset="UTF-8">
<title>FAQ 第一篇</title>

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
				<li class="breadcrumb-item"><a href="/myapp/faqQuestion">長期照顧特別扣除額</a></li>
			</ol>
		</nav>
		<h3 style="text-align:center">長期照顧特別扣除額</h3>
		<hr class="my-4">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="pills-home-tab" data-toggle="pill"
				href="#pills-home" role="tab" aria-controls="pills-home"
				aria-selected="false">資格條件</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
				role="tab" aria-controls="pills-profile" aria-selected="false">證明文件</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact-tab" data-toggle="pill" href="#pills-contact"
				role="tab" aria-controls="pills-contact" aria-selected="false">稅務問題</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="pills-contact1-tab" data-toggle="pill" href="#pills-contact1"
				role="tab" aria-controls="pills-contact1" aria-selected="false">聘雇外籍家庭護工</a>
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
											請問在家自己照顧家人要如何適用長期照顧特別扣除額?</button>
									</h2>
								</div>
								<div id="collapseOne" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										如係由家人自行在家照顧，且無使用政府補助之長期照顧給付及支付基準服務者，則可洽指定醫療機構進行專業評估，如符合聘僱外籍家庭看護工資格，則不須實際聘僱外籍家庭看護工，即可享長期照顧特別扣除額。
										<br />
										另108年度考量制度係首年實施，故放寬第一年取得病症暨失能診斷證明之時程，身心失能者在108年度所得稅申報期限(109年6月1日)前取得病症暨失能診斷證明書，可列報108年度長照扣除額。
										<br /> 資料來源：衛生福利部
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
											data-toggle="collapse" data-target="#collapseOne1"
											aria-expanded="false" aria-controls="collapseOne1">
											請問經評估不符合聘僱外籍家庭看護工資格者如何適用長期照顧特別扣除額?</button>
									</h2>
								</div>
								<div id="collapseOne1" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										如經評估不符合聘外籍家庭看護工資格，且未使用長照給支付服務、或入住住宿式機構，則不符合長期照顧特別扣除額之申報資格。 <br />
										資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne2">
											請問何謂可聘僱外籍家庭看護工之特定身障項目重度(或極重度)或鑑定向度?</button>
									</h2>
								</div>
								<div id="collapseOne2" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依據「外國人從事就業服務法第四十六條第一項第八款至第十一款工作資格及審查標準」第22條第3項，特定身心障礙項目包含平衡機能障礙、智能障礙、植物人、失智症、自閉症、染色體異常、先天代謝異常、其他先天缺陷、精神病、肢體障礙（限運動神經元或巴金森氏症等二類疾病。但曾聘僱外籍家庭看護工者，不在此限。）、罕見疾病（限運動神經元疾病。但曾聘僱外籍家庭看護工者，不在此限。）、多重障礙（至少具有前十一項身心障礙項目之一），共12項。鑑定向度則請參照勞動部公告：https://reurl.cc/W4zY25。
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
											aria-expanded="true" aria-controls="collapseOne3">
											請問如何符合聘僱外籍家庭看護工資格?</button>
									</h2>
								</div>
								<div id="collapseOne3" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										符合「外國人從事就業服務法第四十六條第一項第八款至第十一款工作資格及審查標準」第22條第1項規定得聘僱外籍家庭看護工資格之被看護者，其條件應符合以下之一：
										<br /> 符合特定身心障礙重度(或極重度)等級項目，或鑑定向度之一。 <br />
										經指定醫療機構專業評估結果符合下列情形之一：
										<ol>
											<li>年齡未滿80歲且有全日照護需要。</li>
											<li>年齡滿80歲以上且有嚴重依賴照護需要。</li>
											<li>年齡滿85歲以上且有輕度依賴照護需要。</li>
											<li>經醫療專業診斷巴氏量表評為0分且於6個月內病情無法改善。</li>
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
											data-toggle="collapse" data-target="#collapseOne4"
											aria-expanded="true" aria-controls="collapseOne4">
											領有住宿式服務機構使用者補助者是否可享長期照顧特別扣除額?</button>
									</h2>
								</div>
								<div id="collapseOne4" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										長期照顧特別扣除額係針對須長期照顧之身心失能者，給予的稅賦減免，住宿式服務機構使用者補助則係針對入住住宿式機構有實際支出的家庭給予補貼，係不同之政策新制，符合資格者兩者皆可適用。
										<br /> 資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne5">
											長期照顧特別扣除額之排富條款有哪些?</button>
									</h2>
								</div>
								<div id="collapseOne5" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依據所得稅法第17條第3項規定，長期照顧特別扣除額之排富標準如下：
										<ol>
											<li>經減除幼兒學前特別扣除額及長期照顧特別扣除額後，全年綜合所得稅適用稅率在20%以上，或採本人或配偶之薪資所得或各類所得分開計算稅額適用稅率在20%以上。</li>
											<li>選擇股利及盈餘按28%單一稅率分開計算應納稅額。</li>
											<li>依所得基本稅額條例計算之基本所得額超過規定之扣除金額670萬元。</li>
										</ol>
										<br /> 涉及稅務相關問題可撥打稅務諮詢專線0800-000-321
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
											aria-expanded="true" aria-controls="collapseOne6">
											何謂入住適格之住宿式服務機構?</button>
									</h2>
								</div>
								<div id="collapseOne6" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										適格之機構包含老人福利機構、國軍退除役官兵輔導委員會所屬榮譽國民之家(前二者機構之安養床皆除外)、身心障礙住宿式機構、護理之家機構(一般護理之家及精神護理之家)、依長期照顧服務法設立之機構住宿式服務類長期照顧服務機構，及設有機構住宿式服務之綜合式服務類長期照顧服務機構。
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
											aria-expanded="true" aria-controls="collapseOne7">
											有關長照給付及支付服務使用者須檢附課稅年度使用指定服務繳費收據影本一張，何謂「指定服務」?</button>
									</h2>
								</div>
								<div id="collapseOne7" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										指定服務係指使用「長期照顧（照顧服務、專業服務、交通接送服務、輔具服務及居家無障礙環境改善服務）給付及支付基準」之服務，即「長照4包錢」，包含：居家照顧服務、日間照顧服務、家庭托顧服務、專業服務、交通接送服務、輔具服務、居家無障礙環境改善服務、及喘息服務。
										<br /> 資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne8">
											哪些人適用長期照顧特別扣除額?</button>
									</h2>
								</div>
								<div id="collapseOne8" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依衛生福利部公告之「個人符合長期照顧特別扣除額之須長期照顧之身心失能者資格」，自108年1月1日起，納稅義務人、配偶或受扶養親屬只要符合以下身心失能資格其中1項，且未被所得稅法第17條所訂排富標準排除就可以適用，每人每年定額扣除新臺幣(以下同)
										12 萬元。
										<ol>
											<li>符合聘僱外籍家庭看護工資格者。</li>
											<li>符合長照失能等級第2至第8級，並使用長期照顧給付及支付基準服務。</li>
											<li>入住適格住宿式服務機構全年達 90 日。</li>
										</ol>
										<br /> 資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne9">
											身心失能者是否一定要聘僱家庭看護或入住住宿式服務機構才能列報長期照顧特別扣除額？</button>
									</h2>
								</div>
								<div id="collapseOne9" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										只要符合衛生福利部公告須長期照顧之身心失能者，無論是聘僱看護、使用政府長照2.0給付之服務、使用長照機構服務或由家人自行照顧，均可依規定列報長期照顧特別扣除額。
										<br /> 資料來源：財政部
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
											aria-expanded="true" aria-controls="collapseOne10">
											入住何種住宿式機構得列報長期照顧特別扣除額？又排除安養床機構之理由為何？</button>
									</h2>
								</div>
								<div id="collapseOne10" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										適格之住宿式服務機構如下：
										<ol>
											<li>老人福利機構(安養床除外)</li>
											<li>國軍退除役官兵輔導委員會所屬榮譽國民之家(安養床除外)</li>
											<li>身心障礙住宿式機構</li>
											<li>護理之家機構(一般護理之家及精神護理之家)</li>
											<li>依長期照顧服務法設立之機構住宿式服務類長期照顧服務機構</li>
											<li>設有機構住宿式服務之綜合式服務類長期照顧服務機構</li>
										</ol>
										<br />
										依老人福利機構設立標準第2條有關安養機構之規定，係以需他人照顧或無扶養義務親屬或扶養義務親屬無扶養能力，且日常生活能自理之老人為照顧對象，與長期照顧特別扣除額適用對象係須長期照顧之身心失能者有別，故入住安養型之住宿式機構不能認列。
										<br /> 資料來源：衛生福利部
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
											data-toggle="collapse" data-target="#collapseOne11"
											aria-expanded="true" aria-controls="collapseOne11">
											長期照顧特別扣除額是否訂定排富規定？</button>
									</h2>
								</div>
								<div id="collapseOne11" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										鑑於政府資源有限，為使有限資源運用於刀口上，比照幼兒學前特別扣除額，訂定排富規定，納稅義務人辦理綜合所得稅結算申報時，有下列情形之一者，不適用長期照顧特別扣除：
										<ol>
											<li>經減除幼兒學前及長期照顧特別扣除額後，納稅義務人或其配偶適用稅率在20%以上。</li>
											<li>納稅義務人選擇就其申報戶股利及盈餘合計金額按28%稅率分開計算應納稅額。</li>
											<li>納稅義務人依規定計算之基本所得額超過規定之扣除金額（108年度為670萬元）。</li>
										</ol>
										<br /> 資料來源：財政部
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
											data-toggle="collapse" data-target="#collapseOne12"
											aria-expanded="true" aria-controls="collapseOne12">
											如何查詢可進行專業評估之指定醫療醫療機構?</button>
									</h2>
								</div>
								<div id="collapseOne12" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										可查詢各縣市評估醫院之諮詢窗口、諮詢時間及評估費 用，或勞動部發布之「<a
											href="https://www.wda.gov.tw/News_Content.aspx?n=74963F5F05BDB4FB&s=5647F83E730F515F&sms=5A0BB383D955741C">申請聘僱外國人從事家庭看護工作
											之專業評估被看護者醫療機構</a>>」公告。
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
											aria-expanded="true" aria-controls="collapseOne13">
											如係使用長期照顧給付及支付基準而免部分負擔無繳費收據者，或入住住宿式機構而受有公費安置全額補助無繳費收據者，應檢具什麼證明?</button>
									</h2>
								</div>
								<div id="collapseOne13" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										失能等級第2至第8級並使用長期照顧給付及支付基準服務、免部分負擔無收據者請洽原評估之長期照顧管理中心開立公文或相關證明文件，入住住宿式機構而接受公費安置之全額補助而無繳費收據者，請洽地方政府開立公費安置公文或相關證明文件。
										<br /> 資料來源：衛生福利部
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
											data-toggle="collapse" data-target="#collapseOne14"
											aria-expanded="true" aria-controls="collapseOne14">
											繳費收據是需要全部使用服務的收據嗎?還是任一張即可?</button>
									</h2>
								</div>
								<div id="collapseOne14" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										因長期照顧特別扣除額係採定額扣除，故只要符合失能等級第2至第8級並使用長期照顧給付及支付基準服務，檢具任一項長照服務之繳費收據一張即可，不須收集所有單據。
										<br /> 資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne15">
											證明文件未註記應具備的相關資訊該如何處理?</button>
									</h2>
								</div>
								<div id="collapseOne15" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										如證明文件未註記應具備的相關資訊(如：繳費收據未註記失能等級、身分證字號等)，則請洽原服務提供單位協助重新開立，或由服務提供單位以手寫註記並加蓋單位戳章方式補上。
										<br /> 資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne16">
											證明文件如遺失該如何處理?</button>
									</h2>
								</div>
								<div id="collapseOne16" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										請洽核發證明文件之單位申請補發，如聘僱許可請洽勞動部，繳費收據則請洽原服務提供單位。</div>
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
											data-toggle="collapse" data-target="#collapseOne17"
											aria-expanded="true" aria-controls="collapseOne17">
											申報長期照顧特別扣除額應檢具什麼證明文件?</button>
									</h2>
								</div>
								<div id="collapseOne17" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										各類適用對象應檢具之證明文件如下：
										<ol>
											<li>聘僱外籍家庭看護工者：有效期限內之聘僱許可函影本</li>
											<li>長照失能等級2-8級並使用給長期照顧給付及支付基準服務：課稅年度使用服務繳費收據影本一張（須註記特約服務單位名稱、失能者姓名、身分證字號及失能等級；免部分負擔無收據者檢具長期照顧管理中心公文或相關證明文件）</li>
											<li>入住住宿式服務機構者：課稅年度入住適格機構累計達90日之繳費收據影本（須註記機構名稱、住民姓名、身分證字號、入住期間、床位類型；受全額補助無收據者檢具地方政府公費安置公文或相關證明文件)
											</li>
											<li>在家自行照顧無聘僱外籍家庭看護工或使用上述服務需求： <br />
												(1)課稅年度至指定醫療機構進行專業評估，並符合聘僱外籍家庭看護工資格：課稅年度取得之病症暨失能診斷證明書影本為證明文件
												<br />
												(2)符合可聘僱外籍家庭看護工之特定身障項目重度(或極重度)等級項目，或鑑定向度之一者：有效期限內之身心障礙證明(或手冊)影本
											</li>
										</ol>
										<br />
										另108年度考量制度係首年實施，故放寬第一年取得病症暨失能診斷證明之時程，身心失能者在108年度所得稅申報期限(109年6月1日)前取得病症暨失能診斷證明書，可列報108年度長照扣除額。
										<br /> <br /> 資料來源：衛生福利部
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
											data-toggle="collapse" data-target="#collapseOne18"
											aria-expanded="true" aria-controls="collapseOne18">
											請問採標準扣除額者是否適用?</button>
									</h2>
								</div>
								<div id="collapseOne18" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										長期照顧特別扣除額係屬特別扣除額之範圍，只要 符合規定得申報長期照顧特別扣除額者，無論採用標準扣
										除額或列舉扣除額者，均可以申報扣除長期照顧特別扣除 額。 <br /> <br /> 涉及稅務相關問題可撥打稅務諮詢專線
										0800-000-321 <br /> <br /> 資料來源：衛生福利部
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
											aria-expanded="true" aria-controls="collapseOne19">
											申報期間可以向國稅局臨櫃查詢或自行上網下載列報長期照顧特別扣除額資料嗎？</button>
									</h2>
								</div>
								<div id="collapseOne19" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										向國稅局申請查詢或上網下載扣除額資料如有列示長期照顧特別扣除額者，可免檢附證明文件，如資料查詢
										不到，但申報戶成員符合衛生福利部公告須長期照顧的身 心失能者，於申報時應自行檢附規定的證明文件據以列報 扣除該項扣除額。 <br />
										<br /> 涉及稅務相關問題可撥打稅務諮詢專線 0800-000-321 <br /> <br />
										資料來源：財政部
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
											aria-expanded="true" aria-controls="collapseOne20">
											領有身心障礙證明，且符合身心失能適用資格者，只能擇一扣除額嗎？</button>
									</h2>
								</div>
								<div id="collapseOne20" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										須長期照顧的身心失能者，如同時領有身心障礙證明，除可扣除身心障礙特別扣除額20萬元，並得再扣除長期照顧特別扣除額12萬元，合計可減除32萬元，對於有身心失能照護需求的家庭，提供適切的協助。

										<br /> 涉及稅務相關問題可撥打稅務諮詢專線 0800-000-321 <br /> <br />
										資料來源：財政部
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
											aria-expanded="true" aria-controls="collapseOne21">
											增訂長期照顧特別扣除額的目的為何？</button>
									</h2>
								</div>
								<div id="collapseOne21" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										配合政府推動長期照顧政策，適度減輕中低所得家庭照顧身心失能者的負擔。 <br /> 資料來源：財政部
									</div>
								</div>
							</div>
						</div>
					</li>
				</ol>
			</div>
			<div class="tab-pane fade" id="pills-contact1" role="tabpanel"
				aria-labelledby="pills-contact1-tab">
				<ol>
					<li>
						<div class="accordion" id="accordionExample">
							<div class="card">
								<div class="card-header" id="headingOne">
									<h2 class="mb-0">
										<button class="btn btn-link" type="button"
											data-toggle="collapse" data-target="#collapseOne22"
											aria-expanded="true" aria-controls="collapseOne22">
											何謂可聘僱外籍家庭看護工之特定身障項目重度(或極重度)或鑑定向度?</button>
									</h2>
								</div>
								<div id="collapseOne22" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										依據「外國人從事就業服務法第四十六條第一項第八款至第十一款工作資格及審查標準」第22條第3項，特定身心障礙項目包含平衡機能障礙、智能障礙、植物人、失智症、自閉症、染色體異常、先天代謝異常、其他先天缺陷、精神病、肢體障礙（限運動神經元或巴金森氏症等二類疾病。但曾聘僱外籍家庭看護工者，不在此限。）、罕見疾病（限運動神經元疾病。但曾聘僱外籍家庭看護工者，不在此限。）、多重障礙（至少具有前十一項身心障礙項目之一），共12項。鑑定向度則請參照勞動部公告：
										<br /> <a
											href="https://laws.mol.gov.tw/FLAW/FLAWDOC03.aspx?cnt=65&datatype=etype&edate=20191231&lnabndn=1&now=1&recordno=16&sdate=20190101">https://reurl.cc/W4zY25</a>
										<br /> 資料來源：勞動部
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
											aria-expanded="true" aria-controls="collapseOne23">
											因遺失聘僱(或接續聘僱)許可函申請補發，後續相關程序應如何辦理？</button>
									</h2>
								</div>
								<div id="collapseOne23" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										雇主如欲補發之聘僱許可函原係委任仲介公司辦理，倘雇主與仲介公司委任關係存續中，應委任仲介公司辦理；但如已與仲介公司解除委任關係，可檢附與原委任仲介公司解除委任關係之契約書影本、併同申請表件（雇主聘僱外國人申請書，表格代號：NAF-022-3，可至勞動部專區下載https://reurl.cc/M7Q8eW），自行提出申請。
										<br /> 資料來源：勞動部
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
											aria-expanded="true" aria-controls="collapseOne24">
											雇主檢附之解除委任關係契約書影本，有無固定格式範本或須注意事項？</button>
									</h2>
								</div>
								<div id="collapseOne24" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										解除委任關係契約書影本無固定格式範本，但須注意與原受委任仲介公司之解約日應在辦理申請補發許可函之日前完成，如有加註與外國人之解約事由，亦請一併改以「改以自行辦理方式申請」。
										<br /> 資料來源：勞動部
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
											aria-expanded="true" aria-controls="collapseOne25">
											雇主應如何申請補發許可函？</button>
									</h2>
								</div>
								<div id="collapseOne25" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										1.雇主可採線上申請(網址：https://fwapply.wda.gov.tw/efpv/wSite/Control?function=IndexPage)，(1)補發聘僱許可，申請項目勾選為30-3E；(2)補發接續聘僱許可，申請項目請勾選30-3F。
										<br />
										2.雇主如自行辦理，因故無法以線上方式申請，則可填具申請書表格代號：NAF-022-3補發申請書，並加附說明函改採臨櫃親送或郵寄本部以紙本方式申請。
										<br />
										註：勞動部受理申請外國人來臺工作業務服務時間：週一至週五上午8時30分至下午5時30分；受理親自送件服務地址：100
										臺北市中正區中華路一段39號10樓；電話：02-89956000 <br /> <br /> 資料來源：勞動部
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
											data-toggle="collapse" data-target="#collapseOne26"
											aria-expanded="true" aria-controls="collapseOne26">
											雇主申請補發許可函，是否需要繳交審查費？</button>
									</h2>
								</div>
								<div id="collapseOne26" class="collapse"
									aria-labelledby="headingOne" data-parent="#accordionExample">
									<div class="card-body">
										雇主申請補發聘僱許可函或接續聘僱許可函，每件應繳納100元整。 <br /> <br />
										註：審查費郵政劃撥資訊。戶名：勞動部勞動力發展署聘僱許可收費專戶，劃撥帳號：19058848。 <br /> <br />
										資料來源：勞動部
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