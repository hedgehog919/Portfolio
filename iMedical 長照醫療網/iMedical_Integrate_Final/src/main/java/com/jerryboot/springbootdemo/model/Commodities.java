package com.jerryboot.springbootdemo.model;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "commodities")
public class Commodities {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "commodityId")
	private Integer commodityId;
	
	@Column(name = "commodityName")
	private String commodityName;
	
	@Column(name = "commodityPhoto")
	private String commodityPhoto;
	
	@Column(name="commoditiesPhoto", columnDefinition = "varbinary(max)")
	private byte[] commoditiesPhoto;
	
	
	
	
//	@Lob
//	@Column(name = "byteCommodityPhoto")
//	private byte[] byteCommodityPhoto;
	
//	金額
	@Column(name = "amount")
	private Integer amount;
//	總金額
	@Column(name = "totalAmount")
	private Integer totalAmount;
//	總數量
	@Column(name = "totalQuantity")
	private Integer totalQuantity;
	
//	mappedBy = 對面的Set
	@ManyToMany(mappedBy = "commodities")
	private Set<ShoppingCart> shoppingCart = new HashSet<ShoppingCart>();

	public Integer getCommodityId() {
		return commodityId;
	}

	public void setCommodityId(Integer commodityId) {
		this.commodityId = commodityId;
	}

	public String getCommodityName() {
		return commodityName;
	}

	public void setCommodityName(String commodityName) {
		this.commodityName = commodityName;
	}

	public String getCommodityPhoto() {
		return commodityPhoto;
	}

	public void setCommodityPhoto(String commodityPhoto) {
		this.commodityPhoto = commodityPhoto;
	}

//	public byte[] getByteCommodityPhoto() {
//		return byteCommodityPhoto;
//	}
//
//	public void setByteCommodityPhoto(byte[] byteCommodityPhoto) {
//		this.byteCommodityPhoto = byteCommodityPhoto;
//	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Integer getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(Integer totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	
	

	public Set<ShoppingCart> getShoppingCart() {
		return shoppingCart;
	}

	public void setShoppingCart(Set<ShoppingCart> shoppingCart) {
		this.shoppingCart = shoppingCart;
	}

	
	
	
	
	
	
	public byte[] getCommoditiesPhoto() {
		return commoditiesPhoto;
	}

	public void setCommoditiesPhoto(byte[] commoditiesPhoto) {
		this.commoditiesPhoto = commoditiesPhoto;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Commodities [commodityId=");
		builder.append(commodityId);
		builder.append(", commodityName=");
		builder.append(commodityName);
		builder.append(", commodityPhoto=");
		builder.append(commodityPhoto);
		builder.append(", commoditiesPhoto=");
		builder.append(Arrays.toString(commoditiesPhoto));
		builder.append(", amount=");
		builder.append(amount);
		builder.append(", totalAmount=");
		builder.append(totalAmount);
		builder.append(", totalQuantity=");
		builder.append(totalQuantity);
		builder.append(", shoppingCart=");
		builder.append(shoppingCart);
		builder.append("]");
		return builder.toString();
	}


	



}
