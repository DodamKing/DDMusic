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
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        	<button type="button" class="btn btn-danger form-control" onclick="godata()">현재 재생 목록에 추가</button>
	        	<button type="button" class="btn btn-danger form-control mt-3" onclick="getlist()">플레이리스트에 추가</button>
	        	<div id="idx_box" style="display: none;"></div>
	        	<div id="isFile_box" style="display: none;"></div>
	        	<div id="mylist_box" class="mt-5"></div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button id="mclose_btn" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
        </div>
	</div>
</div>

<script>
	function getlist() {
		$.ajax({
			type : "post",
			url : "${ctp}/user/getlist",
			success : (data) => {
				let res = "";
				data.forEach((e) => {
					res += "<div class='d-flex justify-content-center ho mb-3' onclick='action(" + e.idx + ")'>";
					res += '<div style="width: 50px; height: 50px;" class="col-2">';
					res += '<div class="row" style="margin-left: 0px;">';
					res += '<div><img width="25px" src="' + e.thum1 + '"></div>';
					res += '<div><img width="25px" src="' + e.thum2 + '"></div>';
					res += '</div>';
					res += '<div class="row" style="margin-left: 0px;">';
					res += '<div><img width="25px" src="' + e.thum3 + '"></div>';
					res += '<div><img width="25px" src="' + e.thum4 + '"></div>';
					res += '</div></div><div class="col">';
					res += e.listNm;
					res += "</div></div></div>";
				});
				mylist_box.innerHTML = res;
			}
		});
	}
	
	function action(idx) {
		if(confirm("추가하시겠습니까?")) {
			let data = {
				idx : idx,
				songIdx : idx_box.innerHTML
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/user/addmylist",
				data : data,
				success : () => {
					alert("추가 되었습니다.");
					location.reload();
				}
			});
		}
	}
	
	
</script>