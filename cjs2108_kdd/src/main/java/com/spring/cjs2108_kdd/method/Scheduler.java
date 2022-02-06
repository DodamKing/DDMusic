package com.spring.cjs2108_kdd.method;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.ChartVO;
import com.spring.cjs2108_kdd.vo.PlayVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Component
public class Scheduler {
	@Autowired SongService songService;

	@Autowired UserService userService;
	
	// 매일 10시 차트 업데이트
	@Scheduled(cron = "0 0 10 * * *")
	public void chartUpdate() throws IOException {
		Method method = new Method();
		List<ChartVO> vos = method.getChartTop100();
		for (int i=0; i<vos.size(); i++) {
			int idx = 0;
			if (songService.getSongIdx(vos.get(i).getTitle(), vos.get(i).getArtist()) != null) idx = songService.getSongIdx(vos.get(i).getTitle(), vos.get(i).getArtist());
			vos.get(i).setSongIdx(idx);
			vos.get(i).setIsFile(songService.getSongInfor(idx).getIsFile());
		}
		songService.setChartUpdate(vos);
		System.out.println("차트 업데이트 : " + songService.getChartVOS(null).get(0).getDate());
	}
	
	// 매일 10시 30분 아티스트 테잎 업데이트
	@Scheduled(cron = "0 30 10 * * *")
	public void artistTapeUpdate() {
		List<UserVO> userVOS = userService.getUserVOS();
		
		for (int i=0; i<userVOS.size(); i++) {
			ArrayList<Integer> bestUserSongIdx = new ArrayList<Integer>();
			ArrayList<Integer> bestUserSongCnt = new ArrayList<Integer>();
			int userIdx = userVOS.get(i).getIdx();
			if (userIdx == 0) continue;
			List<PlayVO> playListVOS = userService.getUserBestSongIdx(userIdx);
			
			for (int j=0; j<playListVOS.size(); j++) {
				bestUserSongIdx.add(playListVOS.get(j).getSongIdx());
				bestUserSongCnt.add(playListVOS.get(j).getPlayCnt());
			}

			ArrayList<String> artist_1 = new ArrayList<String>();
			ArrayList<Integer> songCnt_1 = new ArrayList<Integer>();
			for (int j=0; j<bestUserSongIdx.size(); j++) {
				String artist_temp = songService.getSongInfor(bestUserSongIdx.get(j)).getArtist();
				if (!artist_1.contains(artist_temp)) {
					artist_1.add(songService.getSongInfor(bestUserSongIdx.get(j)).getArtist());
					songCnt_1.add(bestUserSongCnt.get(j));
				}
				else {
					int index_ = artist_1.indexOf(artist_temp);
					songCnt_1.set(index_, songCnt_1.get(index_) + bestUserSongCnt.get(j));
				}
			}
			
			for (int j=0; j<songCnt_1.size(); j++) {
				for (int k=j; k>0; k--) {
					if (songCnt_1.get(k - 1) < songCnt_1.get(k)) {
						int temp = songCnt_1.get(k - 1);
						songCnt_1.set(k - 1, songCnt_1.get(k));
						songCnt_1.set(k, temp);

						String tmp = artist_1.get(k - 1);
						artist_1.set(k - 1, artist_1.get(k));
						artist_1.set(k, tmp);
					}
				}
			}
			
			String artist = "";
			
			for (int j=0; j<artist_1.size(); j++) {
				artist += artist_1.get(j) + "^";
			}
			
			if (!artist.equals("")) {
				userService.setArtistTape(userIdx, artist);
			}
		}
		LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formatedNow = now.format(formatter);
		System.out.println("아티스트 테잎 업데이트: " + formatedNow);
	}
	
//	@Scheduled(cron = "0 35 10 * * *")
//	public void mixTapeUpdate() {
//		List<UserVO> userVOS = userService.getUserVOS();
//		
//		for (int i=0; i<userVOS.size(); i++) {
//			ArrayList<Integer> bestUserSongIdx = new ArrayList<Integer>();
//			int userIdx = userVOS.get(i).getIdx();
//			if (userIdx == 0) continue;
//			List<PlayVO> playListVOS = userService.getUserBestSongIdx(userIdx);
//			for (int j=0; j<playListVOS.size(); j++) {
//				bestUserSongIdx.add(playListVOS.get(j).getSongIdx());
//			}
//			
//		}
//		
//	}
	
}
