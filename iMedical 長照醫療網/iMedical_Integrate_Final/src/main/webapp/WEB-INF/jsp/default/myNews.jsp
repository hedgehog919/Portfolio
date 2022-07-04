<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
			<script type="text/javascript">
				$(function () {
					$("#tabs").tabs();
				});
			</script>

			<style>
				.ui-tabs-nav {
					background-color: white !important;
				}

				#tabs {
					padding: 0px;
					border: 1px solid #eeeeee;
				}

				#p1,#p2 {
/* 					padding: 15px; */
					background-color: #F7F5F4!important;
					height: 550px;
				}

				#p1 a, #p2 a {
					width: 100%;
					text-decoration: none;
					color: #333;
					font-size: 20px;
					font-weight: 400;
				}

				#p1 a:hover, #p2 a:hover {
					color: #9C2D11;
					font-weight: 700;
					transition: ease-out 0.25s;
				}

				#p1>div:not(:last-of-type), #p2>div:not(:last-of-type) {
					margin: 22px;
					border-bottom: 1px solid #266434;
				}

				.newsDate {
					margin-top: 5px;
					margin-bottom: 10px;
				}

				.newsDate>span {
					background-color: #308F8F;;
					color: white;
					padding: 5px 8px 5px 8px;
				}

				.fa-caret-right {
					text-align: center;
				}
				
				.newsBtn{
					cursor: pointer;
					font-weight: bolder;
					font-size: 20px;
				}
				
				.newsBtn:hover{
					color: #9C2D11;
					
					transform: translate(0px, 4px);
					font-weight: bolder;
					transition: ease-out 0.2s;
					
				}
				
				
				
/* 				.fade-in-text{ */
/* 						 animation: fadeInAnimation ease .5s; */
/* 	           			 animation-iteration-count: 1; */
/* 	           		     animation-fill-mode: forwards; */
/* 					} */
					
/* 				@keyframes fadeInAnimation { */
/* 				    0% { */
/* 				        opacity: 0; */
/* 				    } */
/* 				    100% { */
/* 				        opacity: 1; */
/* 				     } */
/* 				 } */

				
			</style>

		</head>

			<div class="container mt-4">
				<div class="row justify-content-center">
					<div class="col-10">
						<div id="tabs">
							<ul>
								<li><a href="#p1">最新公告</a></li>
								<li><a href="#p2">活動快報</a></li>
							</ul>
							<div id="p1">
								<div class="mb-2 d-flex justify-content-center">
									<div class="newsBtn" onclick="window.location.assign('${contextRoot}/newsInfo')">
										更多資訊
									</div>
								</div>
							</div>
							<div id="p2">
								<div class="mb-2 d-flex justify-content-center">
									<div class="newsBtn" onclick="window.location.assign('${contextRoot}/newsInfo')">
										更多資訊
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<script>
				var p1UrlString = '${contextRoot}' + '/getNewsForIndexPage?category=最新公告';
				var P1TargetId = '#p1';
				<%-- #p1 --%>
				doGetAjax(p1UrlString, P1TargetId);
				<%-- #p2 --%>
				var p2UrlString = '${contextRoot}' +'/getNewsForIndexPage?category=活動快報';
				var p2TargetId = '#p2';
				doGetAjax(p2UrlString, p2TargetId);

				
				
				function doGetAjax(targetUrl, targetId) {
					$.ajax({
						method: 'get',
						dataType: 'json',
						url: targetUrl,
						success: function (result) {
							var resultString = '';
							var newsMsgList = result.newsMsgList;
							var currPage = result.currPage;
							$.each(newsMsgList, function (index, value) {
								url = '${contextRoot}' + '/newsInfoPage?' + 'id=' + value.id	+ '&page=' + currPage;
								resultString += '<div>';
								resultString += '<a class="d-flex fade-in-text" href="' + url + '"><i class="fas fa-caret-right mr-3"></i>';
								resultString += value.title	+ '</a>';
								resultString += '<div class="newsDate"><span >' + formatDate(value.date)	+ '<span></div></div>';
							});
							$(targetId).prepend(resultString);
						}
					});
				}
				
				
				function formatDate(date) {
					var d = new Date(date);
					var year = d.getFullYear();
					var month = d.getMonth() + 1;
					var date = d.getDate() < 10?  '0' + d.getDate() : d.getDate();
					return year + "-0" + month + "-" + date;
				}
			</script>
