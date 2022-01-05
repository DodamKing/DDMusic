package com.spring.cjs2108_kdd.method;

public class Method {
	public String getImgSize(String img, String size) {
		String img_ = img.replace("50", size);
		return img_;
	}
}
