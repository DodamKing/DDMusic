package com.spring.cjs2108_kdd.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_kdd.dao.ReviewDAO;
import com.spring.cjs2108_kdd.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public void setReviewData(ReviewVO vo) {
		reviewDAO.setReviewData(vo);
	}

	@Override
	public ArrayList<ReviewVO> getReviewData() {
		return reviewDAO.getReviewData();
	}
	
	
}
