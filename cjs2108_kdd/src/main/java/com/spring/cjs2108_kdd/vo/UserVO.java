package com.spring.cjs2108_kdd.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class UserVO {
	private int idx;
	private String userId;
	private String pwd;
	private String email;
	private String telecom;
	private String phoneNb;
	private String userNm;
	private String nickNm;
	private int membership;
	private String membershipDate;
	private int membershipCnt;
	private int withdrawal;
	private String profileImg;
	
	private Date nextMembershipDate;
	
	private Date visitDate;
	private String lastDate;
	private int visitCnt;
}
