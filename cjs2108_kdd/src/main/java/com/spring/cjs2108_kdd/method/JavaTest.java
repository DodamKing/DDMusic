package com.spring.cjs2108_kdd.method;

public class JavaTest {
	public static void main(String[] args) {
		String fileNm = "???\\테스트용/:*?<>|";
		fileNm = fileNm.replaceAll("[\\\\/:*?\"<>|]", "");
		System.out.println(fileNm);
	}
}
