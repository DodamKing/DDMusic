package com.spring.cjs2108_kdd.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kdd.method.RandomPwd;
import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.SongVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserService userService;

	@Autowired
	SongService songService;
	
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
	public String loginPost(HttpSession session, HttpServletResponse response, String userId, String pwd, String flag, String loginCheck) {
		Integer idx = userService.getIdx(userId);
		session.setAttribute("sMid_", userId);
		UserVO vo = userService.getUserVO(idx);
		if (idx != null && vo.getWithdrawal() != 1) {
			if (!bCryptPasswordEncoder.matches(pwd, vo.getPwd())) {
				return "redirect:/message/pwdFalse";
			}
			
			if (vo.getNextMembershipDate() != null) {
				if (vo.getNextMembershipDate().before(new Date(System.currentTimeMillis()))) {
					userService.setMemberShipReset(vo.getIdx());
				}
			}
			userService.setVisitDate(vo.getIdx());
			session.setAttribute("sMid", vo.getUserId());
			session.setAttribute("sVO", vo);
			
			if (loginCheck != null && loginCheck.equals("on")) {
				Cookie cookie = new Cookie("cIdx", Integer.toString(idx));
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
;			}
				
			if (flag != null) {
				if (flag.equals("write")) return "redirect:/review/write";
				if (flag.equals("myranking")) return "redirect:/myranking";
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
	public String logoutGet(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		session.invalidate();
		
		Cookie cookie = new Cookie("cIdx", null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		
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
	public String updatePost(HttpSession session, UserVO vo, @PathVariable Integer idx) {
		userService.setuserUpdate(idx, vo);
		session.setAttribute("sVO", userService.getUserVO(idx));
		return "redirect:/message/userupdatesuccess/" + idx;
	}
	
	@RequestMapping("/imgupdate/{idx}")
	public String imgupdateGet(Model model, @PathVariable Integer idx) {
		UserVO vo = userService.getUserVO(idx);
		model.addAttribute("vo", vo);
		return "user/imgupdate";
	}

	@RequestMapping(value="/imgupdate/{idx}", method = RequestMethod.POST)
	public String imgupdatePost(HttpSession session, @PathVariable Integer idx, MultipartFile imgUpdate) throws IOException {
		userService.setImgUpdate(idx, imgUpdate);
		session.setAttribute("sVO", userService.getUserVO(idx));
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
		model.addAttribute("vo", vo);
		return "user/membership";
	}

	@RequestMapping(value="/membership/{idx}", method = RequestMethod.POST)
	@ResponseBody
	public String membershiptPost(HttpSession session, @PathVariable Integer idx) {
		userService.setMembership(idx);
		session.setAttribute("sVO", userService.getUserVO(idx));
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
	public String playlistGet(HttpSession session, Model model) {
		UserVO vo = (UserVO) session.getAttribute("sVO");
		if (vo != null) {
			ArrayList<PlayListVO> vos = userService.getPlayListVOS(vo.getIdx());
			model.addAttribute("vos", vos);
		}
		return "user/playlist";
	}

	@RequestMapping("/playlist/{idx}")
	public String playlistOneGet(Model model, @PathVariable int idx) {
			PlayListVO listVO = userService.getPlayListVO(idx);
			ArrayList<SongVO> vos = new ArrayList<SongVO>();
			if (!listVO.getContent().equals("")) {
					String[] idx_list = listVO.getContent().split("/");
					
					for (int i=0; i<idx_list.length; i++) {
						SongVO vo = songService.getSongInfor(Integer.parseInt(idx_list[i]));
						vos.add(vo);
					}
			}
			model.addAttribute("vo", listVO);
			model.addAttribute("vos", vos);
		return "user/playlistone";
	}
	
	@RequestMapping("/savelist")
	@ResponseBody
	public void savelistPost(PlayListVO vo, String[] idx_list) {
		userService.setPlayList(vo);
	}
	
	@RequestMapping("/getlist")
	@ResponseBody
	public ArrayList<PlayListVO> getlistPost(HttpSession session) {
		UserVO vo = (UserVO) session.getAttribute("sVO");
		ArrayList<PlayListVO> vos = new ArrayList<PlayListVO>();
		if (vo != null) {
			vos = userService.getPlayListVOS(vo.getIdx());
		}
		return vos;
	}
	
	@RequestMapping("/addmylist")
	@ResponseBody
	public int addmylistPost(int idx, int songIdx) {
		if (userService.setAddMyList(idx, songIdx)) return 1;
		else return 0;
	}

	@RequestMapping("/addmylistmany")
	@ResponseBody
	public void addmylistmanyPost(int idx, String songIdxs) {
		userService.setAddMyListMany(idx, songIdxs);
	}

	@RequestMapping("/playlistdel")
	public String playlistdelGet(int idx) {
		userService.setPlayListDel(idx);
		return "redirect:/message/playlistdel";
	}

	@RequestMapping("/playlistdelsong")
	@ResponseBody
	public void playlistdelsongPost(int idx, int songIdx) {
		userService.setPlayListDelSong(idx, songIdx);
	}

	@RequestMapping("/playlistdelsongs")
	@ResponseBody
	public void playlistdelsongsPost(int idx, String songIdxs) {
		String[] idxs = songIdxs.split("/");
		for (int i=0; i<idxs.length; i++) {
			userService.setPlayListDelSong(idx, Integer.parseInt(idxs[i]));
		}
	}

	@RequestMapping("/dellist")
	@ResponseBody
	public void dellistPost(int idx, int songIdx) {
		userService.setPlayListDelSong(idx, songIdx);
	}

	@RequestMapping("playlistoneupdate")
	@ResponseBody
	public void playlistoneupdatePost(int idx, String listNm, String comment) {
		userService.setPlayListContentUpdate(idx, listNm, comment);
	}
	
	
}

