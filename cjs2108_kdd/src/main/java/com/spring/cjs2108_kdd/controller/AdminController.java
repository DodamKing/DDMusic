package com.spring.cjs2108_kdd.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kdd.dao.SongDAO;
import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.ChartVO;
import com.spring.cjs2108_kdd.vo.SongVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired SongService songService;
	
	@Autowired UserService userService;
	
	@RequestMapping("/main")
	public String mainGet(Model model, 
			@RequestParam(value = "sw", defaultValue = "0") int sw, 
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo) 
					throws IOException, ParseException {
		if (sw == 0) {
			model.addAttribute("vos", songService.getChartVOS("all"));
		}
		
		else if (sw == 1) {
			model.addAttribute("vos", userService.getUserVOS());
		}
		
		else if (sw == 2 || sw == 3) {
			int pageSize = 10;
			int startNo = (pageNo - 1) * pageSize;
			int lastPageNo = songService.getSongCnt() / 10 + 1;
			if (songService.getSongCnt() % 10 == 0) lastPageNo--;
			model.addAttribute("vos", songService.getSongVOS(startNo, pageSize));
			model.addAttribute("lastPageNo", lastPageNo);
			model.addAttribute("pageNo", pageNo);
		}
		
		model.addAttribute("sw", sw);
		return "admin/main";
	}

	@RequestMapping(value="/main", method = RequestMethod.POST)
	public String mainPost(Model model,
			HttpServletRequest request,
			@RequestParam(value = "sw", defaultValue = "1") int sw, 
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
						
						songService.setAdminSongUpdate(idx, column, value);
					}
				}
			}
		model.addAttribute("sw", sw);
		model.addAttribute("pageNo", pageNo);
		return "redirect:/admin/main";
	}
	
	@RequestMapping("/lyrics")
	@ResponseBody
	public SongVO getlyricsPost(Integer idx) {
		SongVO vo = songService.getSongInfor(idx);
		if (vo != null) vo.setImg(vo.getImg().replaceFirst("50", "200"));
		return vo;
	}

	@RequestMapping("/userdel")
	@ResponseBody
	public void userdelPost(Integer idx) {
		userService.setUserDel(idx);
	}

	@RequestMapping("/addsong")
	@ResponseBody
	public void addsongPost(String img, String title, String artist) {
		songService.addSongDB(img, title, artist);
	}

	@RequestMapping("/addsongall")
	@ResponseBody
	public void addsongallPost() {
		List<ChartVO> vos = songService.getChartVOS(null);
		for (int i=0; i<vos.size(); i++) {
			if (vos.get(i).getSongIdx() == 0) {
				songService.addSongDB(vos.get(i).getImg(), vos.get(i).getTitle(), vos.get(i).getArtist());
			}
		}
	}

	@RequestMapping("/upload")
	@ResponseBody
	public void uploadPost(int idx, MultipartFile file) throws IOException {
		songService.songUpload(idx, file);
		songService.setIsfile(idx);
		songService.setSongUpdate(idx);
	}

	@RequestMapping("/insertsong")
	@ResponseBody
	public String insertsongPost(SongVO vo) {
		if (songService.isSong(vo.getTitle(), vo.getArtist()) != 0) return "no" ;
		
		else {
			songService.insertSong(vo); 
			return "yes";
		}
	}

	@RequestMapping("/isFileUpdate")
	public String isFileUpdateGet(Model model, int sw, int pageNo) {
		songService.isFileUpdate();
		model.addAttribute("sw", sw);
		model.addAttribute("pageNo", pageNo);
		return "redirect:/admin/main";
	}

	@RequestMapping("/srch")
	public String srchGet(Model model, String srch, int sw, int pageNo, String noFile) {
		if (noFile != null && noFile.equals("1")) {
			model.addAttribute("vos", songService.getSongSrch(null));
		}

		else {
			model.addAttribute("vos", songService.getSongSrch(srch));
		}
		model.addAttribute("flag", "srch");
		model.addAttribute("sw", sw);
		model.addAttribute("pageNo", pageNo);
		return "admin/main";
	}
	
	@RequestMapping("/chartupdate")
	@ResponseBody
	public void chartupdatePost() throws IOException {
		Method method = new Method();
		List<ChartVO> vos = method.getChartTop100();
		for (int i=0; i<vos.size(); i++) {
			int idx = 0;
			if (songService.getSongIdx(vos.get(i).getTitle(), vos.get(i).getArtist()) != null) idx = songService.getSongIdx(vos.get(i).getTitle(), vos.get(i).getArtist());
			vos.get(i).setSongIdx(idx);
			vos.get(i).setIsFile(songService.getSongInfor(idx).getIsFile());
		}
		songService.setChartUpdate(vos);
	}
}
