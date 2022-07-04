package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.model.ShoppingCart;
import com.jerryboot.springbootdemo.model.ShoppingCartRepository;

@Service
@Transactional
public class ShoppingCartService {
	
	@Autowired
	private ShoppingCartRepository scDao;
	
	public void insert(ShoppingCart sc) {
		scDao.save(sc);
	}
	
	public ShoppingCart findById(Integer id) {
		Optional<ShoppingCart> option = scDao.findById(id);
		if(option.isPresent()){
			return option.get();
		}
		return null;
	}
//	不能用
//	public List<ShoppingCart> findAllShoppingCartId(){
//		return scDao.findAllByShoppingCartId();
//	}
	
	public List<ShoppingCart> findAllShoppingCart(){
		return scDao.findAll();
	}
	
	public ShoppingCart findLastId() {
		return scDao.findTopByOrderByShoppingCartIdDesc();
	}
	
	public void deleteById(Integer id) {
		scDao.deleteById(id);
	}

}
