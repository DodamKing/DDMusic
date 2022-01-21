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
	        	<button type="button" class="btn form-control" onclick="godata()">현재 재생 목록에 추가</button>
	        	<button type="button" class="btn form-control">플레이리스트에 추가</button>
	        	<div id="idx_box"></div>
	        	<div id="isFile_box"></div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
        </div>
	</div>
</div>

<script>
	
</script>