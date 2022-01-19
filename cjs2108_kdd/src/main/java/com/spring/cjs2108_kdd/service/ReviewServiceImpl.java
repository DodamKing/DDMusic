package com.spring.cjs2108_kdd.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_kdd.dao.ReviewDAO;
import com.spring.cjs2108_kdd.vo.CommentVO;
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
	public ArrayList<ReviewVO> getReviewVOS(int startNo, int pageSize, String kategorie) {
		ArrayList<ReviewVO> vos = reviewDAO.getReviewVOS(startNo, pageSize, kategorie);
		for (int i=0; i<vos.size(); i++) {
			vos.get(i).setCommentCnt(reviewDAO.getCommentCnt(vos.get(i).getIdx()));
		}
		return vos;
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
	public ArrayList<ReviewVO> getSrchResult(String reviewsrch, String srchClass, int startNo, int pageSize, String kategorie) {
		ArrayList<ReviewVO> vos = reviewDAO.getSrchResult(reviewsrch, srchClass, startNo, pageSize, kategorie);
		for (int i=0; i<vos.size(); i++) {
			vos.get(i).setCommentCnt(reviewDAO.getCommentCnt(vos.get(i).getIdx()));
		}
		return vos;
	}

	@Override
	public int getSrchResultCnt(String srchClass, String reviewsrch, String kategorie) {
		return reviewDAO.getSrchResultCnt(srchClass, reviewsrch, kategorie);
	}

	@Override
	public int getreviewCnt(String kategorie) {
		return reviewDAO.getreviewCnt(kategorie);
	}

	@Override
	public void setComment(CommentVO vo) {
		reviewDAO.setComment(vo);
	}

	@Override
	public ArrayList<CommentVO> getComment(int idx) {
		return reviewDAO.getComment(idx);
	}

	@Override
	public void setCommentDel(int idx) {
		reviewDAO.setCommentDel(idx);
	}

	@Override
	public void setCommentUpdate(int idx, String content) {
		reviewDAO.setCommentUpdate(idx, content);
	}
	
	
}
