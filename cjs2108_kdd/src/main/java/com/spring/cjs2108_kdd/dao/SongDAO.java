package com.spring.cjs2108_kdd.dao;

import org.apache.ibatis.annotations.Param;

public interface SongDAO {

	public Integer getSongIdx(@Param("title") String title, @Param("artist") String artist);
	
}
