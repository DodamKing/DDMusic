$().ready(() => {
    mainVideoPlay();
    $("video").on("ended", mainVideoPlay);
	player.volume = volume_bar.value / 100;
});


function mainVideoPlay() {
    let mainVideoH;
    let mainVideoM;
    let mainVideoS;

    mainVideoH = parseInt(Math.random() * 3);
    if (mainVideoH == 2) {
        mainVideoM = "0" + parseInt(Math.random() * 28);
    }
    else {
        mainVideoM = "0" +  parseInt(Math.random() * 60);
    }
    mainVideoS = "0" +  parseInt(Math.random() * 60);

	// contextPath 구하기
	let hostIndex = location.href.indexOf(location.host) + location.host.length;
	let contextPath = location.href.substring(hostIndex, location.href.indexOf("/", hostIndex + 1));

    let mainVideoUrl = contextPath + "/resources/video/sample.mp4#t=0" + mainVideoH + ":" + mainVideoM.substr(-2) + ":" + mainVideoS.substr(-2);
    // let mainVideoUrl = "video/sample.mp4#t=02:20:00,02:20:03";
    $("video").prop("src", mainVideoUrl);
}

// 검색버튼 클릭 이벤트
$("i.fa-magnifying-glass").click(() => {
    $("header > div:first-child").toggle();
});

// 네비 드롭 다운
$("#dropMenu").click((e) => {
    e.stopPropagation();
    $(".my-group").toggle();
});

// 플레이 리스트
$("#playlistUp_btn").click((e) => {
    e.stopPropagation();
    $("#play_listContainer").animate({top: "0px"}, 200);
    $("#playlistUp_btn").hide();
    $("#playlistDown_btn").show();
});

$("#playlistDown_btn").click((e) => {
    e.stopPropagation();
    $("#play_listContainer").animate({top: "100%"}, 200);
    $("#playlistUp_btn").show();
    $("#playlistDown_btn").hide();
});

// 땅찍어서 닫기
$(document).click((e) => {
    $(".my-group").hide();
    /*if ($(e.target).attr("id") != "play_listBox") {
        $("#play_listBox").animate({top:"100%"}, 200);
        if ($("#playlistUp_btn").css("display") == "none") {
            $("#playlistUp_btn").show();
            $("#playlistDown_btn").hide();
        }
    }*/
});

//좋아요 버튼
$("#like_btn1").click(() => {
	$("#like_btn1").hide();
	$("#like_btn2").show();
	
	if (controls_img.src.includes("music.png")) return;

	let data = {
		title : $("#controls_title").html(),
		artist : $("#controls_artist").html()
	}
	
	$.ajax({
		type : "post",
		url : "solike.so",
		data : data,
	});
	
});

$("#like_btn2").click(() => {
	$("#like_btn1").show();
	$("#like_btn2").hide();
	
	if (controls_img.src.includes("music.png")) return;
	
	let data = {
		title : $("#controls_title").html(),
		artist : $("#controls_artist").html()
	}
	
	$.ajax({
		type : "post",
		url : "sounlike.so",
		data : data,
	});
});
