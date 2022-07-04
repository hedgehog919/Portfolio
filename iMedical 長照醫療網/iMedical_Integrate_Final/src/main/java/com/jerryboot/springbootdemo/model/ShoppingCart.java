package com.jerryboot.springbootdemo.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "ShoppingCart")
public class ShoppingCart {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "shoppingCartId")
	private Integer shoppingCartId;
	
	@Column(name = "memberId")
	private Integer memberId;

//總數量
	@Column(name = "shoppingCartList")
	private String shoppingCartList;
	
//	產生時間
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "shoppingCartDate", columnDefinition = "datetime")
	private Date shoppingCartDate;
	
//	備註
	@Column(name = "remark")
	private String remark;
//	轉換到Persist狀態前 新增時間
	public void dateCreate() {
		if(shoppingCartDate == null) {
			shoppingCartDate = new Date();
		}
	}
	
	/*
	 * 關聯會員
	 * 多方對一
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_member_id")
	private Member member;
	
	
//	多對多_主要的
//	cascade 是否連動
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
//	name = 要合併的名稱, 
//	joinColumns 連過去的自己的, 自己的pkKey
//	inverseJoinColumns 對面連過去, 對面的pkKey
//	並且對面要加mappedBy
	@JoinTable(name = "shoopingCart_commodities", 
	joinColumns = {@JoinColumn(name = "fk_shoppingCart_id", referencedColumnName = "shoppingCartId")},
	inverseJoinColumns = {@JoinColumn(name = "fk_commodities_Id", referencedColumnName = "commodityId")})
	private Set<Commodities> commodities = new HashSet<Commodities>();
//
	public ShoppingCart(Integer shoppingCartId, Integer memberId, String shoppingCartList, Date shoppingCartDate,
		String remark) {
	super();
	this.shoppingCartId = shoppingCartId;
	this.memberId = memberId;
	this.shoppingCartList = shoppingCartList;
	this.shoppingCartDate = shoppingCartDate;
	this.remark = remark;
}
	public ShoppingCart() {
		// TODO Auto-generated constructor stub
	}
	public Integer getShoppingCartId() {
		return shoppingCartId;
	}
	public void setShoppingCartId(Integer shoppingCartId) {
		this.shoppingCartId = shoppingCartId;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getShoppingCartList() {
		return shoppingCartList;
	}
	public void setShoppingCartList(String shoppingCartList) {
		this.shoppingCartList = shoppingCartList;
	}
	public Date getShoppingCartDate() {
		return shoppingCartDate;
	}
	public void setShoppingCartDate(Date shoppingCartDate) {
		this.shoppingCartDate = shoppingCartDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public Set<Commodities> getCommodities() {
		return commodities;
	}
	public void setCommodities(Set<Commodities> commodities) {
		this.commodities = commodities;
	}
	
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "ShoppingCart [shoppingCartId=" + shoppingCartId + ", memberId=" + memberId
				+ ", shoppingCartTotalQuantity=" + shoppingCartList + ", shoppingCartDate=" + shoppingCartDate
				+ ", remark=" + remark + "]";
	}
	
}
