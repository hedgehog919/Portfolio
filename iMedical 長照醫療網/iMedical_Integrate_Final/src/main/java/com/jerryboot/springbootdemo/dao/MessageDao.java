package com.jerryboot.springbootdemo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.jerryboot.springbootdemo.model.Message;

public interface MessageDao extends JpaRepository<Message, Integer> {

	@Query(value="select TOP(1) * from message order by added desc", nativeQuery = true)
	public Message findFirstByOrderByAddedDesc();
}
