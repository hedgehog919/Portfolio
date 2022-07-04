package com.jerryboot.springbootdemo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.dao.MemberDao;
import com.jerryboot.springbootdemo.model.Employee;
import com.jerryboot.springbootdemo.model.Member;


@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberDao dao;
	
	public List<Member> getAllMember() {
		return dao.findAll();
	}
	
	public static void saveMember(Member newRegister) {
		// TODO Auto-generated method stub
		
	}
//// -------------------------- 前台  //---------------------------------	
	
	// 登入成功
		public List<Member> checkLogin (String loginAccount, String loginPassword) {
			List<Member> login = dao.findByNameAndPassword(loginAccount, loginPassword);
			
			
			
			
			if(login!=null) {
				return login;
			}
			
			return null;
		}
		
		// 註冊成功
		public List<Member> checkAdd (String loginAccount, String loginPassword) {
			List<Member> login = dao.findByNameAndPassword(loginAccount, loginPassword);
			
			
			
			
			if(login!=null) {
				return login;
			}
			
			return null;
		}
		public Page<Member> findByPage2(Integer pageNumber){
			PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
			Page<Member> page = dao.findAll(pgb);
			
			return page;
		}

		public Member addMember2(Member mem) {
			return dao.save(mem);
		}
	
	
	
	
	
	

//////////////////////////////// 後台 ///////////////////////////	

	public Member addMember(Member mem) {
		return dao.save(mem);
	}
	
	public Page<Member> findByPage(Integer pageNumber){
		PageRequest pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC,"id");
		Page<Member> page = dao.findAll(pgb);
		
		return page;
	}
	
	
	public Member searchMemberById(Integer id){
		Optional<Member> findById = dao.findById(id);
	
		if(findById.isPresent()==true) {
			Member member = findById.get();
			return member;
		}else {
			return null;
		}
		
	}
	//AJAX用
			public Member finByAccount(String account) {
				Member memberAccount = dao.findMemberByAccount(account);
				
				if(memberAccount!=null) {
					return memberAccount;
				}
				
				return null;
			}


	
	
}
