package com.spring.cjs2108_kdd.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kdd.dao.UserDAO;
import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;
	
	@Override
	public UserVO getUserVO(Integer idx) {
		return userDAO.getUserVO(idx);
	}

	@Override
	public int idCheck(String userId) {
		return userDAO.idCheck(userId);
	}

	@Override
	public void setSignup(UserVO vo) {
		userDAO.setSignup(vo);
	}

	@Override
	public Integer getIdx(String userId) {
		return userDAO.getIdx(userId);
	}

	@Override
	public void setWithdrawal(Integer idx) {
		userDAO.setWithdrawal(idx);
	}

	@Override
	public void setuserUpdate(Integer idx, UserVO vo) {
		userDAO.setuserUpdate(idx, vo);
	}

	@Override
	public void setUpdatePwd(String pwd, Integer idx) {
		userDAO.setUpdatePwd(pwd, idx);
	}

	@Override
	public void setMembership(Integer idx) {
		userDAO.setMembership(idx);
	}

	@Override
	public String getUserId(String userNm, String phoneNb, String email) {
		String mid = userDAO.getUserId(userNm, phoneNb, email);
		mid = mid.replace(mid.substring(0, 4), "****");
		return mid;
	}

	@Override
	public List<UserVO> getUserVOS() {
		
		return userDAO.getUserVOS();
	}

	@Override
	public void setImgUpdate(Integer idx, MultipartFile imgUpdate) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/img/");
		String profileImg = "";
		
		File file = new File(uploadPath + userDAO.getUserVO(idx).getProfileImg());
		if (file.exists()) file.delete();
		
		if (!imgUpdate.getOriginalFilename().equals("")) {
			profileImg = userDAO.getUserVO(idx).getUserId() + "_" + imgUpdate.getOriginalFilename();
			byte[] data = imgUpdate.getBytes();
		
			FileOutputStream fos = new FileOutputStream(uploadPath + profileImg);
			fos.write(data);
			fos.close();
		}
		
		userDAO.setImgUpdate(idx, profileImg);
	}

	@Override
	public void setUserDel(Integer idx) {
		userDAO.setUserDel(idx);
	}

	@Override
	public void setMemberShipReset(int idx) {
		userDAO.setMemberShipReset(idx);
	}

	@Override
	public ArrayList<PlayListVO> getPlayListVOS(int idx) {
		return userDAO.getPlayListVOS(idx);
	}

	@Override
	public void setPlayList(PlayListVO vo) {
		userDAO.setPlayList(vo);
	}

}
