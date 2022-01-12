package com.spring.cjs2108_kdd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.vo.SongVO;

@Controller
public class DDMusic {
	@Autowired
	SongService songService;
	
	@RequestMapping(value={"/"})
	public String mainPage(Model model) {
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
	public String mainGet(Model model, @PathVariable String flag, String srchKwd, String idx) throws FileNotFoundException, IOException, ParseException {
		if (flag.equals("chart")) {
			ArrayList<SongVO> vos = songService.getChartJson();
			model.addAttribute("vos", vos);
		}
		
		else if (flag.equals("srch")) {
			model.addAttribute("srchKwd", srchKwd);
			model.addAttribute("vos", songService.getSongSrch(srchKwd));
		}
		
		else if (flag.equals("infor")) {
			SongVO vo = songService.getSongInfor(Integer.parseInt(idx));
			if (vo != null) vo.setImg(vo.getImg().replaceFirst("50", "300"));
			model.addAttribute("vo", vo);
		}
		
		else if (flag.equals("rank")) {
			ArrayList<SongVO> vos = songService.getRank();
			Method method = new Method();
			vos.get(0).setImg(method.getImgSize(vos.get(0).getImg(), "300"));
			vos.get(1).setImg(method.getImgSize(vos.get(1).getImg(), "200"));
			vos.get(2).setImg(method.getImgSize(vos.get(2).getImg(), "200"));
			model.addAttribute("vos", vos);
		}
		
		model.addAttribute("flag", flag);
		return "main/main";
	}
	
//	@RequestMapping(value="/{flag}", method = RequestMethod.POST)
//	@ResponseBody
//	public void mainPost(Model model, @PathVariable String flag, String srchKwd) {
//		if (flag.equals("srch")) {
//			model.addAttribute("srchKwd", srchKwd);
//			model.addAttribute("vos", songService.getSongSrch(srchKwd));
//		}
//		model.addAttribute("flag", flag);
//	}
}
