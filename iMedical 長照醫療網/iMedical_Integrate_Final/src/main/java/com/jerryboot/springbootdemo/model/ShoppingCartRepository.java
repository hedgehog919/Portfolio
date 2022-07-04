package com.jerryboot.springbootdemo.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ShoppingCartRepository extends JpaRepository<ShoppingCart, Integer>{

//	@Query(value = "SELECT shoppingCartId FROM ShoppingCart", nativeQuery = true)
//	public List<ShoppingCart> findAllByShoppingCartId();
	
	public ShoppingCart findTopByOrderByShoppingCartIdDesc();
	
}
