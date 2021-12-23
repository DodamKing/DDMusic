package com.spring.cjs2108_kdd.vo;

import lombok.Data;

@Data
public class UserVO {
	int idx;
	String userId;
	String pwd;
	String email;
	String telecom;
	String phoneNb;
	String userNm;
	String nickNm;
	int membership;
	String membershipDate;
	int membershipCnt;
	int withdrawal;
	String profileImg;
	
	String nextMembershipDate;
}
