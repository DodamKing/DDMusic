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
    <style>
    	div#ck img {
    		max-width: 100%;
    		max-height: auto;
    	}
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
		<div class="container">
			<div class="card-body" style="padding-bottom: 300px; background: #222;">
				<h2 class="mt-5 mb-5">사용자 리뷰</h2>
				<div class="row">
					<div class="col-2"><a href="${ctp }/review/list" class="btn btn-dark mb-3">목록</a></div>
					<div class="col"></div>
					<div class="col-2 text-right">
						<c:if test="${sVO.idx == vo.userIdx}"><a onclick="return confirm('수정 하시겠습니까?')" href="${ctp }/review/update?idx=${vo.idx}" class="btn btn-dark">수정</a></c:if>
						<c:if test="${sVO.membership == -1 || sVO.idx == vo.userIdx}"><a onclick="return confirm('정말 삭제 하시겠습니까?')" href="${ctp }/review/reviewdel?idx=${vo.idx}" class="btn btn-dark">삭제</a></c:if>
					</div>
				</div>
				<div style="border-bottom: 1px solid;">
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
						</tr>
					</table>
					<div id="ck" class="mt-5">${vo.content }</div>
				</div>
				<h4 class="mt-3">댓글 ${fn:length(vos) }</h4>
				<div class="mt-3" style="background: #333; border-top: 1px solid;">
					<textarea id="reviewComment" name="reviewComment" rows="5" maxlength="500" class="form-control mt-3" style="background: #333; border: none; color: #bbb;" placeholder="댓글을 입력해 주세요."></textarea>
					<div class="row">
						<div class="col"></div>
						<button class="btn btn-dark mr-3 col-1" onclick="commentset()">등록</button>
					</div>
				</div>
				<div class="mt-3">
					<table style="border-top: 1px solid;" class="table table-borderless table-sm">
						<c:forEach var="vo" items="${vos }">
							<tr>
								<td class="pt-3"><font color="#ccc"><b>${vo.nickNm}(${fn:substring(vo.userId, 0, 4)}****)</b></font></td>
								<c:if test="${sVO.idx == vo.userIdx }">
									<td id="update1_${vo.idx }" class="text-right ho pt-3" onclick="goupdate('${vo.idx}', '${fn:replace(vo.content, enter, '엔454%$#^&*@!123터')}')">수정</td>
									<td id="update2_${vo.idx }" style="display: none;" class="text-right pt-3">
										<span class="ho" onclick="commentupdate(${vo.idx})">수정</span>
										<span>|</span>
										<span class="ho" onclick="commentdel(${vo.idx})">삭제</span>
										<span>|</span>
										<span class="ho" onclick="javascript:location.reload();">취소</span>
									</td>
								</c:if>
								<c:if test="${sVO.membership == -1 }">
									<c:if test="${sVO.idx != vo.userIdx }"><td class="text-right ho pt-3" ></td></c:if>
									<td class="text-right ho pt-3 close" onclick="commentdel(${vo.idx})">&times;</td>
								</c:if>
							</tr>
							<tr><td colspan="3"><font color="#444">${vo.date}</font></td></tr>
							<tr><td id="content_${vo.idx }" colspan="3" class="pb-3" style="border-bottom: 1px solid #333;">${fn:replace(vo.content, enter, "<br>") }</td></tr>
						</c:forEach>
					</table>
				</div>
				<div class="pull-right"><a href="${ctp }/review/list" class="btn btn-dark mb-3">목록</a></div>
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
		
		function commentdel(idx) {
			if (confirm("삭제 하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "${ctp}/review/commentdel",
					data : {idx : idx},
					success : () => {
						location.reload();
					}
				});
			}
		}
		
		function goupdate(idx, content) {
			let res = '<textarea id="commentupdate_' + idx + '" name="commentupdate" rows="5" maxlength="500" class="form-control mt-3" style="background: #333; border: none; color: #bbb;">';
			res += content.replaceAll("엔454%$#^&*@!123터", "\n");
			res += "</textarea>";
			$("#content_" + idx).html(res);
			
			let len = $("#commentupdate_" + idx).val().length;
			$("#commentupdate_" + idx).focus();
			$("#commentupdate_" + idx)[0].setSelectionRange(len, len);
			
			$("#update1_" + idx).hide();
			$("#update2_" + idx).show();
		}
		
		function commentupdate(idx) {
			let data = {
				idx : idx,
				content : $("#commentupdate_" + idx).val()
			}
			if (confirm("수정 하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "${ctp}/review/commentupdate",
					data : data,
					success : () => {
						location.reload();
					}
				});
			}
		}
		
	</script>
	
</body>
</html>