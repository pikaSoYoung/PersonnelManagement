<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>

var new_checklength = ${countnew};
var exi_checklength = ${countexi};
var checkcount = 0;
	$(document).ready(function(){
		$("[id=newlist]").hide();
		
	/* 	$("#checkalln").prop("checked",false)
		$("#checkalle").prop("checked",false)
		$("input[name^=chkn]").prop("checked",false);
		$("input[name^=chke]").prop("checked",false); */
		 
	    //최상단 체크박스 클릭
/* 	    $("#checkalln").click(function(){
	        //클릭되었으면
	        
	        if($("#checkalln").prop("checked")){
	            //input태그의 name이 chkn으로 시작인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[name^=chkn]").prop("checked",true);
	            $("[id ^=new_checkPoint]").addClass('success');
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 chkn으로 시작인 태그들을 찾아서 checked옵션을 false로 정의
	            $("input[name^=chkn]").prop("checked",false);
	            $("[id ^=new_checkPoint]").removeClass('success');
	            
	        }
	    }); */
	    
	  /*   $("[id=all_exi]").click(function(){
	        //클릭되었으면
	        if($("#checkalle").prop("checked")==false){
	            //input태그의 name이 chke으로 시작인 태그들을 찾아서 checked옵션을 true로 정의
	            
	            $("#checkalle").prop("checked",true);
	            $("input[name^=chke]").prop("checked",true);
	            $("[id ^= exi_checkPoint]").addClass('danger');
	            
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 chke으로 시작인 태그들을 찾아서 checked옵션을 false로 정의
	             $("#checkalle").prop("checked",false);
	            $("input[name^=chke]").prop("checked",false);
	            $("[id ^= exi_checkPoint]").removeClass('danger');
	        }
	    }); */
	    
	
	    
	
	});
	function all_new(){
		 
		if($("#checkalln").prop("checked")==false){
	            //input태그의 name이 chke으로 시작인 태그들을 찾아서 checked옵션을 true로 정의
	            
	            $("#checkalln").prop("checked",true);
	            $("input[name^=chkn]").prop("checked",true);
	            $("[id ^= new_checkPoint]").addClass('success');
	            
	            //클릭이 안되있으면
	    }else{
	            //input태그의 name이 chke으로 시작인 태그들을 찾아서 checked옵션을 false로 정의
	            $("#checkalln").prop("checked",false);
	            $("input[name^=chkn]").prop("checked",false);
	            $("[id ^= new_checkPoint]").removeClass('success');
	    }
	}
	
	function all_exi(){
		 
		if($("#checkalle").prop("checked")==false){
	            //input태그의 name이 chke으로 시작인 태그들을 찾아서 checked옵션을 true로 정의
	            
	            $("#checkalle").prop("checked",true);
	            $("input[name^=chke]").prop("checked",true);
	            $("[id ^= exi_checkPoint]").addClass('danger');
	            
	            //클릭이 안되있으면
	    }else{
	            //input태그의 name이 chke으로 시작인 태그들을 찾아서 checked옵션을 false로 정의
	             $("#checkalle").prop("checked",false);
	            $("input[name^=chke]").prop("checked",false);
	            $("[id ^= exi_checkPoint]").removeClass('danger');
	    }
	 }
	 
	 
 	function new_checkPoint(i) {
	
	 	if($("input[name=chkn"+i+"]").prop("checked")){
			$("input[name=chkn"+i+"]").prop("checked",false);
			$("[id=new_checkPoint"+i+"]").removeClass('success');
			
		}else{
				
			$("input[name=chkn"+i+"]").prop("checked",true);
			$("[id=new_checkPoint"+i+"]").addClass('success');
		}
 	} 
 	
  	function exi_checkPoint(i) {
		
		if($("input[name=chke"+i+"]").prop("checked")){
			$("input[name=chke"+i+"]").prop("checked",false);
			$("[id=exi_checkPoint"+i+"]").removeClass('danger');
		}else{
			
			$("input[name=chke"+i+"]").prop("checked",true);
			$("[id=exi_checkPoint"+i+"]").addClass('danger');
		}
	} 
	
	function new_emp_code(){		//신규계산 체크폼
		
		var frm = document.f1;
		
		for(var i=0; i<new_checklength; i++) {
			
			if($("input[name=chkn"+i+"]").prop("checked") == false){
				checkcount++;
			}
		}
	
		if(checkcount != new_checklength) {
			
			$("input[name^=chke]").prop("checked",false);
			frm.action = "/spring/new_empcode";
			
			frm.submit();
		}
		else{
			
			alert("아무것도 체크하지 않았습니다.!");
		}
		checkcount = 0;
		 
	}
   
	
   function exi_emp_code(){ //기존계산 체크폼
		
		var frm = document.f2;
		
		for(var i=0; i<exi_checklength; i++) {
			
			if($("[name=chke"+i+"]").prop("checked") == false){
				checkcount++;
			}
		}
	
		if(checkcount != exi_checklength) {
			$("input[name^=chkn]").prop("checked",false);
			
			frm.action = "/spring/exi_empcode";
			
			frm.submit();
			
		}else{
			
			alert("아무것도 체크하지 않았습니다.!");
		}
		checkcount = 0;
		
		
   }
   
   function h_emp_btn() {
	   
	   if($("[id=newlist]").css("display") == "none"){
		   $("[id=newlist]").show();
	   	
	   }else {
		   $("[id=newlist]").hide();
	   }
   }
/*    function newct(i){
	   if($("input[name=chkn"+i+"]").prop("checked")){
		   $("input[name=chkn"+i+"]").prop("checked",false);
			$("[id=new_checkPoint"+i+"]").removeClass('success');
	   }else{
			$("input[name=chkn"+i+"]").prop("checked",true);
			$("[id=new_checkPoint"+i+"]").addClass('success');
	   }
   }
   function exict(i){
	   
		if($("input[name=chke"+i+"]").prop("checked")){
			$("input[name=chke"+i+"]").prop("checked",false);
			$("[id=exi_checkPoint"+i+"]").removeClass('danger');
		}else{
			
			$("input[name=chke"+i+"]").prop("checked",true);
			$("[id=exi_checkPoint"+i+"]").addClass('danger');
		}
   } */
/*    
   function new_check_false(){
	   
	   $("[id ^= chkn]").prop("checked",false);
   }
   
   function exi_check_false(){
	   
	   $("[id ^= chke]").prop("checked",false);
   } */
</script>
</head>
<body>
<div class="main">
	<div class="main-content" id="main">

		<div class="container-fluid">
			<h3 class="page-title">직원급여정보</h3><p>
			<button class="btn btn-primary" type="button" onclick="h_emp_btn()"> 급여미등록사원 <span class="badge">${countnew}</span></button>
			
			<div class="col-xs-10" id="newlist">
				
				<div class="panel">
					<div class="panel-heading">

					   <form name="f1" method="POST">
						<div class="panel-body">
							<h4>신규계산</h4>
							<table class="table table-bordered table-hover" >
								<thead>
									<tr onclick="all_new()">
										<th><input type="checkbox" id="checkalln" onclick="all_new()"/></th>
										<th>코드&nbsp;&nbsp;</th> 
										<th>이름</th>
										<th>부서</th>
										<th>입사일자</th>
									</tr>
								</thead>
								<c:forEach var="tb" items="${listNew}" varStatus="status">
								<tr id="new_checkPoint${status.index}" onclick="javascript:new_checkPoint(${status.index});">
									<td>
										<input type="checkbox" name="chkn${status.index}" value="${tb.EMP_EMNO}" onclick="javascript:new_checkPoint(${status.index});"/> 
									</td>
									<td>${tb.EMP_EMNO}</td>
									
									<td>${tb.EMP_NAME}</td>
									<td></td>
									<td></td>
								</tr>
								</c:forEach>
							
							</table>
							<input type="button" value="신규계산" onclick="new_emp_code();" class="btn btn-success">
						</div>
					   </form>
						
					</div>
				</div>
			</div>
			
			<div class="col-xs-10">
			   
				<div class="panel">
					<div class="panel-heading">

					   <form name="f2" method="POST">
						<div class="panel-body">
						    <h4>기존계산</h4>
							<table class="table table-bordered table-hover">
								<thead>
									<tr id="all_exi" onclick="all_exi()">
										<th><input type="checkbox" id="checkalle" onclick="all_exi()"/></th>
										<th>코드&nbsp;&nbsp;</th> 
										<th>이름</th>
										<th>부서</th>
										<th>입사일자</th>
									</tr>
								</thead>
								<c:forEach var="tb" items="${listExi}" varStatus="status">
								<tr id="exi_checkPoint${status.index}" onclick="javascript:exi_checkPoint(${status.index});">
									<td>
										<input type="checkbox" name="chke${status.index}" value="${tb.EMP_EMNO}" onclick="javascript:exi_checkPoint(${status.index});"/> 
									</td>
									<td>
										${tb.EMP_EMNO}
										
									</td>
									
									<td>
										${tb.EMP_NAME}
									</td>
									<td></td>
									<td></td>
								</tr>
								</c:forEach>
							
							</table>
							<input type="button" value="기존계산" class="btn btn-danger" onclick="exi_emp_code();">
						</div>
					   </form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

</body>
</html>