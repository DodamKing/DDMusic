package com.spring.cjs2108_kdd.service;

import com.spring.cjs2108_kdd.vo.UserVO;

public interface UserService {

	UserVO getUserVO(Integer idx);

	int idCheck(String userId);

	void setSignup(UserVO vo);

	Integer getIdx(String userId);

	void setWithdrawal(Integer idx);

	void setuserUpdate(Integer idx, UserVO vo);

	void setUpdatePwd(String pwd, Integer idx);

	void setMembership(Integer idx);

	String getNextMembershipDate(Integer idx);

	String getUserId(String userNm, String phoneNb, String email);

}
