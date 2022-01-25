package com.spring.cjs2108_kdd;

import java.io.IOException;
import java.text.DateFormat;
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
import com.spring.cjs2108_kdd.vo.ChartVO;
import com.spring.cjs2108_kdd.vo.SongVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired SongService songService;
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
	
}
