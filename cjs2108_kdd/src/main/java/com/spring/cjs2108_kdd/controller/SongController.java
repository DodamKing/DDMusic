package com.spring.cjs2108_kdd.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.vo.SongVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
@RequestMapping("/song")
public class SongController {
	@Autowired
	SongService songService;
	
//	@RequestMapping("/infor")
//	public String songinforGet(Model model, int idx) {
//		SongVO vo = songService.getSongInfor(idx);
//		if (vo != null) vo.setImg(vo.getImg().replaceFirst("50", "300"));
//		model.addAttribute("vo", vo);
//		return "song/songinfor";
//	}
	
	@RequestMapping("srch")
	@ResponseBody
	public ArrayList<SongVO> srchPost(Model model, String srchKwd) {
		return songService.getSongSrch(srchKwd);
	}
	
	@RequestMapping(value="/player", method = RequestMethod.GET)
	public String playerGet(HttpServletRequest request, HttpSession session, Model model, String idx, String idxs) {
		session.setAttribute("player", true);
		
		if (idx != null) {
			SongVO vo = songService.getSongInfor(Integer.parseInt(idx));
			Method method = new Method();
			model.addAttribute("vo", vo);
			model.addAttribute("img1000", method.getImgSize(vo.getImg(), "1000"));
			model.addAttribute("img2000", method.getImgSize(vo.getImg(), "2000"));
		}
		
		else if (idxs != null) {
			String[] idx_list = idxs.split("/");
			List<SongVO> vos = new ArrayList<SongVO>();
			Method method = new Method();
			
			for (int i=0; i<idx_list.length; i++) {
				SongVO vo = songService.getSongInfor(Integer.parseInt(idx_list[i]));
				if (vo.getIsFile() == 1) {
					vos.add(vo);
				}
			}
			model.addAttribute("vos", vos);
			model.addAttribute("img1000", method.getImgSize(vos.get(0).getImg(), "1000"));
			model.addAttribute("img2000", method.getImgSize(vos.get(0).getImg(), "2000"));
			
		}
		return "song/player"; 
	}
	
	@RequestMapping(value="/player", method = RequestMethod.POST)
	@ResponseBody
	public SongVO playerPost(int idx) {
		return songService.getSongInfor(idx);
	}

	@RequestMapping("randomPlay")
	@ResponseBody
	public SongVO randomPlayPost() {
		Integer idx = (int) (Math.random() * songService.getSongCnt()) + 260;
		return songService.getSongInfor(idx);
	}

	@RequestMapping("like")
	@ResponseBody
	public void likePost(int idx, HttpSession session) {
		songService.upLikeCnt(idx);
		songService.addLikeList(idx, (String) session.getAttribute("sMid"));
	}

	@RequestMapping("unlike")
	@ResponseBody
	public void unLikePost(int idx, HttpSession session) {
		songService.downLikeCnt(idx);
		songService.subLikeList(idx, (String) session.getAttribute("sMid"));
	}

	@RequestMapping("likebtn")
	@ResponseBody
	public String likebtnPost(int idx) {
		return songService.getLikeList(idx);
	}

	@RequestMapping(value = "lyrics", produces = "application/text; charset=utf-8")
	@ResponseBody
	public String lyricsPost(int idx) {
		return songService.getLyrics(idx);
	}
	
	@RequestMapping("playcntup")
	@ResponseBody
	public void playcntupPost(HttpSession session, int songIdx) {
		int userIdx = 0;
		UserVO vo = (UserVO) session.getAttribute("sVO");
		if (vo != null) userIdx = vo.getIdx();
		songService.setPlayCnt(songIdx, userIdx);
	}

	@RequestMapping("close")
	@ResponseBody
	public void clseosPost(HttpSession session) {
		session.removeAttribute("player");
		session.setAttribute("player", false);
	}
	
	@RequestMapping("/getchart")
	@ResponseBody
	public void getchartPost(Model model) throws FileNotFoundException, IOException, ParseException {
		ArrayList<SongVO> vos = songService.getChartJson();
		model.addAttribute("vos", vos);
	}
	
	@RequestMapping("/getaddsong")
	@ResponseBody
	public SongVO getaddsongPost(int idx) {
		return songService.getSongInfor(idx);
	}
	
}
