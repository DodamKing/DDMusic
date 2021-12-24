package com.spring.cjs2108_kdd.method;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SendEmail {
	
	public void sendEmailPwd(String email, String userId, String pwd_) throws MessagingException {
		JavaMailSender mailSender = new JavaMailSenderImpl();
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		
		String title = "안녕하세요 DDMusic 입니다.";
		helper.setTo(email);
		helper.setSubject(title);
		
		String content = "DDMusic을 이용해 주셔셔 감사합니다.<br><br>" + userId + "님 임시 비밀번호는 '<b>" + pwd_ + "</b>' 입니다.<br><br>로그인 하셔서 비밀번호를 꼭 변경해 주세요!";
		content += "<br><br><a href='http://218.236.203.156:9090/cjs2108_kdd'>DDmusic 바로가기</a>";
		content += "<p><img src='cid:13.png'></p>";
		helper.setText(content, true);
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath("resources/img/13.png");
		
		FileSystemResource file = new FileSystemResource(path);
		helper.addInline("13.png", file);
		
		mailSender.send(message);
	}
}
