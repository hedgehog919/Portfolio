package com.jerryboot.springbootdemo.model;

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

@Entity
@Table(name="assistive_device_application_form")
public class AssistiveDeviceApplicationForm {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="assistive_device_application_form_id")
	private Integer id;
	@Column(name="assistive_device_application_form_username",columnDefinition = "nvarchar(20)",nullable = false)
	private String userName;
	@Column(name="assistive_device_application_form_userage",columnDefinition = "tinyint",nullable = false)
	private Integer userAge;
	@Column(name="assistive_device_application_form_livingarea",columnDefinition = "nvarchar(50)",nullable = false)
	private String livingArea;
	
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="fk_member_id")
	private Member member;
	
	
	
	public AssistiveDeviceApplicationForm() {
	}
	
	


	@Override
	public String toString() {
		return "AssistiveDeviceApplicationForm [id=" + id + ", userName=" + userName + ", userAge=" + userAge
				+ ", livingArea=" + livingArea + "]";
	}



	
	











	public Member getMember() {
		return member;
	}




	public void setMember(Member member) {
		this.member = member;
	}




	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public Integer getUserAge() {
		return userAge;
	}


	public void setUserAge(Integer userAge) {
		this.userAge = userAge;
	}


	public String getLivingArea() {
		return livingArea;
	}


	public void setLivingArea(String livingArea) {
		this.livingArea = livingArea;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
