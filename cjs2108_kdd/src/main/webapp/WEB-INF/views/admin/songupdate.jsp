<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>songupdate</title>
</head>
<body>
	<div class="mt-5">
		<h2 class="ml-5">음원정보</h2>
		<div class="sticky">
			<ul class="pagination">
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=2&pageNo=1">First</a></li>
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=2&pageNo=<c:if test="${pageNo != 1 }">${pageNo - 1 }</c:if><c:if test="${pageNo == 1 }">1</c:if> ">Previous</a></li>
			    <li class="page-item"><a class="page-link bg-secondary text-danger">${pageNo }</a></li>
			    <!-- <li class="page-item"><a class="page-link bg-dark text-warning" href="#">1</a></li>
			    <li class="page-item"><a class="page-link bg-secondary text-danger" href="#">2</a></li>
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="#">3</a></li> -->
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=2&pageNo=<c:if test="${pageNo + 1 > lastPageNo }">${pageNo }</c:if><c:if test="${pageNo + 1 <= lastPageNo }">${pageNo + 1}</c:if>">Next</a></li>
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=2&pageNo=${lastPageNo }">Last</a></li>
 	 		</ul>
		</div>
	    <div class="sticky2">
	    	<input class="btn btn-warning" type="button" value="추가" data-toggle="modal" data-target="#addSongModal">
	    	<input class="btn btn-warning" type="button" value="변경사항 적용" onclick="commit()">
    	</div>
		<div class="mt-3">
			<form method="post" name="myform">
			<div>수정 하려는 항목을 더블 클릭 하세요!</div>
				<table class="table table-bordered" style="width: 2000px;">
					<thead class="thead-dark">
						<tr>
							<th class="text-right" style="width: 50px;">#</th>
							<th style="width: 80px;">썸네일</th>
							<th>제목</th>
							<th>가수</th>
							<th>앨범명</th>
							<th>발매일</th>
							<th>장르</th>
							<th>작곡</th>
							<th>작사</th>
							<th>편곡</th>
							<th>가사</th>
						</tr>
					</thead>
                    <c:forEach var="vo" items="${vos }" varStatus="st">
	                    <tr>
	                        <td class="text-right align-middle">${vo.idx}</td>
	                        <td class="text-center"><div class="imgBox"><img src="${vo.img }" alt=""></div></td>
	                        <td class="align-middle" style="overflow: hidden;" title="${vo.title }">${fn:substring(vo.title, 0, 35) }</td>
	                        <td class="align-middle" title="${vo.artist }">${vo.artist }</td>
	                        <td class="align-middle" ondblclick="updt_album(${vo.idx}, `${vo.album }`)" title="${vo.album }"><div class="ho" id="album_${vo.idx }" >${fn:substring(vo.album, 0, 5) }<c:if test="${!empty vo.album }">...</c:if></div></td>
	                        <td class="align-middle" ondblclick="updt_releaseDate(${vo.idx}, `${vo.releaseDate }`)" title="${vo.releaseDate }"><div class="ho" id="releaseDate_${vo.idx }" >${fn:substring(vo.releaseDate, 0, 5) }<c:if test="${!empty vo.album }">...</c:if></div></td>
	                        <td class="align-middle" ondblclick="updt_genre(${vo.idx}, `${vo.genre }`)" title="${vo.genre }"><div class="ho" id="genre_${vo.idx }" >${fn:substring(vo.genre, 0, 5) }<c:if test="${!empty vo.album }">...</c:if></div></td>
	                        <td class="align-middle" ondblclick="updt_music(${vo.idx}, `${vo.music }`)" title="${vo.music }"><div class="ho" id="music_${vo.idx }" >${fn:substring(vo.music, 0, 5) }<c:if test="${!empty vo.album }">...</c:if></div></td>
	                        <td class="align-middle" ondblclick="updt_words(${vo.idx}, `${vo.words }`)" title="${vo.words }"><div class="ho" id="words_${vo.idx }" >${fn:substring(vo.words, 0, 5) }<c:if test="${!empty vo.album }">...</c:if></div></td>
	                        <td class="align-middle" ondblclick="updt_arranger(${vo.idx}, `${vo.arranger }`)" title="${vo.arranger }"><div class="ho" id="arranger_${vo.idx }" >${fn:substring(vo.arranger, 0, 5) }<c:if test="${!empty vo.album }">...</c:if></div></td>
	                        <td class="align-middle text-center">
	                        	<div class="ho" onclick="more(${vo.idx })" data-toggle="modal" data-target="#myModal">더보기</div>
                        	</td>
	                    </tr>
                    </c:forEach>
                </table>
                <input type="hidden" name="sw" value="${sw }" >
                <input type="hidden" id="demo" name="item">
                <input type="hidden" name="pageNo" value="${pageNo }">
            </form>
		</div>
	</div>
</body>
</html>