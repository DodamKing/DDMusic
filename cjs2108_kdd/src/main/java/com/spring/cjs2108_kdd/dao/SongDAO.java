package com.spring.cjs2108_kdd.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kdd.vo.PlayVO;
import com.spring.cjs2108_kdd.vo.SongVO;

public interface SongDAO {

	public Integer getSongIdx(@Param("title") String title, @Param("artist") String artist);

	public int getSongCnt();

	public ArrayList<SongVO> getSongVOS(@Param("startNo") int startNo, @Param("pageSize") int pageSize);

	public void setAdminSongUpdate(@Param("idx") int idx, @Param("column") String column, @Param("value") String value);

	public SongVO getSongInfor(int idx);

	public ArrayList<SongVO> getSongSrch(String srchKwd);

	public void upLikeCnt(int idx);

	public String getLikeList(int idx);

	public void setLikeList(@Param("idx") int idx, @Param("likeList") String likeList);

	public void downLikeCnt(int idx);

	public String getLyrics(int idx);

	public void addSongDB(@Param("img") String img, @Param("title") String title, @Param("artist") String artist);

	public void setPlayCnt(@Param("songIdx") int songIdx, @Param("userIdx") int userIdx);

	public void addPlayCnt(@Param("songIdx") int songIdx, @Param("userIdx") int userIdx);

	public ArrayList<SongVO> getSong100(@Param("vos") ArrayList<SongVO> vos);

	public int isPlayCnt(@Param("songIdx") int songIdx, @Param("userIdx") int userIdx);

	public ArrayList<SongVO> getRank();

	public void insertSong(@Param("vo") SongVO vo);

	public int isSong(@Param("title") String title, @Param("artist") String artist);

	public void setIsfile(int idx);

}
