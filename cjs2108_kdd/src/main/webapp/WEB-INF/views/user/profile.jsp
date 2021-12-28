<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>My Information</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    	.profileImg {
    		width: 150px;
    		height: 150px;
    		overflow: hidden;
    		border-radius: 100%;
    	}
    	
    	.profileImg:hover {
    		cursor: pointer;
    	}
    </style>
</head>
<body>
	<c:if test="${sVO == null }"><script>location.href="${ctp}/today"</script></c:if>
	<jsp:include page="/WEB-INF/views/include/title.jsp" />
	<div class="container p-5">
		<h2 class="text-center mb-5">DD Music 프로필</h2>
		<div class="card-body" style="background: #F7F7F7;">
			<table class="table table-borderless mt-5 p-3" style="margin: auto; width: 60%;">
				<tr>
					<th class="btn-warning" style="width: 200px;">아이디</th>
					<td>${vo.userId }</td>
					<c:if test="${empty vo.profileImg}">
						<td style="vertical-align: middle;" rowspan="6"><div onclick="location.href='${ctp}/user/imgupdate/${vo.idx}'" class="profileImg text-center p-3" ><i class="fa-solid fa-user fa-5x"></i></div></td>
					</c:if>
					<c:if test="${!empty vo.profileImg}">
						<td style="vertical-align: middle;" rowspan="6"><div onclick="location.href='${ctp}/user/imgupdate/${vo.idx}'" class="profileImg" ><img style="width: 100%; height: 100%;" src="${ctp }/resources/img/${vo.profileImg}" /></div></td>
					</c:if>
				</tr>
				<tr>
					<th class="btn-warning">이메일 주소</th>
					<td>${vo.email }</td>
				</tr>
				<tr>
					<th class="btn-warning">휴대폰 번호</th>
					<td>${fn:substring(vo.phoneNb, 0, 3)}-${fn:substring(vo.phoneNb, 3, 7)}-${fn:substring(vo.phoneNb, 7, 11) }</td>
				</tr>
				<tr>
					<th class="btn-warning">이름</th>
					<td>${vo.userNm }</td>
				</tr>
				<tr>
					<th class="btn-warning">별명</th>
					<td>${vo.nickNm }</td>
				</tr>
				<tr>
					<th class="btn-warning">맵버십</th>
					<td>
						<c:if test="${vo.membership == 0 }">없음</c:if> 
						<c:if test="${vo.membership == 1 }">DD Music 무제한 듣기</c:if> 
					</td>
				</tr>
				<tr><td style="background: #F7F7F7;"></td><td style="background: #F7F7F7;"></td></tr>
				<tr>
					<td style="background: #F7F7F7; text-align: right;" colspan="3">
						<div class="btn-group btn-group-lg">
							<input type="button" value="비밀번호 변경" class="btn btn-warning" onclick="location.href='${ctp}/user/pwdcha/${vo.idx}'" />
							<input type="button" value="프사 변경" class="btn btn-warning" onclick="location.href='${ctp}/user/imgupdate/${vo.idx}'" />
							<input type="button" value="정보 수정" class="btn btn-warning" onclick="location.href='${ctp}/user/update/${vo.idx}'" />
							<input type="button" value="회원 탈퇴" class="btn btn-warning" onclick="cf()" />
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function cf() {
			if (confirm("정말 탈퇴 하시겠습니까?")) {
				if (confirm("탈퇴 시 고객님의 정보는 1개월간 보관 됩니다. 그래도 탈퇴 하시겠습니까?")) {
					location.href="${ctp}/user/withdrawal/${vo.idx}";
				}
			}
		}
    </script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>