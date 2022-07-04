package com.jerryboot.springbootdemo.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MemberDto implements Serializable {
//	//宣告AJAX的Key變數
//	private String memberAccount;
//	如果不想用key當變數
	@JsonProperty("memberAccount")//塞AJAX的Key
	private String dtoMemberAccount;

	public MemberDto() {
		super();
		// TODO Auto-generated constructor stub
	}

//	public String getMemberAccount() {
//		return memberAccount;
//	}
//
//	public void setMemberAccount(String memberAccount) {
//		this.memberAccount = memberAccount;
//	}

	public String getDtoMemberAccount() {
		return dtoMemberAccount;
	}

	public void setDtoMemberAccount(String dtoMemberAccount) {
		this.dtoMemberAccount = dtoMemberAccount;
	}
	
}
