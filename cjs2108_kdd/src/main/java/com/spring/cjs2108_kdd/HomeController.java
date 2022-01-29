package com.spring.cjs2108_kdd;

import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.cjs2108_kdd.dao.SongDAO;
import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.ChartVO;
import com.spring.cjs2108_kdd.vo.PlayVO;
import com.spring.cjs2108_kdd.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired SongService songService;
	@Autowired UserService userService;
	@Autowired SongDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home"; 
	}
	
//	@RequestMapping("/isfile")
//	public void isfile() {
//		Method method = new Method();
//		
//		for (int i=383; i<566; i++) {
//			SongVO vo = songService.getSongInfor(i);
//			if (vo != null) {
//				if (method.isFile(vo.getTitle(), vo.getArtist())) {
//					dao.setIsfile(vo.getIdx());
//				}
//				System.out.println(i);
//			}
//		}
//		System.out.println("완료");
//	}
	
	@RequestMapping("/test/jsoup")
	public void test() throws IOException {
		Method method = new Method();
		List<ChartVO> vos = method.getChartTop100();
		System.out.println(vos);
	}
	
	@RequestMapping("/test/test1")
	public void test1()  {
		List<UserVO> userVOS = userService.getUserVOS();
		
		for (int i=0; i<userVOS.size(); i++) {
			ArrayList<Integer> bestUserSongIdx = new ArrayList<Integer>();
			ArrayList<Integer> bestUserSongCnt = new ArrayList<Integer>();
			int userIdx = userVOS.get(i).getIdx();
			if (userIdx == 0) continue;
			List<PlayVO> playListVOS = userService.getUserBestSongIdx(userIdx);
			
			for (int j=0; j<playListVOS.size(); j++) {
				bestUserSongIdx.add(playListVOS.get(j).getSongIdx());
				bestUserSongCnt.add(playListVOS.get(j).getPlayCnt());
			}

			ArrayList<String> artist_1 = new ArrayList<String>();
			ArrayList<Integer> songCnt_1 = new ArrayList<Integer>();
			for (int j=0; j<bestUserSongIdx.size(); j++) {
				String artist_temp = songService.getSongInfor(bestUserSongIdx.get(j)).getArtist();
				if (!artist_1.contains(artist_temp)) {
					artist_1.add(songService.getSongInfor(bestUserSongIdx.get(j)).getArtist());
					songCnt_1.add(bestUserSongCnt.get(j));
				}
				else {
					int index_ = artist_1.indexOf(artist_temp);
					songCnt_1.set(index_, songCnt_1.get(index_) + bestUserSongCnt.get(j));
				}
			}
			
			for (int j=0; j<songCnt_1.size(); j++) {
				for (int k=j; k>0; k--) {
					if (songCnt_1.get(k - 1) < songCnt_1.get(k)) {
						int temp = songCnt_1.get(k - 1);
						songCnt_1.set(k - 1, songCnt_1.get(k));
						songCnt_1.set(k, temp);

						String tmp = artist_1.get(k - 1);
						artist_1.set(k - 1, artist_1.get(k));
						artist_1.set(k, tmp);
					}
				}
			}
			
			String artist = "";
			
			for (int j=0; j<artist_1.size(); j++) {
				artist += artist_1.get(j) + "^";
			}
			
			if (!artist.equals("")) {
				userService.setArtistTape(userIdx, artist);
			}
		}
	}
	
}
