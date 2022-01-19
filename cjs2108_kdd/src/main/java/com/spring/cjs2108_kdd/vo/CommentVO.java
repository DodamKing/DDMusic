package com.spring.cjs2108_kdd.vo;

import lombok.Data;

@Data
public class CommentVO {
	private int idx;
	private int reviewIdx;
	private int userIdx;
	private String content;
	private String date;
	
	private String userId;
	private String nickNm;
}
