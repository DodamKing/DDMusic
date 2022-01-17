package com.spring.cjs2108_kdd.service;

import java.util.ArrayList;

import com.spring.cjs2108_kdd.vo.ReviewVO;

public interface ReviewService {

	void setReviewData(ReviewVO vo);

	ArrayList<ReviewVO> getReviewData();

	ReviewVO getReview(int idx);

	void setReviewDel(int idx);

	int getreviewCnt();

	ArrayList<ReviewVO> getReviewVOS(int startNo, int pageSize);

	ReviewVO getReviewVO(int idx);

	void setReviewUpdate(ReviewVO vo);

	void setLikeCnt(int idx);

	ArrayList<ReviewVO> getSrchResult(String reviewsrch, String srchClass, int startNo, int pageSize);

	int getSrchResultCnt(String srchClass, String reviewsrch);
	
}
