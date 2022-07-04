package com.jerryboot.springbootdemo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "message")
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "name" , columnDefinition = "nvarchar(20)")
	private String name;
	
	@Column(name = "message_content" , columnDefinition = "nvarchar(250)")
	private String message_content;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss") // 從資料庫取出後轉格式
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "added",columnDefinition = "datetime")
	private Date adddate;
	
	public Message() {
	}
	@PrePersist 
	public void onDate() {
		if(adddate== null) {
			adddate= new Date();
		}
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public Date getAdddate() {
		return adddate;
	}
	public void setAdddate(Date adddate) {
		this.adddate = adddate;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Message [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", message_content=");
		builder.append(message_content);
		builder.append(", adddate=");
		builder.append(adddate);
		builder.append("]");
		return builder.toString();
	}
	
	
}
