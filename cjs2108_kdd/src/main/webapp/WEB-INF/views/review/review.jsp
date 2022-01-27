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
	<title>DD Music 사용자 리뷰</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
    <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    	
    	.sticky {
			position: fixed;
			top: 0px;
			right: 10px;
		}

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
		<div class="container">
			<div class="card-body" style="padding-bottom: 300px;">
				<h2 class="mt-5 mb-5">사용자 리뷰</h2>
				<table class="table">
					<tr class="">
						<td colspan="6">
							<form id="myform" action="${ctp }/review/srch">
								<div class="input-group mb-3">
									<button type="button" class="btn btn-dark  mr-2" onclick="location.href='${ctp}/review/list'">목록</button>
									<button type="button" class="btn btn-dark" onclick="goWrite()">글쓰기</button>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<select name="kategorie" class="custom-select">
										<option value="">전체</option>
										<option value="공지" <c:if test="${kategorie == '공지' }">selected</c:if>>공지</option>
										<option value="자유" <c:if test="${kategorie == '자유' }">selected</c:if>>자유</option>
										<option value="건의" <c:if test="${kategorie == '건의' }">selected</c:if>>건의</option>
										<option value="버그" <c:if test="${kategorie == '버그' }">selected</c:if>>버그</option>
										<option value="신청곡" <c:if test="${kategorie == '신청곡' }">selected</c:if>>신청곡</option>
									</select>
									<div class="input-group-prepend">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    							</div>
	    								<select name="srchClass" class="custom-select">
											<option value="">-- 선택 --</option>
											<option value="title">제목</option>
											<option value="content">내용</option>
											<option value="nickNm">작성자</option>
											<option value="all">제목 + 내용</option>
										</select>
										<input id="reviewsrch" name="reviewsrch" type="text" class="form-control" placeholder="사용자 리뷰 검색" maxlength="30">
								  		<div class="input-group-append">
									    	<button id="reviewsrch_btn" class="btn btn-dark" type="button">검색</button>
								  		</div>
								  		<%-- <input type="hidden" name="pageNo" value="${pageNo }"> --%>
								</div>
					  		</form>
						</td>
					</tr>
					<tr>
						<td class="text-center">번호</td>
						<td class="text-center">분류</td>
						<td class="text-center">제목</td>
						<td class="text-center">작성자</td>
						<td class="text-center">작성일</td>
						<td class="text-center">조회</td>
					</tr>
					<c:forEach var="vo" items="${vos }">
						<tr>
							<td class="text-center">${start }</td>
							<td class="text-center">
								<c:if test="${vo.kategorie == '공지'}"><font color="red">${vo.kategorie }</font></c:if>
								<c:if test="${vo.kategorie != '공지'}">${vo.kategorie }</c:if>
							</td>
							<td class="ho" onclick="location.href='${ctp}/review/${vo.idx }?pageNo=${pageNo}&kategorie=${kategorie}&srchClass=${srchClass}'">
								<c:if test="${vo.kategorie == '공지'}"><font color="yellow">${vo.title }</font> <c:if test="${vo.commentCnt != 0 }"><font color="red">(${vo.commentCnt })</font></c:if></c:if>
								<c:if test="${vo.kategorie != '공지'}">${vo.title } <c:if test="${vo.commentCnt != 0 }"><font color="red">(${vo.commentCnt })</font></c:if></c:if>
							</td>
							<td class="text-center">${vo.nickNm }</td>
							<td class="text-center">${fn:substring(vo.date, 0, 10) }</td>
							<td class="text-center">${vo.likeCnt}</td>
						</tr>
						<c:set var="start" value="${start - 1 }" />
					</c:forEach>
				</table>
				<div class="row">
					<div class="col"></div>
					<ul class="pagination col">
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review/list?pageNo=1&kategorie=${kategorie}&srchClass=${srchClass}">First</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review/list?pageNo=<c:if test="${pageNo != 1 }">${pageNo - 1 }</c:if><c:if test="${pageNo == 1 }">1</c:if>&kategorie=${kategorie}&srchClass=${srchClass}">Previous</a></li>
					    <c:forEach var="i" begin="1" end="${lastPageNo }" >
					    	<%-- <c:if test="${i < pageNo }">
					    		<li class="page-item"><a class="page-link bg-secondary text-warning" href="${ctp }/review/list?pageNo=${i }&kategorie=${kategorie}&srchClass=${srchClass}">${i }</a></li>
					    	</c:if> --%>
					    	<c:if test="${i == pageNo }">
							    <li class="page-item"><a class="page-link bg-secondary text-danger" href="${ctp }/review/list?pageNo=${i }&kategorie=${kategorie}&srchClass=${srchClass}">${i }</a></li>
					    	</c:if>
					    	<c:if test="${i != pageNo }">
							    <li class="page-item"><a class="page-link bg-secondary text-warning" href="${ctp }/review/list?pageNo=${i }&kategorie=${kategorie}&srchClass=${srchClass}">${i }</a></li>
					    	</c:if>
					    </c:forEach>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review/list?pageNo=<c:if test="${pageNo + 1 > lastPageNo }">${pageNo }</c:if><c:if test="${pageNo + 1 <= lastPageNo }">${pageNo + 1}</c:if>&kategorie=${kategorie}&srchClass=${srchClass}">Next</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review/list?pageNo=${lastPageNo }&kategorie=${kategorie}&srchClass=${srchClass}">Last</a></li>
		 	 		</ul>
		 	 		<div class="col"></div>
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
		function goWrite() {
			if (${sVO == null}) {
				if (confirm("로그인이 필요합니다. \n로그인 페이지로 이동 하시겠습니까?")) {
					location.href="${ctp}/user/login?flag=write"
				}
				return;
			}
			location.href="${ctp}/review/write"
		}
		
		// 검색 내용 없을 때 엔터 막기
		$("#reviewsrch").keydown((e) => {
			if (e.keyCode == 13) {
				if ($("#reviewsrch").val().trim() == "") {
					e.preventDefault();
				}
			}
		});
		
		// 검색 내용 없을 때 버튼 클릭 비활성
		$("#reviewsrch_btn").click((e) => {
			if ($("#reviewsrch").val().trim() == "") {
				return;
			}
			
			if ($("select[name='srchClass']").val() == "") {
				alert("검색할 항목을 선택해 주세요.");
				return;
			}
			
			$("#myform").submit();
		});
		
		//카테고리 
		$("select[name='kategorie']").change(() => {
			location.href = "${ctp}/review/list?kategorie=" + $("select[name='kategorie']").val();
		});
		
	</script>
	
</body>
</html>