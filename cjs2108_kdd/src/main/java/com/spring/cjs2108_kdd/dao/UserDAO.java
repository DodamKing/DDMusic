package com.spring.cjs2108_kdd.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.PlayVO;
import com.spring.cjs2108_kdd.vo.UserVO;

public interface UserDAO {

	UserVO getUserVO(Integer idx);

	int idCheck(String userId);

	void setSignup(@Param("vo") UserVO vo);

	Integer getIdx(String userId);

	void setWithdrawal(Integer idx);

	void setuserUpdate(@Param("idx") Integer idx, @Param("vo") UserVO vo);

	void setUpdatePwd(@Param("pwd") String pwd, @Param("idx") Integer idx);

	void setMembership(Integer idx);

	String getUserId(@Param("userNm") String userNm, @Param("phoneNb") String phoneNb,  @Param("email")String email);

	List<UserVO> getUserVOS();

	void setImgUpdate(@Param("idx") Integer idx, @Param("profileImg") String profileImg);

	void setUserDel(Integer idx);

	void setMemberShipReset(int idx);

	ArrayList<PlayListVO> getPlayListVOS(int idx);

	void setPlayList(@Param("vo") PlayListVO vo);

	void setVisitDate(int idx);

	PlayListVO getPlayListVO(int idx);

	void setUpdateMyList(@Param("idx") int idx, @Param("content") String content);

	void setPlayListDel(int idx);

	void setPlayListContentUpdate(@Param("idx") int idx, @Param("listNm") String listNm, @Param("comment") String comment);

	ArrayList<PlayVO> getUserBestSongIdx(int userIdx);

	void setArtistTape(@Param("userIdx") int userIdx, @Param("artist") String artist);

	String getArtistTape(int idx);


}
