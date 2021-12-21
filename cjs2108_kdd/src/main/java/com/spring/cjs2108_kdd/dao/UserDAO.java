package com.spring.cjs2108_kdd.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kdd.vo.UserVO;

public interface UserDAO {

	UserVO getUserVO(@Param("userId") String userId, @Param("pwd") String pwd);

}
