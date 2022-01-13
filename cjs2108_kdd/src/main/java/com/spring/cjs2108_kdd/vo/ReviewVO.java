package com.spring.cjs2108_kdd.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private int userIdx;
	private String title;
	private String content;
	private String date;
	private String hostIp;
	private int visible;
}
