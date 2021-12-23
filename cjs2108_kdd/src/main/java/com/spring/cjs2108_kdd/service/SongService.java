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

}
