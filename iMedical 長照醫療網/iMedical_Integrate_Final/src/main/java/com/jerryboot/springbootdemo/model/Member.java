package com.jerryboot.springbootdemo.model;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="member")
public class Member {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="member_id")
	private Integer id;
	@Column(name="member_account",columnDefinition ="nvarchar(200)", nullable = false,unique = true)
	private String memberAccount;
	@Column(name="member_password",columnDefinition ="nvarchar(200)", nullable = false)
	private String memberPassword;
	@Column(name="member_name",columnDefinition ="nvarchar(50)", nullable = false)
	private String memberName;
	//權限 預設 normal,ROLE_menber
	@Column(name="member_authority",columnDefinition ="nvarchar(100)", nullable = false)
	private String memberAuthority;
	//
	@Column(name="member_phone",columnDefinition ="nvarchar(20)", nullable = false)
	private Integer memberPhone;
	@Column(name="member_lineid",columnDefinition ="nvarchar(50)", nullable = false)
	private String memberLineId;
	@Column(name="member_address",columnDefinition ="nvarchar(100)", nullable = false)
	private String memberAddress;
	@Column(name="member_email",columnDefinition ="nvarchar(200)", nullable = false)
	private String memberEmail;
//	@Column(name="collect_agency",columnDefinition ="nvarchar(200)", nullable = false)
//	private String collectAgency;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Temporal(TemporalType.DATE)
	@Column(name="member_birthday", columnDefinition = "datetime", nullable = false)
	private Date memberBirthday;
	@Column(name="member_gender",columnDefinition ="nvarchar(5)", nullable = false)
	private String memberGender;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "member",cascade = CascadeType.ALL)
	private Set<AssistiveDeviceApplicationForm> assistiveDeviceApplicationForm =new LinkedHashSet<AssistiveDeviceApplicationForm>();
	
	/*
	 * 關聯訂單
	 * 一方對多
	 */
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "member",cascade = CascadeType.ALL)
	private Set<ShoppingCart> ShoppigCarts =new LinkedHashSet<ShoppingCart>();


	public Member() {
	}
	
	
	

	
	public Set<AssistiveDeviceApplicationForm> getAssistiveDeviceApplicationForm() {
		return assistiveDeviceApplicationForm;
	}





	public void setAssistiveDeviceApplicationForm(Set<AssistiveDeviceApplicationForm> assistiveDeviceApplicationForm) {
		this.assistiveDeviceApplicationForm = assistiveDeviceApplicationForm;
	}





	public void onCreate() {
		if(memberBirthday == null) {
			memberBirthday = new Date();
		}
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Member [id=");
		builder.append(id);
		builder.append(", memberAccount=");
		builder.append(memberAccount);
		builder.append(", memberPassword=");
		builder.append(memberPassword);
		builder.append(", memberName=");
		builder.append(memberName);
		builder.append(", memberAuthority=");
		builder.append(memberAuthority);
		builder.append(", memberPhone=");
		builder.append(memberPhone);
		builder.append(", memberLineId=");
		builder.append(memberLineId);
		builder.append(", memberAddress=");
		builder.append(memberAddress);
		builder.append(", memberEmail=");
		builder.append(memberEmail);
		builder.append(", memberBirthday=");
		builder.append(memberBirthday);
		builder.append(", memberGender=");
		builder.append(memberGender);
		builder.append(", assistiveDeviceApplicationForm=");
		builder.append(assistiveDeviceApplicationForm);
		builder.append("]");
		return builder.toString();
	}





	public Integer getId() {
		return id;
	}



	public void setId(Integer id) {
		this.id = id;
	}



	public String getMemberAccount() {
		return memberAccount;
	}



	public void setMemberAccount(String memberAccount) {
		this.memberAccount = memberAccount;
	}



	public String getMemberPassword() {
		return memberPassword;
	}



	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}



	public String getMemberName() {
		return memberName;
	}



	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}



	public Integer getMemberPhone() {
		return memberPhone;
	}



	public void setMemberPhone(Integer phone) {
		this.memberPhone = phone;
	}



	public String getMemberLineId() {
		return memberLineId;
	}



	public void setMemberLineId(String memberLineId) {
		this.memberLineId = memberLineId;
	}



	public String getMemberAddress() {
		return memberAddress;
	}



	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}



	public String getMemberEmail() {
		return memberEmail;
	}



	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}



	public Date getMemberBirthday() {
		return memberBirthday;
	}



	public void setMemberBirthday(Date memberBirthday) {
		this.memberBirthday = memberBirthday;
	}



	public String getMemberGender() {
		return memberGender;
	}



	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}



	public String getMemberAuthority() {
		return memberAuthority;
	}



	public void setMemberAuthority(String memberAuthority) {
		this.memberAuthority = memberAuthority;
	}





	public Set<ShoppingCart> getShoppigCarts() {
		return ShoppigCarts;
	}





	public void setShoppigCarts(Set<ShoppingCart> shoppigCarts) {
		ShoppigCarts = shoppigCarts;
	}
	
	
	

}
