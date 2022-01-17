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

	@Override
	public ReviewVO getReview(int idx) {
		return reviewDAO.getReview(idx);
	}

	@Override
	public void setReviewDel(int idx) {
		reviewDAO.setReviewDel(idx);
	}

	@Override
	public int getreviewCnt() {
		return reviewDAO.getreviewCnt();
	}

	@Override
	public ArrayList<ReviewVO> getReviewVOS(int startNo, int pageSize) {
		return reviewDAO.getReviewVOS(startNo, pageSize);
	}

	@Override
	public ReviewVO getReviewVO(int idx) {
		return reviewDAO.getReviewVO(idx);
	}

	@Override
	public void setReviewUpdate(ReviewVO vo) {
		reviewDAO.setReviewUpdate(vo);
	}

	@Override
	public void setLikeCnt(int idx) {
		reviewDAO.setLikeCnt(idx);
	}

	@Override
	public ArrayList<ReviewVO> getSrchResult(String reviewsrch, String srchClass, int startNo, int pageSize) {
		return reviewDAO.getSrchResult(reviewsrch, srchClass, startNo, pageSize);
	}

	@Override
	public int getSrchResultCnt(String srchClass, String reviewsrch) {
		return reviewDAO.getSrchResultCnt(srchClass, reviewsrch);
	}
	
	
}
