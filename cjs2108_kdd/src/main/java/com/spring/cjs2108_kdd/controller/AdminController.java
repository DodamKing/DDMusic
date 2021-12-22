package com.spring.cjs2108_kdd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@RequestMapping("/main")
	public String mainGet() {
		return "admin/main";
	}
}
