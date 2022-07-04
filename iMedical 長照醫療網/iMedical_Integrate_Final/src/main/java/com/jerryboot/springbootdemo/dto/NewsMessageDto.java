package com.jerryboot.springbootdemo.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class NewsMessageDto {
	@JsonProperty("page")
	private Integer page;
	
	@JsonProperty("perPageNum")
	private Integer perPageNum;
	
	@JsonProperty("sortType")
	private String sortType;
	
	@JsonProperty("keyWord")
	private String keyWord;
	

	public NewsMessageDto() {
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(Integer perPageNum) {
		this.perPageNum = perPageNum;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	

	
}
