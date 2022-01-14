package com.spring.cjs2108_kdd.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kdd.vo.ReviewVO;

public interface ReviewDAO {

	public void setReviewData(@Param("vo") ReviewVO vo);

	public ArrayList<ReviewVO> getReviewData();
	
}
