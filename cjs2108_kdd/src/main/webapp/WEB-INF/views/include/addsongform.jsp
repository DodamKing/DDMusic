<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />

<style>
	#addSongModal {
		color: white;
	}
</style>

<div class="modal" id="addSongModal">
	<div class="modal-dialog modal-dialog-scrollable">
  		<div class="modal-content" style="background: black;">
      
	        <!-- Modal Header -->
	        <div class="container mt-3">
	        	<h2>새로운 곡 추가</h2>
	        </div>
      		<div class="modal-header">
      			추가할 곡의 정보를 입력하세요.
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
		        <div class="form-group">
		  			<h5><b>앨범 이미지 주소</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="img" class="form-control" type="text" placeholder="이미지 파일 주소를 입력하세요."></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>노래 제목</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="title" class="form-control" type="text" placeholder="노래 제목을 입력하세요."></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>가수</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="artist" class="form-control" type="text" placeholder="가수명을 입력하세요."></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>앨범명</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="album" class="form-control" type="text" placeholder="앨범명"></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>발매일</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="releaseDate" class="form-control" type="text" placeholder="발매일"></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>장르</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="genre" class="form-control" type="text" placeholder="장르"></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>작곡</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="music" class="form-control" type="text" placeholder="작곡"></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>작사</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="words" class="form-control" type="text" placeholder="작사"></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>편곡</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="arranger" class="form-control" type="text" placeholder="편곡"></div>
		        </div>
		        <div class="form-group">
		  			<h5 class="text-white"><b>가사</b></h5>
		          	<div id="modal_c" class="mt-3" style="color: gray;"><textarea id="lyrics" class="form-control" placeholder="가사"></textarea></div>
		        </div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	      		<button type="button" class="btn btn-danger" onclick="insertSong()">등록</button>
	      		<button id="close_btn" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
        
  		</div>
	</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function insertSong() {
		if (img.value == "") {
			alert("이미지 주소를 입력하세요.");
			return;
		}
		else if (title.value == "") {
			alert("노래 제목을 입력하세요.");
			return;
		}
		else if (artist.value == "") {
			alert("가수명을 입력하세요.");
			return;
		}
		
		let data = {
			img : img.value,
			title : title.value,
			artist : artist.value,
			album : album.value,
			releaseDate : releaseDate.value,
			genre : genre.value,
			music : music.value,
			words : words.value,
			arranger : arranger.value,
			lyrics : lyrics.value
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/admin/insertsong",
			data : data,
			success : (data) => {
				if (data == "no") {
					alert("이미 등록된 곡 입니다.");
					return;
				}
				alert("정상 등록 되었습니다.");
				location.reload();
			}
		});
	}
	
	$("#close_btn").click(() => {
		img.value = "";
		title.value = "";
		artist.value = "";
		album.value = "";
		releaseDate.value = "";
		genre.value = "";
		music.value = "";
		words.value = "";
		arranger.value = "";
		lyrics.value = "";
	});
</script>