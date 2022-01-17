package com.spring.cjs2108_kdd.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kdd.method.RandomPwd;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder; 
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping("/login")
	public String loginGet(Model model, String flag) {
		model.addAttribute("flag", flag);
		return "user/login";
	}

	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String loginPost(HttpSession session, String userId, String pwd, String flag) {
		Integer idx = userService.getIdx(userId);
		session.setAttribute("sMid_", userId);
		UserVO vo = userService.getUserVO(idx);
		if (idx != null && vo.getWithdrawal() != 1) {
			if (!bCryptPasswordEncoder.matches(pwd, vo.getPwd())) {
				return "redirect:/message/pwdFalse";
			}
			session.setAttribute("sMid", vo.getUserId());
			session.setAttribute("sVO", vo);
			if (flag != null) {
				if (flag.equals("write")) return "redirect:/review/write";
			}
			return "redirect:/index";
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
		return "redirect:/today";
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
	
	@RequestMapping("/imgupdate/{idx}")
	public String imgupdateGet(Model model, @PathVariable Integer idx) {
		UserVO vo = userService.getUserVO(idx);
		model.addAttribute("vo", vo);
		return "user/imgupdate";
	}

	@RequestMapping(value="/imgupdate/{idx}", method = RequestMethod.POST)
	public String imgupdatePost(@PathVariable Integer idx, MultipartFile imgUpdate) throws IOException {
		userService.setImgUpdate(idx, imgUpdate);
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
		return userService.getUserId(userNm, phoneNb, email);
	}

	@RequestMapping("/finduserPwd")
	@ResponseBody
	public String finduserPwdPost(String userId, String email) throws MessagingException {
		Integer idx = userService.getIdx(userId);
		UserVO vo = userService.getUserVO(idx);
		if (idx != null && vo.getWithdrawal() != 1) {
			if (vo.getEmail().endsWith(email)) {
				String pwd_ = new RandomPwd().getRanPwd(8);
				String pwd = bCryptPasswordEncoder.encode(pwd_);
				userService.setUpdatePwd(pwd, idx);
				
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				
				String title = "안녕하세요 DDMusic 입니다.";
				helper.setTo(email);
				helper.setSubject(title);
				
				String content = "<div style='font-size: 150%;'><b>DDMusic</b>을 이용해 주셔셔 감사합니다.<br><br>'" + vo.getUserNm() + "'님의 임시 비밀번호 입니다. <br><br><hr>";
				content += "<p style='font-size: 200%; text-align: center;'>" + pwd_ + "</p>";
				content += "<hr><br>로그인 하셔서 비밀번호를 꼭 변경해 주세요!";
				content += "<br><br><a href='http://218.236.203.156:9090/cjs2108_kdd'>DDmusic 바로가기</a></div>";
				content += "<p><img src='cid:13.png'></p>";
				helper.setText(content, true);
				
				HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
				String path = request.getSession().getServletContext().getRealPath("resources/img/13.png");
				
				FileSystemResource file = new FileSystemResource(path);
				helper.addInline("13.png", file);
				
				mailSender.send(message);
				
				return "1";
			}
			return "2";
		}
		return "0";
	}
		
	@RequestMapping("/playlist")
	public String playlistGet() {
		return "user/playlist";
	}
	
}

