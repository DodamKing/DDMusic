package com.spring.cjs2108_kdd.service;

import java.util.ArrayList;

import com.spring.cjs2108_kdd.vo.CommentVO;
import com.spring.cjs2108_kdd.vo.ReviewVO;

public interface ReviewService {

	void setReviewData(ReviewVO vo);

	ArrayList<ReviewVO> getReviewData();

	ReviewVO getReview(int idx);

	void setReviewDel(int idx);

	int getreviewCnt(String kategorie);

	ArrayList<ReviewVO> getReviewVOS(int startNo, int pageSize, String kategorie);

	ReviewVO getReviewVO(int idx);

	void setReviewUpdate(ReviewVO vo);

	void setLikeCnt(int idx);

	ArrayList<ReviewVO> getSrchResult(String reviewsrch, String srchClass, int startNo, int pageSize, String kategorie);

	int getSrchResultCnt(String srchClass, String reviewsrch, String kategorie);

	void setComment(CommentVO vo);

	ArrayList<CommentVO> getComment(int idx);

	void setCommentDel(int idx);

	void setCommentUpdate(int idx, String content);
	
}
