package com.jerryboot.springbootdemo.model;

import java.util.List;

public class NewsInfoPage {
	private	List<NewsMessage> newsMsgList;
	private Integer totalMsgNum;
	private Integer totalPage;
	private Integer currPage;
	
	public NewsInfoPage() {
	}
	

	public NewsInfoPage(List<NewsMessage> newsMsgList, Integer totalMsgNum, Integer totalPage, Integer currPage) {
		this.newsMsgList = newsMsgList;
		this.totalMsgNum = totalMsgNum;
		this.totalPage = totalPage;
		this.currPage = currPage;
	}

	public List<NewsMessage> getNewsMsgList() {
		return newsMsgList;
	}
	
	public void setNewsMsgList(List<NewsMessage> newsMsgList) {
		this.newsMsgList = newsMsgList;
	}
	
	public Integer getTotalMsgNum() {
		return totalMsgNum;
	}
	
	public void setTotalMsgNum(Integer totalMsgNum) {
		this.totalMsgNum = totalMsgNum;
	}
	
	public Integer getTotalPage() {
		return totalPage;
	}
	
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getCurrPage() {
		return currPage;
	}

	public void setCurrPage(Integer currPage) {
		this.currPage = currPage;
	}
	
	
	
}
