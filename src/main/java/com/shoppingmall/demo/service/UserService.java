package com.shoppingmall.demo.service;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.Users;

public interface UserService extends UserDetailsService {

	public Users readUser(String uId);
	
	public void insertUser(Users user);
	
	public Collection<GrantedAuthority> getAuthorities(String uId);
	
	public void createAuthority(Users user);
	
	public List<Users> selectUserList(Pagination pagination);
	
	public int countUsers();
}
