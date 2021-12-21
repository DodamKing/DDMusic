package com.spring.cjs2108_kdd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_kdd.dao.UserDAO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;

	@Override
	public UserVO getUserVO(String userId, String pwd) {
		return userDAO.getUserVO(userId, pwd);
	}
}
