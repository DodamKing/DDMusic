package com.spring.cjs2108_kdd.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.spring.cjs2108_kdd.dao.SongDAO;
import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.vo.ChartVO;
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
	public ArrayList<SongVO> getChartJson() throws IOException, ParseException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath("json/song_json.json");
		
		JSONParser parser = new JSONParser();
		Reader reader = new FileReader(path);
		JSONObject jsonObject = (JSONObject) parser.parse(reader);
		JSONArray songs = (JSONArray) jsonObject.get("songs");
		
		Gson gson = new Gson();
		ArrayList<SongVO> vos = new ArrayList<SongVO>();
		for (int i=0; i<songs.size(); i++) {
			SongVO vo = new SongVO();
			JSONObject song = (JSONObject) songs.get(i);
			vo = gson.fromJson(song.toJSONString(), SongVO.class);
			int idx = songDAO.getSongIdx(song.get("title").toString(), song.get("artist").toString());
			vo.setIdx(idx);
			vo.setIsFile(songDAO.getSongInfor(idx).getIsFile());
			vos.add(vo);
		}
//		vos = songDAO.getSong100(vos);
		
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

	@Override
	public void upLikeCnt(int idx) {
		songDAO.upLikeCnt(idx);
	}

	@Override
	public void addLikeList(int idx, String mid) {
		String likeList = "";
		if (songDAO.getLikeList(idx) != null) likeList = songDAO.getLikeList(idx);
		likeList += mid + "/";
		songDAO.setLikeList(idx, likeList);
	}

	@Override
	public void downLikeCnt(int idx) {
		songDAO.downLikeCnt(idx);
	}

	@Override
	public void subLikeList(int idx, String mid) {
		String likeList = songDAO.getLikeList(idx);
		likeList = likeList.replace(mid + "/", "");
		songDAO.setLikeList(idx, likeList);
	}

	@Override
	public String getLikeList(int idx) {
		return songDAO.getLikeList(idx);
	}

	@Override
	public String getLyrics(int idx) {
		return songDAO.getLyrics(idx);
	}

	@Override
	public void addSongDB(String img, String title, String artist) {
		songDAO.addSongDB(img, title, artist);
		int songIdx = songDAO.getSongIdx(title, artist);
		songDAO.setChartSongIdx(songIdx, title, artist);
	}

	@Override
	public void songUpload(int idx, MultipartFile file) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/music/");
		
		String fileNm = songDAO.getSongInfor(idx).getTitle() + " - " + songDAO.getSongInfor(idx).getArtist() + ".mp3";
		fileNm = fileNm.replaceAll("[\\\\/:*?\"<>|]", "");
		byte[] data = file.getBytes();
	
		FileOutputStream fos = new FileOutputStream(uploadPath + fileNm);
		fos.write(data);
		fos.close();
	}

	@Override
	public void setPlayCnt(int songIdx, int userIdx) {
		if (songDAO.isPlayCnt(songIdx, userIdx) == 0) {
			songDAO.setPlayCnt(songIdx, userIdx);
		}
		songDAO.addPlayCnt(songIdx, userIdx);
	}

	@Override
	public ArrayList<SongVO> getRank() {
		return songDAO.getRank();
	}

	@Override
	public void insertSong(SongVO vo) {
		songDAO.insertSong(vo);
	}

	@Override
	public int isSong(String title, String artist) {
		return songDAO.isSong(title, artist);
	}

	@Override
	public void setIsfile(int idx) {
		songDAO.setIsfile(idx);
		songDAO.setIsFileChart(songDAO.getSongInfor(idx).getTitle(), songDAO.getSongInfor(idx).getArtist());
	}

	@Override
	public void isFileUpdate() {
		Method method = new Method();
		int last = songDAO.getLastIdx();
		System.out.println(last);
		for (int i=0; i<last + 1; i++) {
			SongVO vo = songService.getSongInfor(i);
			if (vo != null) {
				if (method.isFile(vo.getTitle(), vo.getArtist())) {
					songDAO.isFileUpdate(vo.getIdx(), 1);
				}
				System.out.println(i);
			}
		}
	}

	@Override
	public void setSongUpdate(int idx) {
		songDAO.setSongUpdate(idx);
	}

	@Override
	public ArrayList<SongVO> getUpdateSong() {
		return songDAO.getUpdateSong();
	}

	@Override
	public ArrayList<SongVO> getMyRank(int idx) {
		return songDAO.getMyRank(idx);
	}

	@Override
	public void setChartUpdate(List<ChartVO> vos) {
		songDAO.setChartUpdate(vos);
	}

	@Override
	public ArrayList<ChartVO> getChartVOS(String date) {
		return songDAO.getChartVOS(date);
	}

	@Override
	public String getMinDate() {
		return songDAO.getMinDate();
	}

	@Override
	public ArrayList<SongVO> getSrchArtist(String artist) {
		ArrayList<SongVO> vos = new ArrayList<SongVO>();
		
		if (artist.contains("(")) {
			String artist1 = artist.split("\\(")[0].trim();
			String artist2 = artist.substring(artist.indexOf("(") + 1, artist.indexOf(")"));
			vos = songDAO.getSrchArtist(artist1, artist2);
		}
		
		else {
			vos = songDAO.getSrchArtist(artist, null);
		}
		
		return vos;
	}

	@Override
	public void setDownload(int userIdx, String songIdx) {
		String songIdxs = "";
		if (songDAO.getDownSongIdxs(userIdx) != null) {
			songIdxs = songDAO.getDownSongIdxs(userIdx);
		}
		
		if (!songIdxs.contains(songIdx)) songIdxs += songIdx + "/";
		songDAO.setDownUpdate(userIdx, songIdxs, 1);
	}

	@Override
	public ArrayList<SongVO> getDownloadMP3(int idx) {
		ArrayList<Integer> songIdx = new ArrayList<Integer>();
		String songIdxs = songDAO.getDownSongIdxs(idx);
		if (songIdxs != null) {
			String[] songIdxsArr = songIdxs.split("/");
			for (String str : songIdxsArr) {
				songIdx.add(Integer.parseInt(str));
			}
			return songDAO.getDownloadMP3(songIdx);
		}
		return null;
	}

}
