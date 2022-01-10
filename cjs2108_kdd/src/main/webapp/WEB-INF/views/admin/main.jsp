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
		}
		
		section {
			margin-left: 250px;
			/* padding-bottom: 100px; */
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
		
		.ho:hover {
			cursor: pointer;
		}
		
		.sticky {
			position: fixed;
			top: 0px;
			right: 10px;
		}

		.sticky2 {
			position: fixed;
			top: 60px;
			right: 10px;
		}
	</style>
</head>
<body>
	<nav>
		<div class="card-body nav-w">
	        <ul>
	            <li><a href="${ctp }/admin/main?sw=0">업데이트</a></li>
	            <li><a href="${ctp }/admin/main?sw=1">회원관리</a></li>
                <li><a href="${ctp }/admin/main?sw=2">음원관리</a></li>
                <li><a href="${ctp }/admin/main?sw=3">파일관리</a></li>
            </ul>
    	</div>
	</nav>
	<section>
		<jsp:include page="/WEB-INF/views/include/modal.jsp" />
		<c:if test="${sw == 0 }">
			<jsp:include page="/WEB-INF/views/admin/dbupload.jsp" />
		</c:if>
		<c:if test="${sw == 1 }">
			<jsp:include page="/WEB-INF/views/admin/userupdate.jsp" />
		</c:if>
		<c:if test="${sw == 2 }">
			<jsp:include page="/WEB-INF/views/admin/songupdate.jsp" />
		</c:if>
		<c:if test="${sw == 3 }">
			<jsp:include page="/WEB-INF/views/admin/fileupload.jsp" />
		</c:if>
		
	</section>
	
	<script>
		var item = "";
	
		function updt_album(idx, album) {
			let albumId = "album_" + idx;
			$("#" + albumId).html("<input class='form-control' type='text' name='" + albumId +"' value='" + album + "' autofocus >");
			
			item += albumId + "/";
		}
	
		function updt_releaseDate(idx, releaseDate) {
			let releaseDateId = "releaseDate_" + idx;
			$("#" + releaseDateId).html("<input class='form-control' type='text' name='" + releaseDateId +"' value='" + releaseDate + "' autofocus >");
			
			item += releaseDateId + "/";
		}
		
		function updt_genre(idx, genre) {
			let genreId = "genre_" + idx;
			$("#" + genreId).html("<input class='form-control' type='text' name='" + genreId +"' value='" + genre + "' autofocus >");
			
			item += genreId + "/";
		}
		
		function updt_music(idx, music) {
			let musicId = "music_" + idx;
			$("#" + musicId).html("<input class='form-control' type='text' name='" + musicId +"' value='" + music + "' autofocus >");
			
			item += musicId + "/";
		}
		
		function updt_words(idx, words) {
			let wordsId = "words_" + idx;
			$("#" + wordsId).html("<input class='form-control' type='text' name='" + wordsId +"' value='" + words + "' autofocus >");
			
			item += wordsId + "/";
		}
		
		function updt_arranger(idx, arranger) {
			let arrangerId = "arranger_" + idx;
			$("#" + arrangerId).html("<input class='form-control' type='text' name='" + arrangerId +"' value='" + arranger + "' autofocus >");
			
			item += arrangerId + "/";
		}
		
		// 음원 정보 변경
		function commit() {
			if (item.length == 0) return;
			if (confirm("변경 사항을 저장하시겠습니까?")) {
				demo.value = item;
				myform.submit();	
			}
		}
		
		// 가사 더 보기
		function more(idx) {
			
			let data = {
				idx : idx
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/lyrics",
				data : data,
				success : (data) => {
					modal_i.src = data.img;
					$("#modal_t").html(data.title);
					$("#modal_a").html(data.artist);
					let lyrics = data.lyrics.replace(/\n/g, "<br>");
					$("#modal_c").html(lyrics);
				}
			});
		}
		
		// 회원 탈퇴
		function userdel(idx) {
			if (confirm("정말 탈퇴 처리 하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "${ctp}/admin/userdel",
					data : {idx : idx},
					success : () => {
						alert("정상 탈퇴 처리 되었습니다.");
						location.reload();
					}
				});
			}
		}
		
		// 음원 정보(이미지, 제목, 가수) 디비 저장
		function adddb(img, title, artist) {
			if (confirm(title + " - " + artist + "를 데이터베이스에 추가 하시겠습니까?")) {
				let data = {
					img : img,
					title : title,
					artist : artist
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/admin/addsong",
					data : data,
					success : () => {
						location.reload();
						alert(title + "-" + artist + "가 정상적으로 데이터베이스에 등록 되었습니다.");
					}
				});
			}
		}
		
		// 모두 추가
		function addall() {
			if (confirm("모든 내용을 데이터베이스에 추가 하시겠습니까?"))
			$.ajax({
				type : "post",
				url : "${ctp}/admin/addsongall",
				success : () => {
					location.reload();
				}
			});
		}

		// 음원 재생
		function play1(title, artist) {
			title = title.replace(/[\\\/:*?\"<>|]/g, "");
			artist = artist.replace(/[\\\/:*?\"<>|]/g, "");
			
			let hostIndex = location.href.indexOf(location.host) + location.host.length;
			let contextPath = location.href.substring(hostIndex, location.href.indexOf("/", hostIndex + 1));
	
		    songUrl = contextPath + "/music/" + title + " - " + artist + ".mp3";
		    
		    $.get(songUrl).done(() => {
				player.src = songUrl;
			    player.load();
			    player.play();
		    }).fail(() => {
		    	alert("파일이 없습니다.");
		    });
		}
		
		//미리 듣기
		function play2() {
			if ($("#fup")[0].files[0] == null) {
				alert("파일을 선택해 주세요.");
				return;
			}
			
			let reader = new FileReader();
		    reader.readAsDataURL($("#fup")[0].files[0]);
		    reader.onload = (e) => {
		    	$("#player").prop("src", e.target.result);
		    	player.play();
		    };
		}
		
		// 파일 업로드
		function fileupload(idx) {
			let ext = $("#fup").val().split(".").pop().toLowerCase();
			if (ext == "") {
				alert("파일을 선택하세요.");
				return;
			}
			if (ext == "mp3") {
				if (confirm("현재 파일을 업로드 하시겠습니까?")) {
					let data = new FormData();
					data.append("idx", idx);
					data.append("file", $("#fup")[0].files[0]);
					
					$.ajax({
						type : "post",
						url : "${ctp}/admin/upload",
						contentType : false,
						processData : false,
						data : data,
						success : () => {
							alert("파일이 업로드 되었습니다.");
						}
					})
				}
				return;
			}
			alert("mp3 파일만 업로드 가능 합니다.")
		}
		
		// esc 이벤트
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