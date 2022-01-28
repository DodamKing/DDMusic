package com.spring.cjs2108_kdd.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.PlayVO;
import com.spring.cjs2108_kdd.vo.SongVO;
import com.spring.cjs2108_kdd.vo.UserVO;

public interface UserService {

	UserVO getUserVO(Integer idx);

	int idCheck(String userId);

	void setSignup(UserVO vo);

	Integer getIdx(String userId);

	void setWithdrawal(Integer idx);

	void setuserUpdate(Integer idx, UserVO vo);

	void setUpdatePwd(String pwd, Integer idx);

	void setMembership(Integer idx);

	String getUserId(String userNm, String phoneNb, String email);

	List<UserVO> getUserVOS();

	void setImgUpdate(Integer idx, MultipartFile imgUpdate) throws IOException;

	void setUserDel(Integer idx);

	void setMemberShipReset(int idx);

	ArrayList<PlayListVO> getPlayListVOS(int idx);

	void setPlayList(PlayListVO vo);

	void setVisitDate(int idx);

	PlayListVO getPlayListVO(int idx);

	boolean setAddMyList(int idx, int songIdx);

	void setPlayListDel(int idx);

	void setPlayListDelSong(int idx, int songIdx);

	void setPlayListContentUpdate(int idx, String listNm, String comment);

	void setAddMyListMany(int idx, String songIdxs);

	ArrayList<PlayVO> getUserBestSongIdx(int userIdx);

	void setArtistTape(int userIdx, String artist);

	List<SongVO> getArtistTape(int idx);

}
