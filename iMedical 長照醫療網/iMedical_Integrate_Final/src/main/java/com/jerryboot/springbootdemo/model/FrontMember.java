package com.jerryboot.springbootdemo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="fromember")
public class FrontMember {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="fromember_id")
	private Integer id;
	@Column(name="fromember_account",columnDefinition ="nvarchar(200)", nullable = false)
	private String fromemberAccount;
	@Column(name="fromember_password",columnDefinition ="nvarchar(200)", nullable = false)
	private String fromemberPassword;
	@Column(name="fromember_name",columnDefinition ="nvarchar(50)", nullable = false)
	private String fromemberName;
	@Column(name="fromember_phone",columnDefinition ="nvarchar(20)", nullable = false)
	private Integer fromemberPhone;
	@Column(name="fromember_lineid",columnDefinition ="nvarchar(50)", nullable = false)
	private String fromemberLineId;
	@Column(name="fromember_address",columnDefinition ="nvarchar(100)", nullable = false)
	private String fromemberAddress;
	@Column(name="fromember_email",columnDefinition ="nvarchar(200)", nullable = false)
	private String fromemberEmail;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	@Temporal(TemporalType.DATE)
	@Column(name="fromember_birthday", columnDefinition = "datetime", nullable = false)
	private Date fromemberBirthday;
	@Column(name="fromember_gender",columnDefinition ="nvarchar(5)", nullable = false)
	private String fromemberGender;
	
	
	
	public FrontMember() {
	}
	
	public void onCreate() {
		if(fromemberBirthday == null) {
			fromemberBirthday = new Date();
		}
	}
	


	@Override
	public String toString() {
		return "Member [id=" + id + ", memberAccount=" + fromemberAccount + ", memberPassword=" + fromemberPassword
				+ ", memberName=" + fromemberName + ", memberPhone=" + fromemberPhone + ", memberLineId=" + fromemberLineId
				+ ", memberAddress=" + fromemberAddress + ", memberEmail=" + fromemberEmail + ", memberBirthday="
				+ fromemberBirthday + ", memberGender=" + fromemberGender + "]";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFromemberAccount() {
		return fromemberAccount;
	}

	public void setFromemberAccount(String fromemberAccount) {
		this.fromemberAccount = fromemberAccount;
	}

	public String getFromemberPassword() {
		return fromemberPassword;
	}

	public void setFromemberPassword(String fromemberPassword) {
		this.fromemberPassword = fromemberPassword;
	}

	public String getFromemberName() {
		return fromemberName;
	}

	public void setFromemberName(String fromemberName) {
		this.fromemberName = fromemberName;
	}

	public Integer getFromemberPhone() {
		return fromemberPhone;
	}

	public void setFromemberPhone(Integer fromemberPhone) {
		this.fromemberPhone = fromemberPhone;
	}

	public String getFromemberLineId() {
		return fromemberLineId;
	}

	public void setFromemberLineId(String fromemberLineId) {
		this.fromemberLineId = fromemberLineId;
	}

	public String getFromemberAddress() {
		return fromemberAddress;
	}

	public void setFromemberAddress(String fromemberAddress) {
		this.fromemberAddress = fromemberAddress;
	}

	public String getFromemberEmail() {
		return fromemberEmail;
	}

	public void setFromemberEmail(String fromemberEmail) {
		this.fromemberEmail = fromemberEmail;
	}

	public Date getFromemberBirthday() {
		return fromemberBirthday;
	}

	public void setFromemberBirthday(Date fromemberBirthday) {
		this.fromemberBirthday = fromemberBirthday;
	}

	public String getFromemberGender() {
		return fromemberGender;
	}

	public void setFromemberGender(String fromemberGender) {
		this.fromemberGender = fromemberGender;
	}


}
