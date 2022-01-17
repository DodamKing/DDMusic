package com.spring.cjs2108_kdd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.cjs2108_kdd.service.ReviewService;
import com.spring.cjs2108_kdd.vo.ReviewVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/list")
	public String reviewlistGet(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
		int pageSize = 10;
		int startNo = (pageNo - 1) * pageSize;
		int totalCnt = reviewService.getreviewCnt();
		int start = totalCnt - (pageSize * (pageNo - 1));
		int lastPageNo = totalCnt / pageSize + 1;
		if (reviewService.getreviewCnt() % 10 == 0) lastPageNo--;
		model.addAttribute("vos", reviewService.getReviewVOS(startNo, pageSize));
		model.addAttribute("lastPageNo", lastPageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("start", start);
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
		reviewService.setReviewData(vo);
		return "redirect:/message/writesuccess";
	}
	
	@RequestMapping("/{idx}")
	public String reviewGet(Model model, @PathVariable int idx, HttpSession session) {
		if (session.getAttribute("likeSw" + idx) == null) {
			reviewService.setLikeCnt(idx);
		}
		session.setAttribute("likeSw" + idx, "1");
		model.addAttribute("vo", reviewService.getReview(idx));
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
		int totalCnt = reviewService.getSrchResultCnt(srchClass, reviewsrch);
		int start = totalCnt - (pageSize * (pageNo - 1));
		int lastPageNo = totalCnt / pageSize + 1;
		if (reviewService.getreviewCnt() % 10 == 0) lastPageNo--;
		model.addAttribute("vos", reviewService.getSrchResult(reviewsrch, srchClass, startNo, pageSize));
		model.addAttribute("lastPageNo", lastPageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("start", start);
		model.addAttribute("reviewsrch", reviewsrch);
		model.addAttribute("kategorie", kategorie);
		model.addAttribute("srchClass", srchClass);
		return "review/reviewsrch";
	}
	
}
