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
	<title>DD Music Chart Top 100</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
    <link rel="stylesheet" href="${ctp }/resources/css/top100.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
        <div class="container">
            <div class="card-body">
                <h2 class="mt-5 mb-5">DD Music Top 100</h2>
                <table class="table">
                    <c:forEach var="vo" items="${vos }" varStatus="st">
	                    <tr>
	                        <td>${st.index + 1}</td>
	                        <td><div class="imgBox"><a href="${fn:replace(vo.img, 50, 800) }" target="_blank"><img name="top100Img" src="${vo.img }" alt=""></a></div></td>
	                        <td>
	                            <div name="top100Title"><a href="song/infor?idx=${vo.idx }">${vo.title }</a></div>
	                            <div name="top100Artist">${vo.artist }</div>
	                        </td>
	                        <td><button name="add_btn" type="button" class="btn" onclick="addf(${vo.idx})"><i title="곡 추가" class="fas fa-plus"></i></button></td>
	                    </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
        <div id="demo" style="display: none;">0</div>
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
	<script>
		let sw = 0;
		let player;
		
		function addf(idx) {
			if (idx == 0) {
				alert("아직 준비 중인 곡입니다.");
				return;
			}
	
			
			if (sw == 0) {
				let url = "${ctp}/song/player?idx=" + idx;
				player = window.open(url, "player", "width=1000px, height=800px, left=50px, top=150px");
				sw = 1;
				return;				
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/song/player",
				data : {idx : idx},
				success : (data) => {
					let t = data.title;
					if (data.title.length > 14) {
						t = data.title.substring(0, 14) + "...";
					}
					let a = data.artist;
					if (data.artist.length > 14) {
						a = data.artist.substring(0, 14) + "...";
					}
					player.document.getElementById("play_list").innerHTML = player.document.getElementById("play_list").innerHTML
					+ "<div name='song_row' class='d-flex p-3'><div class='imgBox mr-3'><img src='" + data.img + "'></div><div><div class='playlist_t' title='" + data.title + "'>" + t + "</div><div class='playlist_a' title='" + data.artist + "'>" + a + "</div></div><div class='ml-auto'><button name='delete_btn' type='button' class='btn' onclick='delList(" + data.idx + ")' ><i class='fa-regular fa-trash-can'></i></button></div></div>";
					player.document.getElementById("plist").innerHTML = player.document.getElementById("plist").innerHTML + data.idx + "/"; 
				}
			});
		}
		
	</script>
	
</body>
</html>