package com.spring.cjs2108_kdd.method;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.google.gson.Gson;
import com.spring.cjs2108_kdd.vo.SongVO;

public class JavaTest {
	public static void main(String[] args) throws IOException, ParseException {
		
		JSONParser parser = new JSONParser();
		Reader reader = new FileReader("C:\\Users\\JYJ\\Desktop\\works\\DDMusic\\cjs2108_kdd\\src\\main\\webapp\\json\\song_json.json");
		JSONObject jsonObject = (JSONObject) parser.parse(reader);
		JSONArray songs = (JSONArray) jsonObject.get("songs");
		
		Gson gson = new Gson();
		ArrayList<SongVO> vos = new ArrayList<SongVO>();
		for (int i=0; i<songs.size(); i++) {
			SongVO vo = new SongVO();
			JSONObject song = (JSONObject) songs.get(i);
			vo = gson.fromJson(song.toJSONString(), SongVO.class);
//			vo.setImg(song.get("img").toString());
//			vo.setTitle(song.get("title").toString());
//			vo.setArtist(song.get("artist").toString());
			vos.add(vo);
			System.out.println(song);
		}
		System.out.println(vos);
	}
}
