<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<div class="modal fade" id="addlist">
	<div class="modal-dialog">
		<div class="modal-content" style="background: black;">
			<!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">곡 추가</h4>
	          <button type="button" class="close" data-dismiss="modal" onclick='mylist_box_re()'>&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        	<button type="button" class="btn btn-danger form-control" onclick="godata()" data-dismiss="modal">현재 재생 목록에 추가</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="download()">저장</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="gift()">선물하기</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="getlist()">플레이리스트에 추가</button>
	        	<div id="idx_box" style="display: none;"></div>
	        	<div id="isFile_box" style="display: none;"></div>
	        	<div id="mylist_box" class="mt-5"></div>
	        	<div id="message_box1" style="display: none;" class="text-center">추가 되었습니다</div>
	        	<div id="message_box2" style="display: none;" class="text-center">이미 추가 된 곡입니다</div>
	        	<div id="message_box3" style="display: none;" class="text-center">로그인이 필요합니다</div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button id="mclose_btn" type="button" class="btn btn-danger" data-dismiss="modal" onclick='mylist_box_re()'>Close</button>
	        </div>
        </div>
	</div>
</div>

<script>
	function getlist() {
		if ("${sVO}" == "") return;
		$.ajax({
			type : "post",
			url : "${ctp}/user/getlist",
			success : (data) => {
				let res = "";
				data.forEach((e) => {
					res += "<div class='d-flex justify-content-center ho mb-3' onclick='action(" + e.idx + ")'>";
					res += '<div style="width: 50px; height: 50px;" class="col-2">';
					res += '<div class="row" style="margin-left: 0px;">';
					if (e.thum1 == null) {
						res += '<div><img width="50px" src="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg"></div>';
						res += '</div></div><div class="col">';
						res += e.listNm;
						res += '</div></div>';
					}
					else if (e.thum4 == null) {
						res += '<div><img width="50px" src="' + e.thum1 + '"></div>';
						res += '</div></div><div class="col">';
						res += e.listNm;
						res += '</div></div>';
					}
					else {
						res += '<div><img width="25px" src="' + e.thum1 + '"></div>';
						res += '<div><img width="25px" src="' + e.thum2 + '"></div>';
						res += '</div>';
						res += '<div class="row" style="margin-left: 0px;">';
						res += '<div><img width="25px" src="' + e.thum3 + '"></div>';
						res += '<div><img width="25px" src="' + e.thum4 + '"></div>';
						res += '</div></div><div class="col">';
						res += e.listNm;
						res += "</div></div></div>";
					}
				});
				mylist_box.innerHTML = res;
				
			} 
		});
	}
	
	/* function action(idx) {
		let data = {
			idx : idx,
			songIdx : idx_box.innerHTML
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/addmylist",
			data : data,
			success : (data) => {
				if (data == 1) {
					$("#message_box1").slideDown(300);
					setTimeout(() => $("#message_box1").slideUp(), 1000);
					return;
				}
				$("#message_box2").slideDown(300);
				setTimeout(() => $("#message_box2").slideUp(), 1000);
			}
		});
	} */
	
	function mylist_box_re() {
		mylist_box.innerHTML = "";
	}
	
	
</script>