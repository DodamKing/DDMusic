package com.spring.cjs2108_kdd.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kdd.vo.ReviewVO;

public interface ReviewDAO {

	public void setReviewData(@Param("vo") ReviewVO vo);

	public ArrayList<ReviewVO> getReviewData();

	public ReviewVO getReview(int idx);

	public void setReviewDel(int idx);

	public int getreviewCnt();

	public ArrayList<ReviewVO> getReviewVOS(@Param("startNo") int startNo, @Param("pageSize") int pageSize);

	public ReviewVO getReviewVO(int idx);

	public void setReviewUpdate(@Param("vo") ReviewVO vo);

	public void setLikeCnt(int idx);

	public ArrayList<ReviewVO> getSrchResult(@Param("reviewsrch") String reviewsrch, @Param("srchClass") String srchClass, @Param("startNo") int startNo, @Param("pageSize") int pageSize);

	public int getSrchResultCnt(@Param("srchClass") String srchClass, @Param("reviewsrch") String reviewsrch);
	
}
