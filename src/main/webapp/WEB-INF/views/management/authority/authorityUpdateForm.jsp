<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="panel-heading">
	<h3 class="panel-title">${menuAttrData.mnName}</h3>
</div>
<!-- 메뉴 권한 상세  업데이트 폼 시작 -->
<div class="panel-body"> 
	<form id="updateForm" method="post">
		<input type="hidden" name="mnNo" value="${menuData.mnNo}"/>
		<input type="hidden" name="empEmno" value="${empEmno}"/>
		<table class="table table-bordered" style="width:100%;">
			<colgroup>
				<col width="30%"/>
				<col width="70%"/>
			</colgroup>
			<tbody>
				<tr>
					<th class="text-center">권한 유형</th>
					<td>
						<c:choose>
							<c:when test="${menuData.mnAttr=='view'}">
							<input type="checkbox" name="atrAttr" value="view" <c:if test="${authoData.atrAttr ne null}">${authoData.atrAttr == 'view'?'checked' : ""}</c:if>/>
							<span>
								조회
							</c:when>
							<c:when test="${menuData.mnAttr=='insert'}">
							<input type="checkbox" name="atrAttr" value="insert" <c:if test="${authoData.atrAttr ne null}">${authoData.atrAttr == 'insert'?'checked' : ""}</c:if>/>
							<span>
								등록
							</c:when>
							<c:when test="${menuData.mnAttr=='update'}">
							<input type="checkbox" name="atrAttr" value="update" <c:if test="${authoData.atrAttr ne null}">${authoData.atrAttr == 'update'?'checked' : ""}</c:if>/>
							<span>
								수정
							</c:when>
							<c:when test="${menuData.mnAttr=='delete'}">
							<input type="checkbox" name="atrAttr" value="delete" <c:if test="${authoData.atrAttr ne null}">${authoData.atrAttr == 'delete'?'checked' : ""}</c:if>/>
							<span>
								삭제
							</c:when>
							<c:otherwise>
          					<input type="checkbox" name="atrAttr" value="all" />
							<span>
								all
       						</c:otherwise>
						</c:choose>
						</span>
					</td>
				</tr>
				<tr>
					<th class="text-center">적용 시작일</th>	
					<td>
						<div class="input-group date datepicker strt" id="atrAplyStrt">
							<input type="text" class="form-control" name="atrAplyStrt" value="${authoData.atrAplyStrt}">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">적용 종료일</th>	
					<td>
						<div class="input-group date datepicker fini" id="atrAplyFini">
							<input type="text" class="form-control" name="atrAplyFini" value="${authoData.atrAplyFini}">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>
				</tr>
				<tr>	
					<th class="text-center">수정가능 시작일</th>
					<td>
						<div class="input-group date datepicker strt" id="atrUpdtStr">
							<input type="text" class="form-control" name="atrUpdtStrt" value="${authoData.atrUpdtStrt}">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">수정가능 종료일</th>	
					<td>
						<div class="input-group date datepicker fini" id="atrUpdtFini">
							<input type="text" class="form-control"  name="atrUpdtFini" value="${authoData.atrUpdtFini}">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>	
				</tr>		
			</tbody>
		</table>	
	</form>
<!-- 메뉴 권한 상세  등록 폼 끝 -->	  
<!-- 권한 업데이트 버튼  시작 -->
	<div class="text-right">
		<button type="button" name="authoUpdateSubmit" class="btn btn-info">수정</button>
		<button type="button" name="authoEsc" class="btn btn-danger">취소</button> 
	</div> 
<!-- 권한 업데이트 버튼  끝-->	
</div>
<form action="authorityDetail.do" id="hiddenForm" method="">
	<input type="hidden" name="mnNo" value="${menuData.mnNo}"/>
	<input type="hidden" name="empEmno" value="${empEmno}"/>
</form>