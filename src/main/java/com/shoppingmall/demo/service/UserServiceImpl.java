package com.shoppingmall.demo.service;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	@Autowired 
	UserMapper usermapper;
	
	@Override
	public Collection<GrantedAuthority> getAuthorities(String uId) {
		List<GrantedAuthority> authorities = usermapper.readAuthorities(uId);
		return authorities;
	}
	
	@Override
	public UserDetails loadUserByUsername(String uId) throws UsernameNotFoundException {
		Users user = usermapper.readUser(uId);
		user.setAuthorities(getAuthorities(uId));
		
		return user;
	}
	
	@Override
	public void insertUser(Users user) {
		usermapper.insertUser(user);
	}
	
	@Override
	public void createAuthority(Users user) {
		usermapper.createAuthority(user);
	}
	
	@Override
	public Users readUser(String uId) {
		return usermapper.readUser(uId);
	}
	
	@Override
	public List<Users> selectUserList(Pagination pagination) {
		return usermapper.selectUserList(pagination);
	}
	
	@Override
	public int countUsers() {
		return usermapper.countUsers();
	}
}
