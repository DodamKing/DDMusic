package com.spring.cjs2108_kdd.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kdd.vo.UserVO;

public interface UserDAO {

	UserVO getUserVO(Integer idx);

	int idCheck(String userId);

	void setSignup(@Param("vo") UserVO vo);

	Integer getIdx(String userId);

	void setWithdrawal(Integer idx);

	void setuserUpdate(@Param("idx") Integer idx, @Param("vo") UserVO vo);

	void setUpdatePwd(@Param("pwd") String pwd, @Param("idx") Integer idx);

	void setMembership(Integer idx);

	String getNextMembershipDate(Integer idx);

	String getUserId(@Param("userNm") String userNm, @Param("phoneNb") String phoneNb,  @Param("email")String email);

}
