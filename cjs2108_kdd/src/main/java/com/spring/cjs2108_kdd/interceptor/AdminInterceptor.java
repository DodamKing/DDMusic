package com.spring.cjs2108_kdd.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.cjs2108_kdd.vo.UserVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("sVO");
		if (vo == null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/today");
			dispatcher.forward(request, response);
			return false;
		}
		else if (vo.getMembership() != -1) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/today");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}
}
