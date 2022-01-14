package com.spring.cjs2108_kdd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.cjs2108_kdd.service.ReviewService;

@Controller
@RequestMapping("/bbs")
public class ReviewController {
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/reviewdel")
	public String reviewdelGet(Model model, int idx) {
		reviewService.setReviewDel(idx);
		model.addAttribute("flag", "review");
		return "redirect:/review";
	}
	
}
