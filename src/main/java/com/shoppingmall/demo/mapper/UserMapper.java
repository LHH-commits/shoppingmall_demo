package com.shoppingmall.demo.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;

import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.Users;

@Mapper
public interface UserMapper {

	public Users readUser(String uId);
	
	public void insertUser(Users user);
	
	public List<GrantedAuthority> readAuthorities(String uId);
	
	public void createAuthority(Users user);
	
	public List<Users> selectUserList(Pagination pagination);
	
	public int countUsers();
}
