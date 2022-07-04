package com.jerryboot.springbootdemo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.boot.context.properties.bind.DefaultValue;

import net.bytebuddy.implementation.bind.annotation.Default;

@Entity
@Table(name="newsMessage")
public class NewsMessage {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	
	@Column(name="title", columnDefinition = "nvarchar(50)")
	private String title;
	
	@Column(name="category", columnDefinition = "nvarchar(50)")
	private String category;
	
	@Column(name="text", columnDefinition = "nvarchar(max)")
	private String text;
	
	@Column(name="views", columnDefinition = "int default 0")
	private int views;
	
	@Column(name="image", columnDefinition = "varbinary(max)")
	private byte[] image;
	
	@Column(name="status", columnDefinition = "bit default 1")
	private boolean status;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="date")
	private Date date;

	
	@PrePersist
	@PreUpdate
	public void onCreate() {
		if (date == null) {
			this.date = new Date();
			System.out.println(date);
		}
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	
	

	
}
