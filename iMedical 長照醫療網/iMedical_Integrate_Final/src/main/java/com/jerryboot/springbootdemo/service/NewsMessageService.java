package com.jerryboot.springbootdemo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.dao.NewsMessageDao;
import com.jerryboot.springbootdemo.dto.NewsMessageDto;
import com.jerryboot.springbootdemo.model.NewsInfoPage;
import com.jerryboot.springbootdemo.model.NewsMessage;

@Service
@Transactional
public class NewsMessageService {
	
	@Autowired
	private NewsMessageDao newsMessageDao; 
	
	public NewsInfoPage findNewsByCategoryAndStatusDateDesc(String category, int perPageAmount ,int currPage) {
		int offsetPages = perPageAmount * (currPage - 1);
		List<NewsMessage> newsMsgList = newsMessageDao.getNewsByCategoryAndStatusAndDateDesc(category, offsetPages, perPageAmount);
		Integer totalMsgNum = newsMessageDao.getTotalMsgAmountByStatusAndCategory(category);
		Integer totalPage = (int)Math.ceil(totalMsgNum * 1.0 / perPageAmount);
		
		return new NewsInfoPage(newsMsgList, totalMsgNum, totalPage, currPage);
		
	}
	
	public NewsInfoPage findPageMsgByStatusAndDateDesc(int perPageAmount ,int currPage) {
		int offsetPages = perPageAmount * (currPage - 1);
		List<NewsMessage> newsMsgList = newsMessageDao.getPageMsgByStatusAndDateDesc(offsetPages, perPageAmount);
		Integer totalMsgNum = newsMessageDao.getTotalMsgAmountByStatus();
		Integer totalPage = (int)Math.ceil(totalMsgNum * 1.0 / perPageAmount);
		
		return new NewsInfoPage(newsMsgList, totalMsgNum, totalPage, currPage);
	}
	
	public NewsInfoPage findPageMsgBySortType(String style, String searchText, int perPageAmount ,int currPage) {
		int offsetPages = perPageAmount * (currPage - 1);
		List<NewsMessage> newsMsgList = null;
		
		if ("date_desc".equals(style)) {
			newsMsgList = newsMessageDao.getPageNewsOrderByDateDesc(searchText, offsetPages, perPageAmount);
		} else if ("date_asc".equals(style)) {
			newsMsgList = newsMessageDao.getPageNewsOrderByDateAsc(searchText, offsetPages, perPageAmount);
		} else if ("views_desc".equals(style)) {
			newsMsgList = newsMessageDao.getPageNewsOrderByViewsDesc(searchText, offsetPages, perPageAmount);
		} else if ("views_asc".equals(style)){
			newsMsgList = newsMessageDao.getPageNewsOrderByViewsAsc(searchText, offsetPages, perPageAmount);
		}
		
		Integer totalMsgNum = newsMessageDao.getTotalMsgAmountBySearchInfo(searchText);
		Integer totalPage = (int)Math.ceil(totalMsgNum * 1.0 / perPageAmount );
		
		return new NewsInfoPage(newsMsgList, totalMsgNum, totalPage, currPage);
	}
	
	public NewsInfoPage findPageMsgBySearchInfo(String searchInfo, int perPageAmount ,int currPage) {
		int offsetPages = perPageAmount * (currPage - 1);
		List<NewsMessage> newsMsgList = newsMessageDao.getPageNewsBySearchInfo(searchInfo, offsetPages, perPageAmount);
		Integer totalMsgNum = newsMessageDao.getTotalMsgAmountBySearchInfo(searchInfo);
		Integer totalPage = (int)Math.ceil(totalMsgNum * 1.0 / perPageAmount);

		return new NewsInfoPage(newsMsgList, totalMsgNum, totalPage, currPage);
	}
	
	public NewsMessage findNewsMsgById(Integer id) {
		return newsMessageDao.getNewsMsgById(id);
	}
	
	public NewsInfoPage findPageMsgByNewsMsgDto(NewsMessageDto newsMsgDto, int perPageAmount) {
		int currPage = newsMsgDto.getPage();
		int offsetPages = perPageAmount * (currPage - 1);
		String sortType = newsMsgDto.getSortType();
		String keyWord = newsMsgDto.getKeyWord() == null ? "%%%" : "%" + newsMsgDto.getKeyWord() + "%";
		
		List<NewsMessage> newsMsgList = null;
		
		 if ("date_desc".equals(sortType)) {
			newsMsgList = newsMessageDao.getPageNewsOrderByDateDesc(keyWord, offsetPages, perPageAmount);
		} else if ("date_asc".equals(sortType)) {
			newsMsgList = newsMessageDao.getPageNewsOrderByDateAsc(keyWord, offsetPages, perPageAmount);
		} else if ("views_desc".equals(sortType)) {
			newsMsgList = newsMessageDao.getPageNewsOrderByViewsDesc(keyWord, offsetPages, perPageAmount);
		} else if ("views_asc".equals(sortType)){
			newsMsgList = newsMessageDao.getPageNewsOrderByViewsAsc(keyWord, offsetPages, perPageAmount);
		}
		
		
		Integer totalMsgNum = newsMessageDao.getTotalMsgAmountBySearchInfo(keyWord);
		Integer totalPage = (int)Math.ceil(totalMsgNum * 1.0 / perPageAmount );
				
		return new NewsInfoPage(newsMsgList, totalMsgNum, totalPage, currPage);
	}
	
	public void save(NewsMessage newsMsg) {
		newsMessageDao.save(newsMsg);
	}
	
	public void deleteNewsMsgById(Integer id) {
		newsMessageDao.deleteNewsMessageById(id);
	}
}
