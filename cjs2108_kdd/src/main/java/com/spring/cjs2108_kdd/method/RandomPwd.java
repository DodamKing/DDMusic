package com.spring.cjs2108_kdd.method;

import java.util.UUID;

public class RandomPwd {
	public String getRanPwd(int size) {
		String pwd = "";
		UUID uid = UUID.randomUUID();
		pwd = uid.toString().substring(0, size);
		return pwd;
	}
}
