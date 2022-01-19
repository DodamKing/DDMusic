package com.spring.cjs2108_kdd.vo;

import lombok.Data;

@Data
public class SongVO {
	private int idx;
	private String img;
	private String title;
	private String artist;
	private String album;
	private String releaseDate;
	private String genre;
	private String music;
	private String words;
	private String arranger;
	private String lyrics;
	private int likeCnt;
	private String likeList;
	private int isFile;
	
	private int playCnt;
	private int playCntSum;
	
	private String date;
}
