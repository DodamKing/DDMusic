package com.spring.cjs2108_kdd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder; 
	
	@RequestMapping("/login")
	public String loginGet(Model model) {
		return "user/login";
	}

	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String loginPost(HttpSession session, String userId, String pwd) {
		Integer idx = userService.getIdx(userId);
		session.setAttribute("sMid_", userId);
		UserVO vo = userService.getUserVO(idx);
		if (idx != null && vo.getWithdrawal() != 1) {
			if (!bCryptPasswordEncoder.matches(pwd, vo.getPwd())) {
				return "redirect:/message/pwdFalse";
			}
			session.setAttribute("sMid", vo.getUserId());
			session.setAttribute("sVO", vo);
			return "main/main";
		}
		return "redirect:/message/idFalse";
	}

	@RequestMapping("/signup")
	public String signupGet() {
		
		return "user/signup";
	}
	
	@RequestMapping("/overlapcheck")
	public String overlapcheckGet(Model model, String userId) {
		int res = userService.idCheck(userId);
		model.addAttribute("userId", userId);
		model.addAttribute("res", res);
		return "user/overlapcheck";
	}

	
	@RequestMapping(value="/signup", method = RequestMethod.POST)
	public String signupPost(UserVO vo) {
		vo.setPwd(bCryptPasswordEncoder.encode(vo.getPwd()));
		userService.setSignup(vo);
		return "redirect:/message/signupsuccess";
	}

	@RequestMapping("/logout")
	public String logoutGet(HttpSession session) {
		session.invalidate();
		return "main/main";
	}

	@RequestMapping("/profile/{idx}")
	public String profileGet(Model model, @PathVariable Integer idx) {
		UserVO vo = userService.getUserVO(idx);
		model.addAttribute("vo", vo);
		return "user/profile";
	}
	
	@RequestMapping("/withdrawal/{idx}")
	public String withdrawalGet(HttpSession session, @PathVariable Integer idx) {
		userService.setWithdrawal(idx);
		session.invalidate();
		return "redirect:/message/withdrawalsuccess";
	}

	@RequestMapping("/update/{idx}")
	public String updateGet(Model model, @PathVariable Integer idx) {
		UserVO vo = userService.getUserVO(idx);
		model.addAttribute("vo", vo);
		return "user/update";
	}

	@RequestMapping(value="/update/{idx}", method = RequestMethod.POST)
	public String updatePost(UserVO vo, @PathVariable Integer idx) {
		userService.setuserUpdate(idx, vo);
		return "redirect:/message/userupdatesuccess/" + idx;
	}
	
	@RequestMapping("/pwdcha/{idx}")
	public String pwdChangeGet(Model model, @PathVariable Integer idx) {
		model.addAttribute("idx", idx);
		return "user/pwdChange";
	}

	@RequestMapping(value="/pwdcha/{idx}", method = RequestMethod.POST)
	public String pwdChangePost(String pwd1, String pwd2, String pwd3, @PathVariable Integer idx) {
		if (!bCryptPasswordEncoder.matches(pwd1, userService.getUserVO(idx).getPwd())) {
			return "redirect:/message/pwdchafalse/" + idx;
		}
		String pwd = bCryptPasswordEncoder.encode(pwd2);
		userService.setUpdatePwd(pwd, idx);
		return "redirect:/message/pwdchasuccess/" + idx;
	}
	
	@RequestMapping("/membership/{idx}")
	public String membershiptGet(Model model, @PathVariable Integer idx) {
		UserVO vo = userService.getUserVO(idx);
		vo.setNextMembershipDate(userService.getNextMembershipDate(idx));
		model.addAttribute("vo", vo);
		return "user/membership";
	}

	@RequestMapping(value="/membership/{idx}", method = RequestMethod.POST)
	@ResponseBody
	public String membershiptPost(@PathVariable Integer idx) {
		userService.setMembership(idx);
		return "ok";
	}
	
	@RequestMapping("/finduserId")
	@ResponseBody
	public String finduserIdPost(String userNm, String phoneNb, String email) {
		String mid = userService.getUserId(userNm, phoneNb, email);
		return mid;
	}

	@RequestMapping("/finduserPwd")
	@ResponseBody
	public String finduserPwdPost(String userNm, String phoneNb, String email) {
		return "1";
	}
	
	
}
