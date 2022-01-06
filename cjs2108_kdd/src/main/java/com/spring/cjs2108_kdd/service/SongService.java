package com.spring.cjs2108_kdd.service;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import com.spring.cjs2108_kdd.vo.SongVO;

public interface SongService {

	Integer getSongIdx(String title, String artist);

	ArrayList<SongVO> getChartJson() throws FileNotFoundException;

	int getSongCnt();

	ArrayList<SongVO> getSongVOS(int startNo, int pageSize);

	void setAdminSongUpdate(int idx, String column, String value);

	SongVO getSongInfor(int idx);

	ArrayList<SongVO> getSongSrch(String srchKwd);

	void upLikeCnt(int idx);

	void addLikeList(int idx, String mid);

	void downLikeCnt(int idx);

	void subLikeList(int idx, String mid);

	String getLikeList(int idx);

	String getLyrics(int idx);

}
