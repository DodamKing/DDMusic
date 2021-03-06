package com.spring.cjs2108_kdd.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.parser.ParseException;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kdd.vo.ChartVO;
import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.SongVO;

public interface SongService {

	Integer getSongIdx(String title, String artist);

	ArrayList<SongVO> getChartJson() throws FileNotFoundException, IOException, ParseException;

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

	void addSongDB(String img, String title, String artist);

	void songUpload(int idx, MultipartFile file) throws IOException;

	void setPlayCnt(int songIdx, int userIdx);

	ArrayList<SongVO> getRank();

	void insertSong(SongVO vo);

	int isSong(String title, String artist);

	void setIsfile(int idx);

	void isFileUpdate();

	void setSongUpdate(int idx);

	ArrayList<SongVO> getUpdateSong();

	ArrayList<SongVO> getMyRank(int idx);

	void setChartUpdate(List<ChartVO> vos);

	ArrayList<ChartVO> getChartVOS(String date);

	String getMinDate();

	ArrayList<SongVO> getSrchArtist(String artist);

	void setDownload(int userIdx, String songIdx);

	ArrayList<SongVO> getDownloadMP3(int idx);

	
}
