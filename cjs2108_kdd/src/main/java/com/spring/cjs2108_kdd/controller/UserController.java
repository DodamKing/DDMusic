package com.spring.cjs2108_kdd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserService userService;
	
	@RequestMapping("/login")
	public String loginGet() {
		
		return "user/login";
	}

	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String loginPost(HttpSession session, String userId, String pwd) {
		UserVO vo = userService.getUserVO(userId, pwd);
		if (vo == null) return "message/message";
		session.setAttribute("sVO", vo);
		session.setAttribute("sMid", vo.getUserId());
		return "main/main";
	}

	@RequestMapping("/signup")
	public String signupGet() {
		
		return "user/signup";
	}

	@RequestMapping("/logout")
	public String logoutGet(HttpSession session) {
		session.invalidate();
		return "main/main";
	}
}
