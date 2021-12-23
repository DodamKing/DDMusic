package com.spring.cjs2108_kdd.controller;

import java.io.FileNotFoundException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	SongService songservice;
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/main")
	public String mainGet(Model model, 
			@RequestParam(value = "sw", defaultValue = "0") int sw, 
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo) 
					throws FileNotFoundException {
		if (sw == 0) {
			model.addAttribute("vos", songservice.getChartJson());
		}
		
		else if (sw == 1) {
			model.addAttribute("vos", userService.getUserVOS());
		}
		
		else if (sw == 2) {
			int pageSize = 10;
			int startNo = (pageNo - 1) * pageSize;
			int lastPageNo = songservice.getSongCnt() / 10 + 1;
			if (songservice.getSongCnt() % 10 == 0) lastPageNo--;
			model.addAttribute("vos", songservice.getSongVOS(startNo, pageSize));
			model.addAttribute("lastPageNo", lastPageNo);
			model.addAttribute("pageNo", pageNo);
		}
		
		model.addAttribute("sw", sw);
		return "admin/main";
	}

	@RequestMapping(value="/main", method = RequestMethod.POST)
	public String mainPost(Model model,
			HttpServletRequest request,
			@RequestParam(value = "sw", defaultValue = "0") int sw, 
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "item") String items) 
					throws FileNotFoundException {
			if (sw == 2) {
				if (items != null) {
					String[] item = items.split("/");
					for (int i=0; i<item.length; i++) {
						int idx = Integer.parseInt(item[i].split("_")[1]);
						String column = item[i].split("_")[0];
						String name = column + "_" + idx;
						String value = request.getParameter(name);
						
						songservice.setAdminSongUpdate(idx, column, value);
					}
				}
			}
		model.addAttribute("sw", sw);
		model.addAttribute("pageNo", pageNo);
		return "redirect:/admin/main";
	}
}
