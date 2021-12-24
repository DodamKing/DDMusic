package com.spring.cjs2108_kdd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/message")
public class MessageController {
	@RequestMapping("/signupsuccess")
	public String signupsuccessGet(Model model) {
		model.addAttribute("msg", "회원 가입 되었습니다.");
		model.addAttribute("url", "user/login");
		return "include/message";
	}

	@RequestMapping("/idFalse")
	public String idFalseGet(Model model) {
		model.addAttribute("msg", "아이디를 확인하세요.");
		model.addAttribute("url", "user/login");
		return "include/message";
	}

	@RequestMapping("/pwdFalse")
	public String pwdFalseGet(Model model) {
		model.addAttribute("msg", "비밀번호를 확인하세요.");
		model.addAttribute("url", "user/login");
		return "include/message";
	}
	
	@RequestMapping("/withdrawalsuccess")
	public String userdelsuccessGet(Model model) {
		model.addAttribute("msg", "탈퇴 되었습니다.");
		model.addAttribute("url", "today");
		return "include/message";
	}

	@RequestMapping("/userupdatesuccess/{idx}")
	public String userupdatesuccessGet(Model model, @PathVariable Integer idx) {
		model.addAttribute("msg", "수정 되었습니다.");
		model.addAttribute("url", "user/profile/" + idx);
		return "include/message";
	}

	@RequestMapping("/pwdchafalse/{idx}")
	public String pwdchafalseGet(Model model, @PathVariable Integer idx) {
		model.addAttribute("msg", "기존 비밀번호가 일치하지 않습니다.");
		model.addAttribute("url", "user/pwdcha/" + idx);
		return "include/message";
	}

	@RequestMapping("/pwdchasuccess/{idx}")
	public String successGet(Model model, @PathVariable Integer idx) {
		model.addAttribute("msg", "비밀번호가 변경 되었습니다.");
		model.addAttribute("url", "user/profile/" + idx);
		return "include/message";
	}
}
