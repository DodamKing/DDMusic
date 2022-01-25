package com.spring.cjs2108_kdd.vo;

import lombok.Data;

@Data
public class ChartVO {
	private int idx;
	private String img;
	private String title;
	private String artist;
	private int rank;
	private int songIdx;
	private int isFile;
	private String date;
}
