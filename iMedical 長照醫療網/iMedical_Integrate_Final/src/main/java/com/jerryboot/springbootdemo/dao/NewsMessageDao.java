package com.jerryboot.springbootdemo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.jerryboot.springbootdemo.model.NewsMessage;

@Repository
public interface NewsMessageDao extends JpaRepository<NewsMessage, Integer> {
	
	/** 關鍵字搜尋 **/
	@Query(value = "select * from NewsMessage where title like :keyWord or text like :keyWord order by date desc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true )
	public List<NewsMessage> getPageNewsOrderByDateDesc(@Param("keyWord") String keyWord,@Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);

	@Query(value = "select * from NewsMessage where title like :keyWord or text like :keyWord order by date asc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true )
	public List<NewsMessage> getPageNewsOrderByDateAsc(@Param("keyWord") String keyWord, @Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);

	@Query(value = "select * from NewsMessage where title like :keyWord or text like :keyWord order by views desc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true )
	public List<NewsMessage> getPageNewsOrderByViewsDesc(@Param("keyWord") String keyWord, @Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);

	@Query(value = "select * from NewsMessage where title like :keyWord or text like :keyWord order by views asc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true )
	public List<NewsMessage> getPageNewsOrderByViewsAsc(@Param("keyWord") String keyWord, @Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);

	@Query(value = "select * from NewsMessage where title like :keyWord or text like :keyWord order by date desc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true )
	public List<NewsMessage> getPageNewsBySearchInfo(@Param("keyWord") String keyWord,@Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);
	
	@Query(value = "select count(*) from NewsMessage where title like :keyWord or text like :keyWord", nativeQuery = true )
	public Integer getTotalMsgAmountBySearchInfo(@Param("keyWord") String keyWord);
	
	
	
	@Query(value = "select * from NewsMessage where id = :id", nativeQuery = true )
	public NewsMessage getNewsMsgById(@Param("id") Integer id);
	
	
	@Query(value = "select * from NewsMessage where status = 1 order by date desc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true)
	public List<NewsMessage> getPageMsgByStatusAndDateDesc(@Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);
	
	@Query(value = "select * from NewsMessage where category = :category and status = 1 order by date desc offset :offsetRows rows fetch first :fetchRows rows only", nativeQuery = true)
	public List<NewsMessage> getNewsByCategoryAndStatusAndDateDesc(@Param("category") String category, @Param("offsetRows") int offsetRows, @Param("fetchRows") int fetchRows);
	
	@Query(value = "select count(*) from NewsMessage where category = :category and status = 1", nativeQuery = true)
	public Integer getTotalMsgAmountByStatusAndCategory(@Param("category") String category);
	
	
	@Query(value = "select count(*) from NewsMessage where status = 1", nativeQuery = true)
	public Integer getTotalMsgAmountByStatus();
	
	@Query(value = "delete from NewsMessage where id = :id", nativeQuery = true)
	@Modifying 
	public void deleteNewsMessageById(@Param("id") int id);
	
}
