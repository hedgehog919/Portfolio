package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jerryboot.springbootdemo.dao.MessageDao;
import com.jerryboot.springbootdemo.model.AssistiveDevice;
import com.jerryboot.springbootdemo.model.Message;

@Service
@Transactional
public class MessageService {

	@Autowired
	private MessageDao dao;

	public void save(Message ad) {
		dao.save(ad);
	}

	public List<Message> findAllMessge() {
		List<Message> findAll = dao.findAll();
		return findAll;
	}

	public Message findById(Integer id) {
		Optional<Message> option = dao.findById(id);
		if (option.isPresent()) {
			Message ad = option.get();
			return ad;
		}
		return null;
	}
	
	public Page<Message> findByPage(Integer pageNumber){
		Pageable pgb = PageRequest.of(pageNumber-1, 3,Sort.Direction.DESC, "adddate");
		Page<Message> page = dao.findAll(pgb);
		return page;
	}

	public void delete(Integer id) {
		dao.deleteById(id);
	}
	
	public Message findLatestMsg() {
		return dao.findFirstByOrderByAddedDesc();
	}

	public Message getFirstNewMsg() {
		return dao.findFirstByOrderByAddedDesc();
	}
}
