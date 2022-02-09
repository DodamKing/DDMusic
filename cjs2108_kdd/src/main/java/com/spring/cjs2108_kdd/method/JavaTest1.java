package com.spring.cjs2108_kdd.method;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class JavaTest1 {
	public static void main(String[] args) {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String formatedNow = now.format(formatter);
		System.out.println("아티스트 테잎 업데이트: " + formatedNow);
	}
}
