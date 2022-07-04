package com.jerryboot.springbootdemo.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CommoditiesRepository extends JpaRepository<Commodities, Integer>{
	
	@Query("from Commodities where commodityName = :Name")
	public Commodities findCommoditiesByName(@Param("Name") String name);

}
