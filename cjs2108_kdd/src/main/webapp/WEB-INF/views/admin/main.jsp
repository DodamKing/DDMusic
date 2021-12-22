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
	<title>관리자</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
		nav {
			background: black;
			color: white;
			position: fixed;
		    width: 200px;
		    height: 100%;
		    left: 0px;
		    top: 0px;
		    overflow-y: auto;
		    margin-top: 0px;
		    padding-top: 0px;
		    padding-bottom: 200px;
		    z-index: 999;
		}
		
		section {
			position: absolute;
			left: 200px;
			padding-bottom: 100px;
		}
		
		li {
			list-style: none;
			font-size: 20px;
			padding: 10px 0;
		}
		
		a {
		    text-decoration: none;
		    color: inherit;
		    opacity: 1;
		}
		
		a:hover {
		    text-decoration: none;
		    color: inherit;
		    opacity: 0.7;
		}
	</style>
</head>
<body>
	<nav>
		<div class="card-body nav-w">
	        <ul>
	            <li><a href="admin/main">메인</a></li>
	            <li><a href="admi/main?sw=1">회원관리</a></li>
                <li><a href="admin/main?sw=2">음원관리</a></li>
            </ul>
    	</div>
	</nav>
	<section>
		<c:if test="${sw == 0 }">
			<div class="container mt-5">
				<h2>업데이트 필요한 곡</h2>
				<div>
				<c:set var="ok" value="0" />
				<c:forEach var="vo" items="${vos }" varStatus="st">
					<table>
						<c:if test="${vo.idx == 0 }">
							<tr>
								<td>${vo.title } - ${vo.artist }</td>
								<c:set var="ok" value="${ok + 1 }" />
							</tr>
						</c:if>
					</table>
				</c:forEach>
				<c:if test="${ok == 0 }">업데이트가 필요한 곡이 없습니다.</c:if>
				</div>
			</div>
		</c:if>
		<c:if test="${sw == 1 }">
			<div class="container mt-5">
				<h2>회원관리</h2>
				<div>준비중 입니다.</div>
			</div>
		</c:if>
		<c:if test="${sw == 2 }">
			<div class="container mt-5">
				<h2>음원관리</h2>
				<div>
					<ul class="pagination">
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="adminMain.ad?sw=2&pageNo=1">First</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="adminMain.ad?sw=2&pageNo=<c:if test="${pageNo != 1 }">${pageNo - 1 }</c:if><c:if test="${pageNo == 1 }">1</c:if> ">Previous</a></li>
					    <li class="page-item"><a class="page-link bg-secondary text-danger">${pageNo }</a></li>
					    <!-- <li class="page-item"><a class="page-link bg-dark text-warning" href="#">1</a></li>
					    <li class="page-item"><a class="page-link bg-secondary text-danger" href="#">2</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="#">3</a></li> -->
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="adminMain.ad?sw=2&pageNo=<c:if test="${pageNo + 1 > lastPageNo }">${pageNo }</c:if><c:if test="${pageNo + 1 <= lastPageNo }">${pageNo + 1}</c:if>">Next</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="adminMain.ad?sw=2&pageNo=${lastPageNo }">Last</a></li>
		 	 		</ul>
				</div>
			    <div><input class="btn btn-warning" type="button" value="변경사항 적용" onclick="commit()"></div>
				<div>
					<form method="post" action="adminSongUpdate.ad" name="myform">
						<table class="table table-bordered" style="width: 3000px;">
							<thead class="thead-dark">
								<tr>
									<th class="text-right">#</th>
									<th>썸네일</th>
									<th>제목</th>
									<th>가수</th>
									<th>앨범명</th>
									<th>발매일</th>
									<th>작곡</th>
									<th>장르</th>
									<th>작사</th>
									<th>편곡</th>
									<th>가사</th>
									<th>좋아요</th>
								</tr>
							</thead>
		                    <c:forEach var="vo" items="${vos }" varStatus="st">
			                    <tr>
			                        <td class="text-right align-middle">${vo.idx}</td>
			                        <td class="text-center"><div class="imgBox"><img src="${vo.img }" alt=""></div></td>
			                        <td class="align-middle">${vo.title }</td>
			                        <td class="align-middle">${vo.artist }</td>
			                        <td class="align-middle" ondblclick="updt_album(${vo.idx})"><div id="album_${vo.idx }" >${vo.album }</div></td>
			                        <td class="align-middle" ondblclick="updt_releaseDate(${vo.idx})"><div id="releaseDate_${vo.idx }" >${vo.releaseDate }</div></td>
			                        <td class="align-middle" ondblclick="updt_genre(${vo.idx})"><div id="genre_${vo.idx }" >${vo.genre }</div></td>
			                        <td class="align-middle" ondblclick="updt_music(${vo.idx})"><div id="music_${vo.idx }" >${vo.music }</div></td>
			                        <td class="align-middle" ondblclick="updt_words(${vo.idx})"><div id="words_${vo.idx }" >${vo.words }</div></td>
			                        <td class="align-middle" ondblclick="updt_arranger(${vo.idx})"><div id="arranger_${vo.idx }" >${vo.arranger }</div></td>
			                        <td class="align-middle text-center">
			                        	<c:if test="${empty vo.lyrics }">없음</c:if>
			                        	<c:if test="${!empty vo.lyrics }">더보기</c:if>
		                        	</td>
			                        <td class="align-middle text-center">${vo.likeCnt }</td>
			                    </tr>
		                    </c:forEach>
		                </table>
		                <input type="hidden" name="sw" value="${sw }" >
		                <input type="hidden" id="demo" name="item">
		                <input type="hidden" name="pageNo" value="${pageNo }">
	                </form>
				</div>
			</div>
		</c:if>
	</section>
	
	<script>
		var item = "";
	
		function updt_album(idx) {
			let albumId = "album_" + idx;
			let temp = $("#" + albumId).html();
			$("#" + albumId).html("<input class='form-control' type='text' name='" + albumId +"' value='" + temp + "' autofocus >");
			
			item += albumId + "/";
		}
	
		function updt_releaseDate(idx) {
			let releaseDateId = "releaseDate_" + idx;
			let temp = $("#" + releaseDateId).html();
			$("#" + releaseDateId).html("<input class='form-control' type='text' name='" + releaseDateId +"' value='" + temp + "' autofocus >");
			
			item += releaseDateId + "/";
		}
		
		function updt_genre(idx) {
			let genreId = "genre_" + idx;
			let temp = $("#" + genreId).html();
			$("#" + genreId).html("<input class='form-control' type='text' name='" + genreId +"' value='" + temp + "' autofocus >");
			
			item += genreId + "/";
		}
		
		function updt_music(idx) {
			let musicId = "music_" + idx;
			let temp = $("#" + musicId).html();
			$("#" + musicId).html("<input class='form-control' type='text' name='" + musicId +"' value='" + temp + "' autofocus >");
			
			item += musicId + "/";
		}
		
		function updt_words(idx) {
			let wordsId = "words_" + idx;
			let temp = $("#" + wordsId).html();
			$("#" + wordsId).html("<input class='form-control' type='text' name='" + wordsId +"' value='" + temp + "' autofocus >");
			
			item += wordsId + "/";
		}
		
		function updt_arranger(idx) {
			let arrangerId = "arranger_" + idx;
			let temp = $("#" + arrangerId).html();
			$("#" + arrangerId).html("<input class='form-control' type='text' name='" + arrangerId +"' value='" + temp + "' autofocus >");
			
			item += arrangerId + "/";
		}
		
		function commit() {
			if (item.length == 0) return;
			if (confirm("변경 사항을 저장하시겠습니까?")) {
				demo.value = item;
				myform.submit();	
			}
		}
		
		window.onkeydown = (e) => {
			if (e.keyCode == 27) {
				location.reload();
			}
		}
	</script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>