<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>사용자 리뷰</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
		<div class="container">
			<div class="card-body" style="padding-bottom: 300px; background: #222;">
				<h2 class="mt-5 mb-5">사용자 리뷰</h2>
				<table class="table table-borderless">
					<tr>
						<td colspan="3" style="font-size: 32px;">${vo.title }</td>
					</tr>
					<tr style="border-bottom: 1px solid;">
						<td>
							<c:if test="${!empty vo.profileImg }"><img style="width: 30px; border-radius: 100%;" src="${ctp }/resources/img/${vo.profileImg}"></c:if>
							<c:if test="${empty vo.profileImg }"><i class="fa-solid fa-user"></i></c:if>
							${vo.nickNm }
						</td>
						<td>${fn:substring(vo.date, 0, 10) }</td>
						<td>${vo.hostIp }</td>
						<td>조회수 : ${vo.likeCnt }</td>
						<td class="text-right">
							<c:if test="${sVO.idx == vo.userIdx}"><a onclick="return confirm('수정 하시겠습니까?')" href="${ctp }/review/update?idx=${vo.idx}" class="btn btn-dark">수정</a></c:if>
							<c:if test="${sVO.membership == -1 || sVO.idx == vo.userIdx}"><a onclick="return confirm('정말 삭제 하시겠습니까?')" href="${ctp }/review/reviewdel?idx=${vo.idx}" class="btn btn-dark">삭제</a></c:if>
						</td>
					</tr>
				</table>
				<div class="mt-5">${vo.content }</div>
				<div class="row mt-5">
					<div class="col"></div>
					<%-- <div class="col-2"><a href="${ctp }/review/list?pageNo=${pageNo}&reviewsrch=${reviewsrch}&kategorie=${kategorie}&srchClass=${srchClass}" class="btn btn-dark">돌아가기</a></div> --%>
					<div class="col-2"><a href="javascript:history.back()" class="btn btn-dark">돌아가기</a></div>
				</div>
				<div class="mt-3" style="background: #333; border-top: 1px solid;">
					<textarea id="reviewComment" name="reviewComment" rows="5" class="form-control mt-3" style="background: #333; border: none; " placeholder="댓글을 입력해 주세요."></textarea>
					<div class="row">
						<div class="col"></div>
						<button class="btn btn-dark mr-3 col-1" onclick="commentset()">등록</button>
					</div>
				</div>
				<div class="mt-3">
					<table style="border-top: 1px solid;" class="table table-borderless table-sm">
						<tr><td class="pt-5">별명(아이디)</td></tr>
						<tr><td>날짜</td></tr>
						<tr><td>내용</td></tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
	<script>
		function commentset() {
			if (reviewComment.value == "") return;
			
			/* if (${empty sVO.idx}) {
				alert("로그인 안됨");
				return;
			} */
			
			let data = {
				content : reviewComment.value,
				reviewIdx : ${vo.idx}
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/review/comment",
				data : data,
				success : (data) => {
					if (data == "no") {
						alert("로그인이 필요합니다.");
						return;
					}
					location.reload();
				}
			});	
		}
	</script>
	
</body>
</html>