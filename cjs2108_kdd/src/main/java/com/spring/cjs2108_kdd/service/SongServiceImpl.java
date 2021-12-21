package com.spring.cjs2108_kdd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_kdd.dao.SongDAO;

@Service
public class SongServiceImpl implements SongService {
	@Autowired
	SongDAO songDAO;

	@Override
	public Integer getSongIdx(String title, String artist) {
		return songDAO.getSongIdx(title, artist);
	}
	
}
