<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DDMusic</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctp }/resources/css/main.css?v=7">
</head>
<body>
	<div style="width: 1000px;">
		<jsp:include page="/WEB-INF/views/include/modal.jsp" />
		<jsp:include page="/WEB-INF/views/include/playList.jsp" />
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		<div id="plist" style="display: none;">${vo.idx}/</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js"></script>
	
	<script>
		let idx_list = [];
		let thum_list = [];
		let title_list = [];
		let artist_list = [];
	
		let songUrl;
		let playerIndex = 0;
		let sw = 0;
	
		/* <c:forEach var="vo" items="${sPlayList}"> 
			thum_list.push("${vo.img}");
		    title_list.push("${vo.title}");
		    artist_list.push("${vo.artist}");
		</c:forEach> */
		
		idx_list.push("${vo.idx}");
		thum_list.push("${vo.img}");
	    title_list.push("${vo.title}");
	    artist_list.push("${vo.artist}");
	    
	    //리스트 세팅
	    function listSetting() {
			let idx_l = plist.innerHTML.split("/");
			let idx = plist.innerHTML.split("/")[idx_l.length - 2];
			if (idx < 0) idx = 0;
		
	 		if (!idx_list.includes(idx) {
				$.ajax({
					type : "post",
					url : "${ctp}/song/player",
					data : {idx : idx},
					success : (data) => {
						idx_list.push(data.idx);
						thum_list.push(data.img);
					    title_list.push(data.title);
					    artist_list.push(data.artist);
					}
				});
	 		}
		}
		
		// 플레이 리스트 음원 삭제
		function delList(idx) {
			let index = idx_list.indexOf(idx);
			if (index <= playerIndex) {
				playerIndex--;
				if (playerIndex < 0) playerIndex = 0;
			}

			idx_list.splice(index, 1);
			thum_list.splice(index, 1);
		    title_list.splice(index, 1);
		    artist_list.splice(index, 1);
		    
		    listSetting();
		    setList();
			
		}
	
		// 플레이 리스트에 데이터 뿌리기
		function setList() {
			let res = "";
			for (let i=0; i<thum_list.length; i++) {
				let t = title_list[i];
				let a = artist_list[i];
				if (title_list[i].length > 14) t = title_list[i].substring(0, 14) + "...";
				if (artist_list[i].length > 14) t = artist_list[i].substring(0, 14) + "...";
				
				res += "<div name='song_row' class='d-flex p-3'><div class='imgBox mr-3'><img src='" + thum_list[i] + "'></div><div><div class='playlist_t' title='" + title_list[i] + "'>" + t + "</div><div class='playlist_a' title='" + artist_list[i] + "'>" + a + "</div></div><div class='ml-auto'><button name='delete_btn' type='button' class='btn' onclick='delList(" + idx_list[i] + ")' ><i class='fa-regular fa-trash-can'></i></button></div></div>";
			}
		    
		    play_list.innerHTML = res;
		}

		// 로드
		function load() {
			let title = title_list[playerIndex].replace(/[\\\/:*?\"<>|]/g, "");
			let artist = artist_list[playerIndex].replace(/[\\\/:*?\"<>|]/g, "");
			
			let hostIndex = location.href.indexOf(location.host) + location.host.length;
			let contextPath = location.href.substring(hostIndex, location.href.indexOf("/", hostIndex + 1));
	
		    songUrl = contextPath + "/music/" + title + " - " + artist + ".mp3";
			player.src = songUrl;
		    player.load();
		    controls_title.innerHTML = title_list[playerIndex];
		    controls_artist.innerHTML = artist_list[playerIndex];
		    controls_title.title = title_list[playerIndex];
		    controls_artist.title = artist_list[playerIndex];
			play_listImg_img.src = thum_list[playerIndex].replace("50", "400");
			play_listbg.src = thum_list[playerIndex].replace("50", "2000");
			
			//로드 할 때 좋아요도 로드 해야 할 듯
			if (${empty sMid}) return;
			
			let data = {
				title : $("#controls_title").html(),
				artist : $("#controls_artist").html(),
			}
			
			$.ajax({
				type : "post",
				url : "soLikebtn.so",
				data : data,
				success : (data) => {
					if (data.includes("${sMid}")) {
						$("#like_btn1").hide();
						$("#like_btn2").show();
					}
					else {
						$("#like_btn1").show();
						$("#like_btn2").hide();
					}
				}
			});
		}
	
	
		// 플레이버튼 클릭
		play_btn.addEventListener("click", () => {
			if (controls_title == "오늘 뭐 듣지?") {
				$.ajax({
					type : "post",
					url : "${ctp}/song/randomPlay",
					success: (data) => {
						idx_list.push(data.idx);
						thum_list.push(data.img);
					    title_list.push(data.title);
					    artist_list.push(data.artist);
						load();
						sw = 1;
						
						$(play_btn).hide();
					    $(pause_btn).show();
					    player.play();
	
						setList();
							
						return;
					}
				});
			}
			
			else {
			    if (sw == 0) {
					load();
			        sw = 1;
			    }
			    
			    $(play_btn).hide();
			    $(pause_btn).show();
			    player.play();	
			}
			
		});
	
		// 일시정지
		pause_btn.addEventListener("click", () => {
		    $(play_btn).show();
		    $(pause_btn).hide();
		    player.pause();
		});
	
		//볼륨
		$("#volume_bar").on("input", () => {
			player.volume = $("#volume_bar").val() / 100;
		});
	
		// 음소거
		let temp_vol;
		$("#mute_btn1").click(() => {
			temp_vol = player.volume;
			player.volume = 0;
			volume_bar.value = 0;
			
		    $("#mute_btn1").hide();
		    $("#mute_btn2").show();
		});
	
		$("#mute_btn2").click(() => {
			player.volume = temp_vol;
			volume_bar.value = temp_vol * 100;
			
		    $("#mute_btn2").hide();
		    $("#mute_btn1").show();
		});
	
		//재생바
		$("#player").on("timeupdate", () => {
			let per = (player.currentTime / player.duration) * 100;
			$("#play_bar").val(per);
		 	
			let min_dur = 00;
			let sec_dur = 00;
			let min_cur = 00;
			let sec_cur = 00;
	
			if (!isNaN(player.duration)) {
			    min_dur = parseInt(player.duration / 60);
			    sec_dur = parseInt(player.duration % 60);
			    min_cur = parseInt(player.currentTime / 60);
			    sec_cur = parseInt(player.currentTime % 60);
			}
	
		    
		    if (min_dur < 10) {
		        min_dur = "0" + min_dur;
		    }
		    if (sec_dur < 10) {
		        sec_dur = "0" + sec_dur;
		    }
		    if (min_cur < 10) {
		        min_cur = "0" + min_cur;
		    }
		    if (sec_cur < 10) {
		        sec_cur = "0" + sec_cur;
		    }
	
		    let res = min_cur + ":" + sec_cur + " / " + min_dur + ":" + sec_dur;
		    $("#controls_time").html(res);
	
			if (${empty sMid} || ${sVO.membership == 0}) {
				if (${empty sMembership || sMembership == 0}) {
					if (player.currentTime > 60 && player.currentTime < player.duration) {
						player.currentTime = player.duration;
					}
				}
			}
		});
	
	
		// 재생바 이동
		$("#play_bar").on("change", () => {
			let point = $("#play_bar").val();
		    play_bar = point;
		    player.currentTime = point * player.duration / 100;
		});
	
		// next button
		$("#next_btn").click(() => {
			$(play_btn).hide();
		    $(pause_btn).show();
			
			playerIndex++;
			if (playerIndex >= thum_list.length) {
				playerIndex = 0;
			};
			load();
			player.play();
			$("#controls_time").html("00:00 / 00:00");
		});
	
	
		// back button
		$("#back_btn").click(() => {
			$(play_btn).hide();
		    $(pause_btn).show();
			
			playerIndex--;
			if (playerIndex <= 0) {
				playerIndex = 0;
			};
			load();
			player.play();
			$("#controls_time").html("00:00 / 00:00");
		});
	
		// 연속 재생
		$("#player").on("ended", () => {
			playerIndex++;
			if (playerIndex >= thum_list.length) {
				$(play_btn).show();
		    	$(pause_btn).hide();
				playerIndex = 0;
				sw = 0;
				player.currentTime = 0;
				return;
			}
	
			load();
			player.play();
		});
	
		//가사 모달
		$("#lyrics_btn").click(() => {
			modal_i.src = thum_list[playerIndex].replace("50","200");
			$("#modal_t").html($("#controls_title").html());
			$("#modal_a").html($("#controls_artist").html());
			
			if (play_listImg_img.src.includes("music.png")) return;
					
			let data = {
				title : $("#controls_title").html(),
				artist : $("#controls_artist").html(),
			}
			
			$.ajax({
				type : "post",
				url : "solyrics.so",
				data : data,
				success : (data) => {
					data = data.replace(/\n/g, "<br>");
					$("#modal_c").html(data);
				}
			});
			
		});
		
	</script>
	
</body>
</html>