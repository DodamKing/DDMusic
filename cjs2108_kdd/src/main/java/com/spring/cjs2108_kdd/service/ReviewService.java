package com.spring.cjs2108_kdd.service;

import java.util.ArrayList;

import com.spring.cjs2108_kdd.vo.ReviewVO;

public interface ReviewService {

	void setReviewData(ReviewVO vo);

	ArrayList<ReviewVO> getReviewData();
	
}
