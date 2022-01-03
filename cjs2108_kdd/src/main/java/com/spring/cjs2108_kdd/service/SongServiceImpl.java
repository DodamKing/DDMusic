package com.spring.cjs2108_kdd.service;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.Reader;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.cjs2108_kdd.dao.SongDAO;
import com.spring.cjs2108_kdd.vo.SongVO;

@Service
public class SongServiceImpl implements SongService {
	@Autowired
	SongDAO songDAO;
	
	@Autowired
	SongService songService;

	@Override
	public Integer getSongIdx(String title, String artist) {
		return songDAO.getSongIdx(title, artist);
	}

	@Override
	public ArrayList<SongVO> getChartJson() throws FileNotFoundException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath("json/song_json.json");
		
		JsonParser parser = new JsonParser();
		Reader reader = new FileReader(path);
		JsonObject jsonObject = (JsonObject) parser.parse(reader);
		JsonArray songs = jsonObject.getAsJsonArray("songs");
		
		Gson gson = new Gson();
		ArrayList<SongVO> vos = new ArrayList();
		
		for (int i=0; i<songs.size(); i++) {
			SongVO vo = new SongVO();
			vo = gson.fromJson(songs.get(i).toString(), SongVO.class);
			Integer idx = 0;
			if (songService.getSongIdx(vo.getTitle(), vo.getArtist()) != null) idx = songService.getSongIdx(vo.getTitle(), vo.getArtist());
			vo.setIdx(idx);
			vos.add(vo);
		}
		
		return vos;
	}

	@Override
	public int getSongCnt() {
		return songDAO.getSongCnt();
	}

	@Override
	public ArrayList<SongVO> getSongVOS(int startNo, int pageSize) {
		return songDAO.getSongVOS(startNo, pageSize);
	}

	@Override
	public void setAdminSongUpdate(int idx, String column, String value) {
		songDAO.setAdminSongUpdate(idx, column, value);
	}

	@Override
	public SongVO getSongInfor(int idx) {
		return songDAO.getSongInfor(idx);
	}

	@Override
	public ArrayList<SongVO> getSongSrch(String srchKwd) {
		return songDAO.getSongSrch(srchKwd);
	}

}
