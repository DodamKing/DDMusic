package com.spring.cjs2108_kdd.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.vo.SongVO;

@Controller
@RequestMapping("/song")
public class SongController {
	@Autowired
	SongService songService;
	
	@RequestMapping("/infor")
	public String songinforGet(Model model, int idx) {
		SongVO vo = songService.getSongInfor(idx);
		if (vo != null) vo.setImg(vo.getImg().replaceFirst("50", "300"));
		model.addAttribute("vo", vo);
		return "song/songinfor";
	}
	
	@RequestMapping("srch")
	public String srchPost(Model model, String srchKwd) {
		model.addAttribute("srchKwd", srchKwd);
		model.addAttribute("vos", songService.getSongSrch(srchKwd));
		return "song/songsrch";
	}
	
	@RequestMapping("player")
	public String playerGet() {
		return "song/player";
	}

	@RequestMapping("randomPlay")
	@ResponseBody
	public SongVO randomPlayPost() {
		Integer idx = (int) (Math.random() * songService.getSongCnt()) + 260;
		return songService.getSongInfor(idx);
	}
	
}
