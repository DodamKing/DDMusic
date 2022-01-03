package com.spring.cjs2108_kdd;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DDtoday {
	@RequestMapping(value={"/", "/today"})
	public String mainPage() {
		
		return "main/main";
	}
}
