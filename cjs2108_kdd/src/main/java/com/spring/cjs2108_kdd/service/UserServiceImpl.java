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

import com.spring.cjs2108_kdd.dao.SongDAO;
import com.spring.cjs2108_kdd.dao.UserDAO;
import com.spring.cjs2108_kdd.method.Method;
import com.spring.cjs2108_kdd.vo.PlayListVO;
import com.spring.cjs2108_kdd.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired UserDAO userDAO;
	@Autowired SongDAO songDAO;
	
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
		Method method = new Method();
		ArrayList<PlayListVO> vos = userDAO.getPlayListVOS(idx);
		
		for (int i=0; i<vos.size(); i++) {
			String idxs[] = vos.get(i).getContent().split("/");
			if (idxs.length >= 4) {
				vos.get(i).setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
				vos.get(i).setThum2(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[1])).getImg(), "100"));
				vos.get(i).setThum3(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[2])).getImg(), "100"));
				vos.get(i).setThum4(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[3])).getImg(), "100"));
			}
			else if (idxs.length == 3) {
				vos.get(i).setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
				vos.get(i).setThum2(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[1])).getImg(), "100"));
				vos.get(i).setThum3(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[2])).getImg(), "100"));
			}
			else if (idxs.length == 2) {
				vos.get(i).setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
				vos.get(i).setThum2(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[1])).getImg(), "100"));
			}
			else if (idxs.length == 1) {
				vos.get(i).setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
			}
		}
		
		return vos;
	}

	@Override
	public void setPlayList(PlayListVO vo) {
		userDAO.setPlayList(vo);
	}

	@Override
	public void setVisitDate(int idx) {
		userDAO.setVisitDate(idx);
	}

	@Override
	public PlayListVO getPlayListVO(int idx) {
		Method method = new Method();
		PlayListVO vo = userDAO.getPlayListVO(idx);
		
		String idxs[] = vo.getContent().split("/");
		
		if (idxs.length >= 4) {
			vo.setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
			vo.setThum2(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[1])).getImg(), "100"));
			vo.setThum3(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[2])).getImg(), "100"));
			vo.setThum4(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[3])).getImg(), "100"));
		}
		else if (idxs.length == 3) {
			vo.setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
			vo.setThum2(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[1])).getImg(), "100"));
			vo.setThum3(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[2])).getImg(), "100"));
		}
		else if (idxs.length == 2) {
			vo.setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
			vo.setThum2(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[1])).getImg(), "100"));
		}
		else if (idxs.length == 1) {
			vo.setThum1(method.getImgSize(songDAO.getSongInfor(Integer.parseInt(idxs[0])).getImg(), "100"));
		}
		
		return vo;
	}

	@Override
	public void setAddMyList(int idx, int songIdx) {
		String content = userDAO.getPlayListVO(idx).getContent();
		content += songIdx + "/";
		userDAO.setAddMyList(idx, content);
	}

}
