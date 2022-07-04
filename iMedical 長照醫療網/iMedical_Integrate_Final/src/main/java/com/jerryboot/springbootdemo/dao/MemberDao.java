package com.jerryboot.springbootdemo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jerryboot.springbootdemo.model.Member;


@Repository
public interface MemberDao extends JpaRepository<Member, Integer>{
	
	
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	/////////////////// 以下是查詢功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	
	
	@Query("from Member")
	public List<Member> listAllMember(Member mem);
	
	@Query("from Member where memberName = :name")
	public List<Member> findMemberByName(@Param("name") String name);
	
	@Query("from Member where memberAccount = :account")
	public Member findMemberByAccount(@Param("account") String account);
		
	@Query("from Member where memberAccount=:account and memberPassword=:password ")
	public List<Member> findByNameAndPassword(@Param("account") String loginAccount, @Param("password") String loginPassword); 
	
	@Query(value="select * from members where members_account = :members_account", nativeQuery = true)
	public Member selectMemberByAccout(@Param("members_account") String password);
	
	
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	///////////////////以下是新增資料功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	///////////////////以下是刪除資料功能
	////////////////////////////////////////////////////
	////////////////////////////////////////////////////
	
	
	@Query(value="delete from member where member_name = ?1", nativeQuery = true)
	@Transactional
	@Modifying
	public void deleteMemberByName(String memberName);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
