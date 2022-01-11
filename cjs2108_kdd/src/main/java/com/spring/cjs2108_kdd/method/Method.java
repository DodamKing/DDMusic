package com.spring.cjs2108_kdd.method;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class Method {
	public String getImgSize(String img, String size) {
		String img_ = img.replace("50", size);
		return img_;
	}
	
	public boolean isFile(String title, String artist) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String name = title + " - " + artist + ".mp3";
		String path = request.getSession().getServletContext().getRealPath("/resources/music/");
		File f = new File(path + name);
		if (f.exists()) return true;
		return false;
	}
}
