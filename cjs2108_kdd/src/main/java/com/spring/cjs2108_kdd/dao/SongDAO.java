package com.spring.cjs2108_kdd.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

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

}
