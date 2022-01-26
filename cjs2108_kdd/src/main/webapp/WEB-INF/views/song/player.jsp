<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DDMusic </title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctp }/resources/css/main.css?v=1">
</head>
<body>
	<div style="width: 1000px;">
		<jsp:include page="/WEB-INF/views/include/modal.jsp" />
		<jsp:include page="/WEB-INF/views/include/playList.jsp" />
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
	<script>
		let idx_list = [];
		let thum_list = [];
		let title_list = [];
		let artist_list = [];
		
		let songUrl;
		let playerIndex = 0;
		let playerIndex_ = 0;
		let sw = 0;
		let pisw1 = 0;
		let pisw2 = 0;
		let repeat = 0;
		let shuffle = 0;
	
		<c:if test="${!empty vos }">
			<c:forEach var="vo" items="${vos}">
				idx_list.push(${vo.idx});
				thum_list.push("${vo.img}");
			    title_list.push("${vo.title}");
			    artist_list.push("${vo.artist}");
			</c:forEach>
		</c:if>

		<c:if test="${!empty vo }">
			idx_list.push(${vo.idx});
			thum_list.push("${vo.img}");
		    title_list.push("${vo.title}");
		    artist_list.push("${vo.artist}");
		</c:if>
		
		<c:if test="${play == 1}">
			if (sw == 0) {
				load();
		        sw = 1;
		    }
		    
		    $(play_btn).hide();
		    $(pause_btn).show();
		    player.play();
		</c:if>
		
		//재생수 증가
		function playCntUp(idx) {
			$.ajax({
				type : "post",
				url : "${ctp}/song/playcntup",
				data : {songIdx : idx}
			});
		}
	    
	    //리스트 세팅
	    function addList(data) {
	    	if (!idx_list.includes(data.idx)) {
				idx_list.push(data.idx);
				thum_list.push(data.img);
			    title_list.push(data.title);
			    artist_list.push(data.artist);
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
		    
		    setList();
		    
		    //플레이리스트에서도 삭제
		   /*  if ("${listIdx}" != "") {
			    let data = {
			    	idx : "${listIdx}",	
		    		songIdx : idx
			    }
			    
			    $.ajax({
			    	type : "post",
			    	url : "${ctp}/user/dellist",
			    	data : data
			    });
		    } */
		}

		// 원하는 곡 재생
		function startThis(idx) {
			let index = idx_list.indexOf(idx);
			playerIndex = index;
			load();
			$(play_btn).hide();
		    $(pause_btn).show();
			player.play();
		}
	
		// 플레이 리스트에 데이터 뿌리기
		function setList() {
			let res = "";
			for (let i=0; i<thum_list.length; i++) {
				let t = title_list[i];
				let a = artist_list[i];
				if (title_list[i].length > 13) t = title_list[i].substring(0, 13) + "...";
				if (artist_list[i].length > 13) a = artist_list[i].substring(0, 13) + "...";
				
				res += "<div id='p_" + idx_list[i] + "' class='d-flex p-3' tabindex='0'><div class='imgBox mr-3'><img src='" + thum_list[i] + "' title='재생' onclick='startThis(" + idx_list[i] + ")'></div><div><div class='playlist_t' title='" + title_list[i] + "'>" + t + "</div><div class='playlist_a' title='" + artist_list[i] + "'>" + a + "</div></div><div class='ml-auto'><button name='delete_btn' type='button' class='btn' onclick='delList(" + idx_list[i] + ")' ><i class='fa-regular fa-trash-can'></i></button></div></div>";
			}
		    
		    play_list.innerHTML = res;
		    listCnt.innerHTML = idx_list.length + " 곡";
		}

		// 로드
		function load() {
			let title = title_list[playerIndex].replace(/[\\\/:*?\"<>|]/g, "");
			let artist = artist_list[playerIndex].replace(/[\\\/:*?\"<>|]/g, "");
			
			let hostIndex = location.href.indexOf(location.host) + location.host.length;
			let contextPath = location.href.substring(hostIndex, location.href.indexOf("/", hostIndex + 1));
	
		    songUrl = contextPath + "/music/" + title + " - " + artist + ".mp3";
		    
		    $.get(songUrl).fail(() => {
		    	next_btn.click();
		    });
		    
			player.src = songUrl;
		    player.load();
		    controls_title.innerHTML = title_list[playerIndex];
		    if (title_list[playerIndex].length >10) controls_title.innerHTML = "<marquee scrollamount=3>" + title_list[playerIndex] + "</marquee>";
		    controls_artist.innerHTML = artist_list[playerIndex];
		    controls_title.title = title_list[playerIndex];
		    controls_artist.title = artist_list[playerIndex];
			play_listImg_img.src = thum_list[playerIndex].replace("50", "400");
			play_listbg.src = thum_list[playerIndex].replace("50", "2000");
			
			
			//타이틀 변경
			document.title = "DDMusic " + title_list[playerIndex] + " - " + artist_list[playerIndex];
			
			// 현재 재생 음악 포커스
			focus_cur()
			
			//볼륨
			player.volume = my_vol;
			
			// 재생 수 증가
			playCntUp(idx_list[playerIndex]);
			
			//로드 할 때 좋아요도 로드 해야 할 듯
			if (${empty sMid}) return;
			
			$.ajax({
				type : "post",
				url : "${ctp}/song/likebtn",
				data : {idx : idx_list[playerIndex]},
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
		let my_vol = player.volume;
		$("#volume_bar").on("input", () => {
			player.volume = $("#volume_bar").val() / 100;
			my_vol = player.volume; 
		});
	
		// 음소거
		let temp_vol;
		$("#mute_btn1").click(() => {
			temp_vol = player.volume;
			player.volume = 0;
			my_vol = player.volume;
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
			if (repeat == 2) playerIndex--;
			if (playerIndex >= thum_list.length) {
				$(play_btn).show();
		    	$(pause_btn).hide();
				playerIndex = 0;
				sw = 0;
				player.currentTime = 0;
				
				if (repeat == 1) {
					load();
					player.play();
				}
				
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
			
			$.ajax({
				type : "post",
				url : "${ctp}/song/lyrics",
				data : {idx : idx_list[playerIndex]},
				success : (data) => {
					data = data.replace(/\n/g, "<br>");
					$("#modal_c").html(data);
				}
			});
			
		});
		
		// 좋아요 버튼 이벤트
		$("#like_btn1").click(() => {
    		$("#like_btn1").hide();
    		$("#like_btn2").show();
    		
    		if (${empty sMid}) return;

    		$.ajax({
    			type : "post",
    			url : "${ctp}/song/like",
    			data : {idx : idx_list[playerIndex]},
    		});
    	}); 

		$("#like_btn2").click(() => {
    		$("#like_btn2").hide();
    		$("#like_btn1").show();
    		
    		if (${empty sMid}) return;

    		$.ajax({
    			type : "post",
    			url : "${ctp}/song/unlike",
    			data : {idx : idx_list[playerIndex]},
    		});
    	});
		
		//반복 재생 버튼
		$("#repeat_btn").click(() => {
			if (repeat == 0) {
				repeat = 1;
				repeat_btn.style.opacity = "1";
				$("#repeat_btn").prop("title", "반복재생");
			}
			
			else if (repeat == 1) {
				repeat = 2;
				repeat_btn.style.opacity = "0.7";
				$("#repeat_btn").prop("title", "한곡반복");
			}
			
			else if (repeat == 2) {
				repeat = 0;
				repeat_btn.style.opacity = "0.5";
				$("#repeat_btn").prop("title", "반복해제");
			}
		});
		
		//셔플
		let shuffle_sw = 0;
		let idx_list_ = [];
		let thum_list_ = [];
		let title_list_ = [];
		let artist_list_ = [];
		
		$("#shuffle_btn").click(() => {
			alert("셔플때문에 킹받음");
			
			if (shuffle_sw == 0) {
				idx_list_ = Object.assign([], idx_list);
				thum_list_ = Object.assign([], thum_list);
				title_list_ = Object.assign([], title_list);
				artist_list_ = Object.assign([], artist_list);
			}
			
			if (shuffle == 0)  {
				let param = Math.random() - 0.5;
				idx_list.sort(() => param);
				thum_list.sort(() => param);
				title_list.sort(() => param);
				artist_list.sort(() => param);
				
				shuffle_btn.style.opacity = "1";
				shuffle = 1;
			} 

			else if (shuffle == 1)  {
				lidx_list = idx_list_;
				thum_list = thum_list_;
				title_list = title_list_;
				lartist_list = artist_list_;
				
				shuffle_btn.style.opacity = "0.5";
				shuffle = 0;
			}
			
			setList();
			
			playerIndex = idx_list.indexOf(idx_list_[playerIndex]);
			focus_cur();
			
			
		});
		
		// 현재 음악 포커스
		function focus_cur() {
			let focu = document.getElementById("p_" + idx_list[playerIndex]);
			
			focu.scrollIntoView();
			focu.style.backgroundColor = "#bbccdd";
			focu.style.opacity = "0.7";
			focu.style.borderRadius = "5px";
			
			if (playerIndex != playerIndex_) {
				let focu_ = document.getElementById("p_" + idx_list[playerIndex_]);
				focu_.style.backgroundColor = "";
				focu_.style.opacity = "1";
				focu_.style.borderRadius = "0";
				playerIndex_ = playerIndex;		
			}
		}
		
		// 더보기 버튼 클릭
		addmore_btn.addEventListener("click", () => {
			alert("어떻게 해야 하죠?ㅜㅜ");
		});
		
		// 창 닫기 이벤트
		window.addEventListener("unload", () => {
			$.ajax({
				type : "post",
				url : "${ctp}/song/close"
			});
			opener.reload();
		});
		
		//크기 고정
		window.addEventListener("resize", () => {
			window.resizeTo(1100, 800);
		});
		
	</script>
	
</body>
</html>