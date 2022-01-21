<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>DD Music 로그인</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/login.css">
    <link rel="stylesheet" href="${ctp }/resources/css/loader.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/title.jsp" />
<jsp:include page="/WEB-INF/views/include/findModal.jsp" />

    <section>
	    <div class="main-container">
	   		<h5 class="text-right"><a href="${ctp }/today">DD Music</a></h5>
	        <div class="container p-3 my-3 border">
                <div class="form-container">
                    <form method="post">
                        <h2>로그인</h2>
                        <div class="form-group">
                            <input class="form-control input-control" type="text" id="userId" name="userId" value="${sMid_}"
                                placeholder="아이디" autofocus required>
                        </div>
                        <div class="form-group">
                            <input class="form-control input-control" type="password" id="pwd" name="pwd"
                                placeholder="비밀번호" required>
                        </div>
                        <div class="form-group">
                            <input class="check-control" type="checkbox" id="loginCheck"> <span class="login-status">로그인
                                상태 유지</span>
                        </div>
                        <div id="demo" class="demo-box"></div>
                        <div class="form-group">
                            <input class="form-control login-control" type="submit" id="login_btn" name="login_btn"
                                value="로그인">
                        </div>
                        <div class="d-flex form-foot">
                            <div class="p-2 mr-auto"><a href="${ctp }/user/signup">회원가입</a></div>
                            <div class="p-2 control-r" data-toggle="modal" data-target="#myModal1">계정 찾기</div>
                            <div class="p-2">|</div>
                            <div class="p-2 control-r" data-toggle="modal" data-target="#myModal2">비밀번호 찾기</div>
                        </div>
                    </form>
                </div>
            </div>
		    <footer class="container">
		        Copyright <strong>© DoubleD.</strong> All rights reserved.
		    </footer>
   		</div>
    </section>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
</body>
</html>