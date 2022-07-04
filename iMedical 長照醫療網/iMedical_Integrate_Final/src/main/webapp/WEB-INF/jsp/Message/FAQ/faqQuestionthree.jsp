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
<title>FAQ 第三篇</title>

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
				<li class="breadcrumb-item"><a href="/myapp/faqQuestionthree">長照機構法人</a></li>
			</ol>
		</nav>
		<h3 style="text-align:center">長照機構法人</h3>
		<hr class="my-4">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="pills-home-tab" data-toggle="pill"
				href="#pills-home" role="tab" aria-controls="pills-home"
				aria-selected="false">長照機構法人條例</a></li>
		</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-home"
				role="tabpanel" aria-labelledby="pills-home-tab"></div>
			<ol>
				<li>
					<div class="accordion" id="accordionExample">
						<div class="card">
							<div class="card-header" id="headingOne">
								<h2 class="mb-0">
									<button class="btn btn-link" type="button"
										data-toggle="collapse" data-target="#collapseOne"
										aria-expanded="false" aria-controls="collapseOne">
										長照機構法人與其長照機構，可否同址設立?</button>
								</h2>
							</div>
							<div id="collapseOne" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">原則可以。</div>
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
										長照機構社團法人其社會回饋機制之提撥方式？</button>
								</h2>
							</div>
							<div id="collapseOne2" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									<ol>
										<li>應提撥前一會計年度收支結餘之百分之十以上，辦理有關研究發展、人才培訓、長照宣導教育及社會福利。長照公益社團法人從事社會福利者，亦認屬前項辦理事項。</li>
										<li>長照社團法人需另提撥20%以上作為營運資金，係基於營運資金之提撥係屬盈餘準備，有助法人營運穩健。</li>
										<li>長照社團法人依上開規定完成提撥後，盈餘可分配。但長照公益社團法人，不得分配盈餘。</li>
										<li>長照公益社團法人，因其具有財團法人性質，不需提撥營運資金，但仍需提撥法人前一會計年度收支結餘10%以上，辦理第1點事項。</li>
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
										data-toggle="collapse" data-target="#collapseOne3"
										aria-expanded="false" aria-controls="collapseOne3">
										長照機構社團法人之董事由具長照人員資格擔任者，是否須為社員？</button>
								</h2>
							</div>
							<div id="collapseOne3" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									本條例第33條第3項第1款所稱長照機構社團法人之董事，係由具長照人員資格擔任者，其亦需屬於社員後始擔任董事。</div>
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
										現行法人及機構之轉銜及未來哪些法人仍可申請成為「長照其他法人」?</button>
								</h2>
							</div>
							<div id="collapseOne4" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									<ol>
										<li>附則規定現行（本條例施行前）法人的銜接：(§44) <br />
											本條例施行前，已依其他法律設立且辦理社會福利事項或醫事服務之財團法人、公益社團法人或醫療法人，經依其設立之各該法律規定辦理章程及登記事項變更，並報經主管機關許可後，得依長期照顧服務法規定設立機構住宿式長照服務機構。
										</li>
										<li>配套規定：(§45) <br />
											管理與長照機構法人性質相同之事項，即應準用本條例規範(包括法人所設立長照機構之區域、分類、家數及規模、達設立目的必要財產、投資、保證及應接受主管機關檢查財務、業務狀況等)
											。至於表決權、董事、提撥，均依原設立法律規定，不受本條例限制。
										</li>
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
										長照機構法人，可否增設其他福利相關機構？</button>
								</h2>
							</div>
							<div id="collapseOne5" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									採有限度開放之原則，長照機構法人經主管機關許可後，得設立社會福利機構或提供經中央主管機關公告之服務。又，社會福利機構包含老人福利機構、身心障礙福利機構、兒童及少年福利機構、婦女福利機構及社會救助等社會福利機構。
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
										aria-expanded="false" aria-controls="collapseOne6">長照機構社團法人解散後財產之處理</button>
								</h2>
							</div>
							<div id="collapseOne6" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									社團法人係以多數人集合成立之組織體，其組成基礎為社員，非以公益為目的之長照機構社團法人除盈餘可分配之外，其社員的出資及解散後賸餘財產歸屬，則逕依該法人所訂之組織章程規範進行處理。
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
										長照機構社團法人之社員表決權</button>
								</h2>
							</div>
							<div id="collapseOne7" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									每一社員均有一表決權；得以章程訂定，按其出資額占出資額總額比率分配表決權。但以公益為目的之長照機構社團法人，不適用之。</div>
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
										公司法人可否直接指派1名自然人代表擔任監察人(該自然人非社員)？</button>
								</h2>
							</div>
							<div id="collapseOne8" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									未明文禁止。又因該公司法人即為社員，故可指派1名自然人代表其行使職權。(另參公司法第27條第1項)</div>
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
										aria-expanded="false" aria-controls="collapseOne9">公司法人指定代表可否同時又以自然人身分擔任社員？</button>
								</h2>
							</div>
							<div id="collapseOne9" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">公司法人之社員指定代表，不應同時又以自然人身分擔任社員。</div>
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
										aria-expanded="false" aria-controls="collapseOne10">長照機構社團法人之董事，是否需具社員身分？</button>
								</h2>
							</div>
							<div id="collapseOne10" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
									社團法人係以社員為成立基礎，設立人即為其構成分子，即為社員。按長照機構法人條例第10條規定，法人應成立董事會且應置董事及監察人等，爰係由該法人之社員選任前開董監事代表為之。
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
										aria-expanded="false" aria-controls="collapseOne11">公司法人可否本身即擔任長照機構法人社員？是否有相關限制？</button>
								</h2>
							</div>
							<div id="collapseOne11" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
								<ol>
								<li>公司法人可以本身即是社員。</li>
								<li>為維護弱勢者被照顧之權利及品質，對公司法人投資此類機構有條件規範，包括：營利法人社員指定代表及外國人之董事總名額不得逾1/3，且不得擔任董事長。</li>
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
</body>
</html>