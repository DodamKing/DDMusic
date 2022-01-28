package com.spring.cjs2108_kdd.method;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.cjs2108_kdd.service.SongService;
import com.spring.cjs2108_kdd.service.UserService;
import com.spring.cjs2108_kdd.vo.ChartVO;

@Component
public class Scheduler {
	@Autowired SongService songService;
	
	@Scheduled(cron = "0 0 10 * * *")
//	@Scheduled(cron = "0 * * * * *")
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
	
}
