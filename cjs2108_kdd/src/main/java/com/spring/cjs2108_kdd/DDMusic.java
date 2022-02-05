package com.spring.cjs2108_kdd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.service.ReviewService;
import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.ChartVO;
import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.SongVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Controller
public class DDMusic {
	@Autowired SongService songService;
	
	@Autowired ReviewService reviewService;

	@Autowired UserService userService;
	
	@RequestMapping("/")
	public String mainPage(Model model, HttpServletRequest request, HttpSession session) {
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
			for (int i=0; i<cookies.length; i++) {
				String str = cookies[i].getName();
				if (str.equals("cIdx")) {
					UserVO vo = userService.getUserVO(Integer.parseInt(cookies[i].getValue()));
					if (vo != null) {
						session.setAttribute("sMid", vo.getUserId());
						session.setAttribute("sVO", vo);
					}
				}
			}
		}
		
		model.addAttribute("flag", "today");
		return "main/main";
	}
	
//	@RequestMapping("/chart")
//	public String chartGet(HttpServletRequest request, Model model) throws IOException, ParseException {
//		
//		ArrayList<SongVO> vos = songService.getChartJson();
//		
//		model.addAttribute("vos", vos);
//		return "main/chart";
//	}
	
	@RequestMapping("/{flag}")
	public String mainGet(Model model, HttpSession session , HttpServletRequest request, @PathVariable String flag, String srchKwd, String idx, String date) throws FileNotFoundException, IOException, ParseException {
		Method method = new Method();
		
		if (flag.equals("index")) {
			model.addAttribute("flag", "today");
			return "main/main";
		}

		else if (flag.equals("chart")) {
//			ArrayList<SongVO> vos = songService.getChartJson();
			ArrayList<ChartVO> vos = songService.getChartVOS(date);
			model.addAttribute("vos", vos);
			model.addAttribute("date", date);
			model.addAttribute("minDate", songService.getMinDate());
		}
		
		else if (flag.equals("srch")) {
			model.addAttribute("srchKwd", srchKwd);
			model.addAttribute("vos", songService.getSongSrch(srchKwd));
		}
		
		else if (flag.equals("infor")) {
			if (Integer.parseInt(idx) != 0) {
				SongVO vo = songService.getSongInfor(Integer.parseInt(idx));
				if (vo != null) vo.setImg(vo.getImg().replaceFirst("50", "300"));
				model.addAttribute("vo", vo);
			}
		}
		
		else if (flag.equals("rank")) {
			ArrayList<SongVO> vos = songService.getRank();
			vos.get(0).setImg(method.getImgSize(vos.get(0).getImg(), "300"));
			vos.get(1).setImg(method.getImgSize(vos.get(1).getImg(), "200"));
			vos.get(2).setImg(method.getImgSize(vos.get(2).getImg(), "200"));
			model.addAttribute("vos", vos);
		}
		
		else if (flag.equals("comming")) {
			ArrayList<SongVO> vos = songService.getUpdateSong();
			model.addAttribute("vos", vos);
		}

		else if (flag.equals("myranking")) {
			UserVO vo = (UserVO) session.getAttribute("sVO");
			if (vo != null) {
				ArrayList<SongVO> vos = songService.getMyRank(vo.getIdx());
				if (vos.size() > 0) vos.get(0).setImg(method.getImgSize(vos.get(0).getImg(), "300"));
				if (vos.size() > 1) vos.get(1).setImg(method.getImgSize(vos.get(1).getImg(), "300"));
				if (vos.size() > 2) vos.get(2).setImg(method.getImgSize(vos.get(2).getImg(), "300"));
				model.addAttribute("vos", vos);
			}
		}
		
		else if (flag.equals("mix")) {
			
		}

		else if (flag.equals("artisttape")) {
			UserVO vo = (UserVO) session.getAttribute("sVO");
			if (vo != null) {
				List<SongVO> vos = userService.getArtistTape(vo.getIdx());
				if (vos.size() > 0) {
					model.addAttribute("vos", vos);
					model.addAttribute("thum", method.getImgSize(vos.get(0).getImg(), "200"));
				}
			}
		}

		model.addAttribute("flag", flag);
		return "main/main";
	}
	
	@RequestMapping("/artist/{artist}")
	public String artistGet(Model model, @PathVariable String artist) {
		Method method = new Method();
		List<SongVO> vos = new ArrayList<SongVO>();
		artist = artist.replaceAll("\\^", "'");
		
		vos = songService.getSrchArtist(artist);
		
		model.addAttribute("thum", method.getImgSize(vos.get(0).getImg(), "200"));
		model.addAttribute("vos", vos);
		model.addAttribute("flag", "artist");
		return "main/main";
	}
	
}
