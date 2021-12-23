package com.spring.cjs2108_kdd;

import java.io.FileNotFoundException;
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
	public String chartGet(HttpServletRequest request, Model model) throws FileNotFoundException {
//		String path = request.getSession().getServletContext().getRealPath("json/song_json.json");
//		
//		JsonParser parser = new JsonParser();
//		Reader reader = new FileReader(path);
//		JsonObject jsonObject = (JsonObject) parser.parse(reader);
//		JsonArray songs = jsonObject.getAsJsonArray("songs");
//		
//		Gson gson = new Gson();
//		ArrayList<SongVO> vos = new ArrayList();
//		
//		for (int i=0; i<songs.size(); i++) {
//			SongVO vo = new SongVO();
//			vo = gson.fromJson(songs.get(i).toString(), SongVO.class);
//			Integer idx = 0;
//			if (songService.getSongIdx(vo.getTitle(), vo.getArtist()) != null) idx = songService.getSongIdx(vo.getTitle(), vo.getArtist());
//			vo.setIdx(idx);
//			vos.add(vo);
//		}
		
		ArrayList<SongVO> vos = songService.getChartJson();
		
		model.addAttribute("vos", vos);
		return "main/chart";
	}
}
