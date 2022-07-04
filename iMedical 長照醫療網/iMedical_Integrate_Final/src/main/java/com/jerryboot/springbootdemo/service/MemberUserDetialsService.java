package com.jerryboot.springbootdemo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import java.util.Optional;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.jerryboot.springbootdemo.model.Member;

@Service
public class MemberUserDetialsService implements UserDetailsService {

	@Autowired
	private MemberService service;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		/*
		 * 帳號
		 * 密碼:以加密
		 * 權限與身分:自訂, ROLE_自訂  字串以逗號分開
		 * ex: admin, normal, ROLE_manage, ROLE_menber
		 */
		
		/*
		 * 步驟
		 * 1 從資料庫找帳號是否存在
		 * 2 若存在則取出並塞入User()
		 */
		
		Member menber = service.finByAccount(username);

		Optional<Member> option = Optional.of(service.finByAccount(username));
		
		if(!option.isPresent()) {
			throw new UsernameNotFoundException("Not found!");
		}
		return new User(username, menber.getMemberPassword(), AuthorityUtils.commaSeparatedStringToAuthorityList(menber.getMemberAuthority()));
//		
		///////////////////////////------測試用-------////////////////////////////////
		//應該從資料庫裡找有的
//		String uname = "aa";
//		String passwd = "11";//通常以加密
//		String authority = "";//權限與身分
////		Bean裡面增加權限
////		加密
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//		String BCpassword = passwordEncoder.encode(passwd);
//		///////////////////////////////////////////////////////////////////////////////////
//		
////		回傳User物件(帳號, 密碼, 規則)
//		return new User(uname, BCpassword, AuthorityUtils.createAuthorityList("menber"));
//		User(帳號, 密碼, 權限與身分)
//		User(username,
//			password, 
//			AuthorityUtils.commaSeparatedStringToAuthorityList(authority) )
		
	}
//	
//	
//
}
