package com.spring.cjs2108_kdd;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.vo.SongVO;

@Controller
public class DDchart {
	@Autowired
	SongService songService;
	
	@RequestMapping("/chart")
	public String chartGet(HttpServletRequest request, Model model) throws IOException, ParseException {
		
		ArrayList<SongVO> vos = songService.getChartJson();
		
		model.addAttribute("vos", vos);
		return "main/chart";
	}
}
