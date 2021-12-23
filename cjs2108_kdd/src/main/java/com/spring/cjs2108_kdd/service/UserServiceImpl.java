package com.spring.cjs2108_kdd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_kdd.dao.UserDAO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;

	@Override
	public UserVO getUserVO(Integer idx) {
		return userDAO.getUserVO(idx);
	}

	@Override
	public int idCheck(String userId) {
		return userDAO.idCheck(userId);
	}

	@Override
	public void setSignup(UserVO vo) {
		userDAO.setSignup(vo);
	}

	@Override
	public Integer getIdx(String userId) {
		return userDAO.getIdx(userId);
	}

	@Override
	public void setWithdrawal(Integer idx) {
		userDAO.setWithdrawal(idx);
	}

	@Override
	public void setuserUpdate(Integer idx, UserVO vo) {
		userDAO.setuserUpdate(idx, vo);
	}

	@Override
	public void setUpdatePwd(String pwd, Integer idx) {
		userDAO.setUpdatePwd(pwd, idx);
	}

	@Override
	public void setMembership(Integer idx) {
		userDAO.setMembership(idx);
	}

	@Override
	public String getNextMembershipDate(Integer idx) {
		return userDAO.getNextMembershipDate(idx);
	}

	@Override
	public String getUserId(String userNm, String phoneNb, String email) {
		return userDAO.getUserId(userNm, phoneNb, email);
	}

	@Override
	public List<UserVO> getUserVOS() {
		return userDAO.getUserVOS();
	}

}
