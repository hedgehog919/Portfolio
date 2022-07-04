<%@ page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String requestURI = request.getRequestURI();
   requestURI = requestURI.substring(0, requestURI.indexOf("WEB-INF"));
%>
<%@ page isELIgnored="true" %>
<jsp:include page="../default/myNavbar.jsp"></jsp:include>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>公告管理</title>
	<link rel="stylesheet" 	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css">
	<link rel="stylesheet" 	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.css">

<style>
	html{
		heigth: 100%;
	}
	
	body{
		font-size: 20px;
		background-color: rgba(0, 0, 0, 0.25);
	}

	.col-10 {
		background-color: white;
		border: 2px solid #ddd;
	}
	
	#selectSortType, #selectPerPageNum, #jumpPage{
		border: 1px solid #ced4da;
		border-radius: 0.25rem;
	}
	
	#selectSortType:focus, #selectPerPageNum:focus, #jumpPage:focus{
		background-color: #fff;
	    border-color: #80bdff;
	    outline: 0;
	    box-shadow: 0 0 0 0.2rem rgb(0 123 255 / 25%);
	}
	
	}
	a {
		text-decoration: none !important;
	}
	th, td{
		vertical-align: middle !important;
	}
	th:nth-child(1),td:nth-child(1) {
		width: 80px;
	}

	th:nth-child(2),td:nth-child(2) {
		width: 180px;
	}
	
	th:nth-child(3),td:nth-child(3) {
		width: 700px;
	}
	
	th:nth-child(4),td:nth-child(4) {
		text-align:center;
		width: 100px;
	}
	th:nth-child(5),td:nth-child(5) {
		text-align:center;
		width: 100px;
	}
	#header {
		color: #bd3359;
		font-size: 28px;
		font-weight: bolder;
		width: 40%;
	}
	#newsInfoContainer {
		width: 80%;
		
	}
	#newsInfoContainer>div>div{
		box-shadow: 0px 0px 12px rgb(0 ,0 ,0 , 0.1); 
		padding: 30px 80px;
		
		height: 620px; 
		
	}
	
	.fa,.fa-cog{
		color: #bd3359;
		font-size: 24px;
		padding-right: 5px;
	}
	
	
</style>


</head>




<body>
	<!-- header block-->
	<section class="mt-5 mb-5">
		<div class="container-fluid" id="newsInfoContainer">
			<div class="row justify-content-center h-100">
				<div class="col-10">
					<div><i class="fa fa-cog" aria-hidden="true"></i><span id="header">公告管理</span></div>
					<div class="d-flex justify-content-between" id="selectOptionDiv">
						<div class="pt-3" id="selectOptionBox">
							<span>排序:</span>
							<select id="selectSortType">
							</select>
							<select id="selectPerPageNum">
								<option value="1">5項/頁</option>
								<option value="2">10項/頁</option>
							</select>
						</div>
						<div class="d-flex form-inline" id="searchText">
							<input type="search" class="form-control" name="search" placeholder="關鍵字搜尋" id="searchInput"/>
							<button class="btn btn-outline-secondary" type="button" id="searchBtn">搜尋</button>
						</div>
					</div>
					
					<div class="col mt-2 p-0" id="newsMsgList">
						<table class="table">
						  <thead class="thead-dark">
						    <tr>
						      <th scope="col">#</th>
						      <th scope="col">上架時間</th>
						      <th scope="col">公告標題</th>
						      <th scope="col">編輯</th>
						      <th scope="col">刪除</th>
						    </tr>
						  </thead>
						  <tbody>
						    
						  </tbody>
						</table>
						<div id="newsInfoBtnDiv">
							<div class="row justify-content-center" id="newsInfoBtnRow">
								
							</div>
						</div>
						<div class="d-flex justify-content-center mt-3 mb-3">
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<script>
		<%------- 頁面初始化 -------%>
		const localUrl = '/iMedical/';
		console.log(localUrl)
		const selectOptionList = ['date_desc', 'date_asc', 'views_desc', 'views_asc'];
		const selecOptionText = ['上架日期新至舊', '上架日期舊至新', '瀏覽次數多至少', '瀏覽次數少至多'];  <%--排序方式可擴充--%>
			
		var newsInfoPage;
		var selectedVal = 0;
		var perPageNum = 5;
		var keyWord = null;
		var dtoObject = {
				'page': 1,
				'sortType': selectOptionList[selectedVal], <%--值會改變!!!!!!!!!--%>
				'keyWord': keyWord,
		};
		var targetUrl = localUrl + 'Backstage/postDataList'; 	
		<%-- 初始化頁面 --%>
		doPostAjax(targetUrl, dtoObject, false, selectedVal);
		
		<%--註冊事件聆聽功能--%>
		$(document).ready(function(){
			$('#searchBtn').click(function(){
				keyWord = $('#searchInput').val();
				console.log(keyWord)
				selectedVal = 0;
				perPageNum = 5;
				$('#selectPerPageNum')[0].selectedIndex = 0;
				dtoObject = {
					'page': 1,
					'perPageNum': 5,
					'sortType': selectOptionList[0],
					'keyWord': keyWord,
				};
				targetUrl = localUrl + 'Backstage/postDataList';
				doPostAjax(targetUrl, dtoObject, true, selectedVal);
			})
			
			$('#selectPerPageNum').change(function(){
				perPageNum = $(this).val() * 5;
				console.log(perPageNum)
				if (perPageNum <= 5) 
					$('#newsInfoContainer>div>div').css('height', '620px');
				else $('#newsInfoContainer>div>div').css('height', '100%');
				
				dtoObject = {
					'page': 1,
					'perPageNum': perPageNum,
					'sortType': selectOptionList[selectedVal],
					'keyWord': keyWord,
				};
				targetUrl = localUrl + 'Backstage/postDataList';
				doPostAjax(targetUrl, dtoObject, true, selectedVal);
			});
			
			$('#selectSortType').change(function(){
				selectedVal = $(this).val();
				dtoObject = {
					'page': 1,
					'perPageNum': perPageNum,
					'sortType': selectOptionList[selectedVal],
					'keyWord': keyWord,
				};
				targetUrl = localUrl + 'Backstage/postDataList';
				doPostAjax(targetUrl, dtoObject, true, selectedVal);
			});
			
			
			
		});
		
		function doPostAjax(targetUrl, dtoObject, isRemoval, selectedVal) {
			//console.log(dtoObject)
			$.ajax({
				url: targetUrl,
				method: "post",
				contentType: "application/json;charset=utf-8",
				data: JSON.stringify(dtoObject),
				dataType: "json",
				success: function(result) {
					newsInfoPage = result;
					var newsMsgList = newsInfoPage.newsMsgList;
// 					console.log(newsMsgList);
					<%--初始化頁面--%>
					if (isRemoval) removeAllInnerHtml();
					doSelectOptionDivHtml(selectedVal);					
					doNewsMsgListHtml(newsMsgList);
					doNewsInfoBtnHtmlRow(result.currPage, result.totalPage, result.totalMsgNum);
					
					
					<%--事件聆聽功能--%>
					addChangePageListener(event);
					addJumpPageListener();
					addDeleteNewsListener(event);
				},
				error: function(err) {
					console.log(err);
				}
			});
			
		}
		
		function doSelectOptionDivHtml(selectedVal) {
			var selectOptionHtml = '';
			for (var i = 0; i < selecOptionText.length; i++) {
				selectOptionHtml += `<option value="${i}">${selecOptionText[i]}</option>`;
			}
			
			$('#selectSortType').append(selectOptionHtml);
			$('#selectSortType')[0].selectedIndex = selectedVal; <%--!!!!!!!!!!!!!!!!!!查看資料--%>
		}
		
		function doNewsMsgListHtml(dataList) {
			var newsMsgListHtml ='';
			$.each(dataList, function(index, value){
				var d = formatDate(value.date); <%-- ex: 2022-05-31 --%>
				var editionUrl = localUrl + 'Backstage/editNewsMessage'+ "?id=" + value.id; <%--路徑待修--%>
				$('#newsMsgList tbody').append(`
						<tr>
						  <th scope="row">${index + 1}</th>
					      <td class="newsDate">${d}</th>
					      <td>${value.title}</td>
					      <td><a href="${editionUrl}"><button type="button" class="btn btn-secondary">編輯</button></a></td>
					      <td><a href="${value.id}" class="deleteBtn"><button type="button" class="btn btn-secondary">刪除</button></a></td>
					    </tr>
					`);
			});
		}
		
		function formatDate(date) {
			var d = new Date(date);
			var year = d.getFullYear();
			var month = '0' + (d.getMonth() + 1);
			var day = d.getDay();
			var date = d.getDate() < 10?  '0' + d.getDate() : d.getDate();
			return year + "-" + month + "-" + date;
		}
		
		function doNewsInfoBtnHtmlRow(currPage, totalPage, totalMsgNum) {
			var newsInfoBtnHtml = '';
			if (currPage != 1) {
				newsInfoBtnHtml += `
					<a href="?page=1">最前一頁</a>
					<span>|</span>
					<a href="?page=${currPage - 1}">上一頁</a>
					<span>|</span>`;
			}
			if (currPage < totalPage) {
				newsInfoBtnHtml += `
					<a href="?page=${currPage + 1}">下一頁</a>
					<span>|</span>
					<a href="?page=${totalPage}">最後一頁</a>
					<span>|</span>`;
			}
			newsInfoBtnHtml += `
				<span>${currPage}/${totalPage}頁</span> 
				<span>|</span>
				<span>共: ${totalMsgNum}筆</span> 
				<span>|</span> <span>快速跳頁:</span>`;
				
			newsInfoBtnHtml += `<select	id="jumpPage" name="jumpPage">`;
			for (var i = 1; i <= totalPage; i++) {
				if (i == currPage) newsInfoBtnHtml += `<option value="${i}" selected="selected">${i}</option>`;
				else newsInfoBtnHtml += `<option value="${i}">${i}</option>`;
			}
			newsInfoBtnHtml += `</select>`;
			
			$('#newsInfoBtnRow').append(newsInfoBtnHtml);
		}
		
		
		function removeAllInnerHtml() {
			$('#selectSortType').children().remove();
			$('#newsMsgList tbody').children().remove();
			$('#newsInfoBtnRow').children().remove();
		}
		
		function addChangePageListener(event) {
			$('#newsInfoBtnRow a').click(function(event){
				event.preventDefault();
				pageText = $(this).text();
				if ("下一頁" == pageText)
					page = 1;
				else if ("上一頁" == pageText)
					page = -1;
				else if ("最前一頁" == pageText) {
					page = 1 - newsInfoPage.currPage;
				} else if ("最後一頁" == pageText) {
					page = newsInfoPage.totalPage - newsInfoPage.currPage;
				}
				dtoObject = {
						'page': newsInfoPage.currPage + page,
						'perPageNum': perPageNum,
						'sortType': selectOptionList[selectedVal],
						'keyWord': keyWord,
				};
				targetUrl = localUrl + 'Backstage/postDataList';
				doPostAjax(targetUrl, dtoObject, true, selectedVal);
			})
			
		}
		
		function addJumpPageListener() {
			$('#jumpPage').change(function() {
				var page = $(this).val();
				dtoObject = {
					'page': page,
					'perPageNum': perPageNum,
					'sortType': selectOptionList[selectedVal],
					'keyWord': keyWord,
				};
				targetUrl = localUrl + 'Backstage/postDataList';
				doPostAjax(targetUrl, dtoObject, true, selectedVal);
			});
		}
		
		function addDeleteNewsListener(event) {
			$('.deleteBtn').each(function(event){
				$(this).click(function(event){
					event.preventDefault();
					Math.seed = Date.now();
					randomValue = creatRandomNum();
					var promtString = "刪除該筆資料請輸入: " + randomValue;
					var confirmText = window.prompt(promtString);
					
					if (confirmText != null) {
						if (confirmText.toUpperCase() === randomValue.toUpperCase()) {
							alert('該筆資料刪除成功!');
							var id = $(this).attr('href');
							deleteObject = {
								'page': newsInfoPage.currPage,
								'perPageNum': perPageNum,
								'sortType': selectOptionList[selectedVal],
								'keyWord': keyWord,
							}
							targetUrl = localUrl + 'Backstage/deleteNewsMessage' + '?id=' + id;
							doPostAjax(targetUrl, dtoObject, true, selectedVal);
						} else {
							alert('該筆資料刪除失敗!');
						}
					}
				})
			
			})
		}
		
		function creatRandomNum() {
			var randomValue = '';
			var total = 4;
			var index = 0; var alphaCount = 0; var numCount = 0;
			while (index < total) {
				bitNum = parseInt(Math.random() * 2);
				if (bitNum == 0 && alphaCount < 2) {
					randomValue += String.fromCharCode(Math.random() * 26 + 97);
					alphaCount++;
					index++;
				}
				else if (bitNum == 1 && numCount < 2) {
					randomValue += parseInt(Math.random() * 10);
					numCount++;	
					index++;
				}
			}
			return randomValue;
		}	
			 
	</script>	
	
	
	
		<footer class="main-footer" style="margin-top: 100px;">
		<div class="container" style="width: 100%; text-align: center;">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.0.01
			</div>
			<strong>Copyright © 2022-2025 <a href="">iMedical</a>.
			</strong> All rights reserved.
		</div>

		</footer>
	
	
</body>

</html>