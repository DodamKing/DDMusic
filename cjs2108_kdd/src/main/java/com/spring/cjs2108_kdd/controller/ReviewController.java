package com.spring.cjs2108_kdd.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.service.ReviewService;
import com.spring.cjs2108_kdd.vo.CommentVO;
import com.spring.cjs2108_kdd.vo.ReviewVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/list")
	public String reviewlistGet(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, String kategorie, String srchClass, String reviewsrch) {
		int pageSize = 10;
		int startNo = (pageNo - 1) * pageSize;
		int totalCnt = reviewService.getreviewCnt(kategorie);
		int start = totalCnt - (pageSize * (pageNo - 1));
		int lastPageNo = totalCnt / pageSize + 1;
		if (totalCnt % 10 == 0) lastPageNo--;
		model.addAttribute("vos", reviewService.getReviewVOS(startNo, pageSize, kategorie));
		model.addAttribute("lastPageNo", lastPageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("start", start);
		model.addAttribute("kategorie", kategorie);
		model.addAttribute("srchClass", srchClass);
		model.addAttribute("reviewsrch", reviewsrch);
		
		return "review/review";
	}
	
	@RequestMapping("/write")
	public String writeGet(HttpSession session) {
		if (session.getAttribute("sMid") == null) {
			return "redirect:/index";
		}
		return "review/write";
	}

	@RequestMapping(value="/write", method = RequestMethod.POST)
	public String writePost(ReviewVO vo) {
		if (vo.getTitle() == null || vo.getContent() ==null) {
			return "redirect:/message/reviewnoinput";
		}
		vo.setTitle(vo.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
		reviewService.setReviewData(vo);
		return "redirect:/message/writesuccess";
	}
	
	@RequestMapping("/{idx}")
	public String reviewGet(Model model, @PathVariable int idx, HttpSession session, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, String kategorie, String srchClass, String reviewsrch) {
		if (session.getAttribute("likeSw" + idx) == null) {
			reviewService.setLikeCnt(idx);
		}
		session.setAttribute("likeSw" + idx, "1");
		model.addAttribute("vo", reviewService.getReview(idx));
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("kategorie", kategorie);
		model.addAttribute("srchClass", srchClass);
		model.addAttribute("reviewsrch", reviewsrch);
		model.addAttribute("vos", reviewService.getComment(idx));
		return "review/content";
	}

	@RequestMapping("/reviewdel")
	public String reviewdelGet(int idx) {
		reviewService.setReviewDel(idx);
		return "redirect:/message/reviewdelsuccess";
	}

	@RequestMapping("/update")
	public String updateGet(Model model, int idx) {
		model.addAttribute("vo", reviewService.getReviewVO(idx));
		return "review/update";
	}

	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String updatePost(ReviewVO vo) {
		reviewService.setReviewUpdate(vo);
		return "redirect:/message/updatesuccess?idx=" + vo.getIdx();
	}
	
	@RequestMapping("/srch")
	public String srchGet(Model model, String reviewsrch, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, String kategorie, String srchClass) {
		int pageSize = 10;
		int startNo = (pageNo - 1) * pageSize;
		int totalCnt = reviewService.getSrchResultCnt(srchClass, reviewsrch, kategorie);
		int start = totalCnt - (pageSize * (pageNo - 1));
		int lastPageNo = totalCnt / pageSize + 1;
		if (totalCnt % 10 == 0) lastPageNo--;
		model.addAttribute("vos", reviewService.getSrchResult(reviewsrch, srchClass, startNo, pageSize, kategorie));
		model.addAttribute("lastPageNo", lastPageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("start", start);
		model.addAttribute("reviewsrch", reviewsrch);
		model.addAttribute("kategorie", kategorie);
		model.addAttribute("srchClass", srchClass);
		return "review/reviewsrch";
	}
	
	@RequestMapping("/comment")
	@ResponseBody
	public String commentPost(HttpSession session, CommentVO vo) {
		UserVO userVO = (UserVO) session.getAttribute("sVO");
		if (userVO == null) return "no";
		vo.setUserIdx(userVO.getIdx());
		vo.setContent(vo.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
		reviewService.setComment(vo);
		return "";
	}
	
	@RequestMapping("/commentdel")
	@ResponseBody
	public void commentdelPost(int idx) {
		reviewService.setCommentDel(idx);
	}

	@RequestMapping("/commentupdate")
	@ResponseBody
	public void commentupdatePost(int idx, String content) {
		content = content.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		reviewService.setCommentUpdate(idx, content);
	}
	
	@RequestMapping("/imageUpload")
	@ResponseBody
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, @RequestParam MultipartFile upload) {
		Method method = new Method();
		method.ckUpload(req, res, upload);
	}
	
	
}
