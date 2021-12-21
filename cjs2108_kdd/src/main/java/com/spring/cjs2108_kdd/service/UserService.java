package com.spring.cjs2108_kdd.service;

import com.spring.cjs2108_kdd.vo.UserVO;

public interface UserService {

	UserVO getUserVO(String userId, String pwd);
	
}
