<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script>
	var i = 0;
	var checklength = ${count};
	
	var checkcount = 0;
	/*  ${aList.get(0).scomHhCst } 야간근무수당
	${aList.get(0).scomNhCst }	주간근무수당
	${aList.get(0).scomElhCst } 식대
	${aList.get(0).sempCmc }	차량유지비
	${aList.get(0).scomLhCst } 지각시간당비용 
	  $(document).ready(function() {
		//최상단 체크박스 클릭
		$("#checkall").click(function() {
			//클릭되었으면
			if ($("#checkall").prop("checked") ==true) {//input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의

				for (var i = 0; i < checklength; i++) {
					
					if ($("#chk" + i).prop("checked") == false) {
						
						$("#chk" + i).prop("checked",true);
						$("td[name=saltext"+ i+ "]").append('<input type="text" name=sali'+ i+ ' style="width=100%; text-align:right;" size="5" onkeydown="onlyMoneyNumber(this)">');
						$("td[name=sbctext"+ i+ "]").append('<input type="text" name=sbci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomHhCst }" size="5" onkeydown="onlyMoneyNumber(this)">');		
						$("td[name=snctext"+ i+ "]").append('<input type="text" name=snci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomNhCst }" size="5" onkeydown="onlyMoneyNumber(this)">');
						$("td[name=tamtext"+ i+ "]").append('<input type="text" name=tami'+ i+ ' value="0" style="visibility:hidden" size="5" onkeydown="onlyMoneyNumber(this)">');
						$("td[name=fdetext"+ i+ "]").append('<input type="text" name=fdei'+ i+ ' value="0" style="visibility:hidden" size="5" onkeydown="onlyMoneyNumber(this)">');
						$("td[name=cmctext"+ i+ "]").append('<input type="text" name=cmci'+ i+ ' value="0" style="visibility:hidden" size="5" onkeydown="onlyMoneyNumber(this)">');
						$("td[name=slctext"+ i+ "]").append('<input type="text" name=slci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomLhCst }" size="5" onkeydown="onlyMoneyNumber(this)">');
						$("td[name=empcode"+ i+ "]").append('<input type="hidden" name=code'+i+'  value='+$('[name=empcode'+i+']').attr('id')+' >');
						
						
						$("td[name=tamtext"+ i+ "]").append('<input type="checkbox" name=tamiCk'+ i+ ' onchange="checkChange(this,'+i+')">');
						$("td[name=fdetext"+ i+ "]").append('<input type="checkbox" name=fdeiCk'+ i+ ' onchange="checkChange(this,'+i+')">');
						$("td[name=cmctext"+ i+ "]").append('<input type="checkbox" name=cmciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
					 	
						$("td[name=sbctext"+ i+ "]").append('<input type="checkbox" name=sbciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
						$("td[name=snctext"+ i+ "]").append('<input type="checkbox" name=snciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
						$("td[name=slctext"+ i+ "]").append('<input type="checkbox" name=slciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
						
						//$("input[type=text]").css("width","70px");
						//$("input[name=sali"+i+"]").css("width","100px");
						///$("input[name=sbci"+ i+ "]").css("width","100px");
					}
				}

			}else{
				$("input[type=checkbox]").prop("checked", false);

				for (var i = 0; i < checklength; i++){
					$("input[name=sali"+ i + "]").remove();
					$("input[name=sbci"+ i + "]").remove();
					$("input[name=sbciCk"+ i + "]").remove();
					$("input[name=snci"+ i + "]").remove();
					$("input[name=snciCk"+ i + "]").remove();
					$("input[name=tami"+ i + "]").remove();
					$("input[name=tamiCk"+ i + "]").remove();
					$("input[name=fdei"+ i + "]").remove();
					$("input[name=fdeiCk"+ i + "]").remove();
					$("input[name=cmci"+ i + "]").remove();
					$("input[name=cmciCk"+ i + "]").remove();
					$("input[name=slci"+ i + "]").remove();
					$("input[name=slciCk"+ i + "]").remove();
					$("input[name=code"+ i + "]").remove();
					
					
				}

			}
		});
	}); */
	
	function allcheck(){
		
		if ($("#checkall").prop("checked") ==false) {//input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
			$("#checkall").prop("checked",true)
			$("[id ^= checkPoint]").addClass('success');
			for (var i = 0; i < checklength; i++) {
				
				if ($("#chk" + i).prop("checked") == false) {
					
					$("#chk" + i).prop("checked",true);
					$("td[name=saltext"+ i+ "]").append('<input type="text" name=sali'+ i+ ' style="width=100%; text-align:right;" size="10" onkeydown="onlyMoneyNumber(this)">');
					//$("td[name=sbctext"+ i+ "]").append('<input type="text" name=sbci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomHhCst }" size="5" onkeydown="onlyMoneyNumber(this)">');		
					//$("td[name=snctext"+ i+ "]").append('<input type="text" name=snci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomNhCst }" size="5" onkeydown="onlyMoneyNumber(this)">');
					$("[id=checkPoint"+ i+ "]").append('<input type="hidden" name=tami'+ i+ ' value=0)>');
					$("[id=checkPoint"+ i+ "]").append('<input type="hidden" name=fdei'+ i+ ' value=0>');
					$("[id=checkPoint"+ i+ "]").append('<input type="hidden" name=cmci'+ i+ ' value=0>');
					//$("td[name=slctext"+ i+ "]").append('<input type="text" name=slci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomLhCst }" size="5" onkeydown="onlyMoneyNumber(this)">');
					$("td[name=empcode"+ i+ "]").append('<input type="hidden" name=code'+i+'  value='+$('[name=empcode'+i+']').attr('id')+' >');
					
					
					
					/* $("td[name=tamtext"+ i+ "]").append('<input type="checkbox" name=tamiCk'+ i+ ' onchange="checkChange(this,'+i+')">');
					$("td[name=fdetext"+ i+ "]").append('<input type="checkbox" name=fdeiCk'+ i+ ' onchange="checkChange(this,'+i+')">');
					$("td[name=cmctext"+ i+ "]").append('<input type="checkbox" name=cmciCk'+ i+ ' onchange="checkChange(this,'+i+')">'); */
				 	
					/* $("td[name=sbctext"+ i+ "]").append('<input type="checkbox" name=sbciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
					$("td[name=snctext"+ i+ "]").append('<input type="checkbox" name=snciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
					$("td[name=slctext"+ i+ "]").append('<input type="checkbox" name=slciCk'+ i+ ' onchange="checkChange(this,'+i+')">'); */
					
					//$("input[type=text]").css("width","70px");
					//$("input[name=sali"+i+"]").css("width","100px");
					///$("input[name=sbci"+ i+ "]").css("width","100px");
				}
			}

		}else{
			$("#checkall").prop("checked",false)
			$("input[type=checkbox]").prop("checked", false);
			$("[id ^=checkPoint]").removeClass('success');
			
			for (var i = 0; i < checklength; i++){
				$("input[name=sali"+ i + "]").remove();
				$("input[name=sbci"+ i + "]").remove();
				$("input[name=sbciCk"+ i + "]").remove();
				$("input[name=snci"+ i + "]").remove();
				$("input[name=snciCk"+ i + "]").remove();
				$("input[name=tami"+ i + "]").remove();
				$("input[name=tamiCk"+ i + "]").remove();
				$("input[name=fdei"+ i + "]").remove();
				$("input[name=fdeiCk"+ i + "]").remove();
				$("input[name=cmci"+ i + "]").remove();
				$("input[name=cmciCk"+ i + "]").remove();
				$("input[name=slci"+ i + "]").remove();
				$("input[name=slciCk"+ i + "]").remove();
				$("input[name=code"+ i + "]").remove();
				
				
			}

		}
	}
	function check(i) {

		if ($("#chk" + i).prop("checked") == false) {
			
			$("#chk" + i).prop("checked",true)
			$("[id=checkPoint"+i+"]").addClass('success');
			//alert(list);
			$("td[name=saltext"+ i+ "]").append('<input type="text" name=sali'+ i+ ' style="width=100%; text-align:right;" size="10" onkeydown="onlyMoneyNumber(this)">');
			//$("td[name=sbctext"+ i+ "]").append('<input type="text" name=sbci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomHhCst }"  size="5" onkeydown="onlyMoneyNumber(this)">');
			//$("td[name=snctext"+ i+ "]").append('<input type="text" name=snci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomNhCst }"  size="5" onkeydown="onlyMoneyNumber(this)">');
			$("[id=checkPoint"+ i+ "]").append('<input type="hidden" name=tami'+ i+ ' value="0">');
			$("[id=checkPoint"+ i+ "]").append('<input type="hidden" name=fdei'+ i+ ' value="0">');
			$("[id=checkPoint"+ i+ "]").append('<input type="hidden" name=cmci'+ i+ ' value="0">');
			//$("td[name=slctext"+ i+ "]").append('<input type="text" name=slci'+ i+ ' value="${ empty aList ? "0": aList.get(0).scomLhCst }"  size="5" onkeydown="onlyMoneyNumber(this)">');
			$("td[name=empcode"+ i+ "]").append('<input type="hidden" name=code'+i+'  value='+$('[name=empcode'+i+']').attr('id')+' >');
			
		
 		
		 	//$('[name=cmci'+i+']').val("${aList.get(0).sempCmc }");
			
			
		
			
		/* 	$("td[name=tamtext"+ i+ "]").append('<input type="checkbox" name=tamiCk'+ i+ ' onchange="checkChange(this,'+i+')">');
			$("td[name=fdetext"+ i+ "]").append('<input type="checkbox" name=fdeiCk'+ i+ ' onchange="checkChange(this,'+i+')">');
			$("td[name=cmctext"+ i+ "]").append('<input type="checkbox" name=cmciCk'+ i+ ' onchange="checkChange(this,'+i+')">'); */
			
			/* $("td[name=snctext"+ i+ "]").append('<input type="checkbox" name=snciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
		 	$("td[name=sbctext"+ i+ "]").append('<input type="checkbox" name=sbciCk'+ i+ ' onchange="checkChange(this,'+i+')">');
			$("td[name=slctext"+ i+ "]").append('<input type="checkbox" name=slciCk'+ i+ ' onchange="checkChange(this,'+i+')">'); */
			
		} else {
			$("[id=chk"+i+"]").prop("checked",false);
			$("[id=checkPoint"+i+"]").removeClass('success');
			/* $('[name=sbci'+i+']').val("0");
 			$('[name=snci'+i+']').val("0");
		 	//$('[name=cmci'+i+']').val("0");
			$('[name=fdei'+i+']').val("0");
			$('[name=cmci'+i+']').val("0"); 
			$('[name=slci'+i+']').val("0"); */
			$("input[name=sali"+ i + "]").remove();
			/* $("input[name=sbci"+ i + "]").remove();
			$("input[name=sbciCk"+ i + "]").remove();
			$("input[name=snci"+ i + "]").remove();
			$("input[name=snciCk"+ i + "]").remove(); */
			$("input[name=tami"+ i + "]").remove();
			//$("input[name=tamiCk"+ i + "]").remove();
			$("input[name=fdei"+ i + "]").remove();
			//$("input[name=fdeiCk"+ i + "]").remove();
			$("input[name=cmci"+ i + "]").remove();
			//$("input[name=cmciCk"+ i + "]").remove();
			//$("input[name=slci"+ i + "]").remove();
			//$("input[name=slciCk"+ i + "]").remove(); 
			$("input[name=code"+ i + "]").remove();
			
		}
	}
	
	/// 체크 시 인풋 박스 추가삭제
	/* function checkChange( obj,i ){
		//alert( obj.name );
		var inputName = obj.name.replace("Ck","");
		
		//alert(inputName);
		if( $('[name="'+obj.name+'"]').prop("checked") == true ){
			
			if(inputName == "sbci"+i) {
				$('[name=sbci'+i+']').val("${aList.get(0).scomHhCst }");
			}else if(inputName =="snci"+i){
				$('[name=snci'+i+']').val("${aList.get(0).scomNhCst }");
			}else if(inputName == "fdei"+i){
				$('[name=fdei'+i+']').val("${aList.get(0).scomElhCst} ");
			}else if(inputName == "cmci"+i){
				$('[name=cmci'+i+']').val("${aList.get(0).sempCmc }"); 
			}else if(inputName =="slci"+i){
				$('[name=slci'+i+']').val("${aList.get(0).scomLhCst }");
			}
			$('[name="'+inputName+'"]').css('visibility','visible');
	
		}else{
			
			$('[name="'+inputName+'"]').css('visibility','hidden');
		}
	} */
	
	/// td 더블클릭시 체크 인풋 박스 추가삭제
/* 	function checkboxChange( obj ){
		//alert( obj.id );
		var inputName = obj.id.replace("text","i");
		var iptNameLen = inputName.length;
		var inputName1 = inputName.substring(0,iptNameLen-1);
		var inputName2 = inputName.substring(iptNameLen-1,iptNameLen);
		inputName3 = inputName1 + "Ck" + inputName2;
		//alert( inputName );
		
		if( $('[name="'+inputName3+'"]').prop("checked") == true ){
			
		
			$('[name="'+inputName+'"]').css('visibility','hidden');
			$('[name="'+inputName3+'"]').prop("checked",false);
			
		}else{
			$('[name="'+inputName+'"]').css('visibility','visible');
			$('[name="'+inputName3+'"]').prop("checked",true);
		}
	} */
	
	// mouse over
/* 	function tdMouseOver( obj ){
		var tdName = obj.id;
		$('[name="'+tdName+'"]').mouseover( $('[name="'+tdName+'"]').css('background-color','yellow') );
	}
	//	mouse out
	function tdMouseOut( obj ){
		var tdName = obj.id;
		$('[name="'+tdName+'"]').mouseout( $('[name="'+tdName+'"]').css('background-color','white') );
	} */
	
	// 숫자만 입력, 콤마찍기, 첫자리 숫자 0 입력 안되게
	//콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	//콤마풀기
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	function onlyMoneyNumber(obj) {	//	obj 는 this 값 입니다
		$(obj).val($(obj).val().replace(/[^0-9]/g,"").replace(/(^0+)/, "") );
		$(obj).keyup(function(){			
			obj.value = comma(uncomma(obj.value));
	    });
	}
	
/* 	function insert_sal_emp(formId) {
		
		var json;
		$("#" + formId).ajaxForm({
						
			url:"/spring/insert_sal_empcode.ajax",
			type:'GET',
			data:json,
						
			success:function(data) {
										
				if(data.success == "true") {
								
					alert("저장성공!");
				}else {
								
					alert("저장실패");
				}
					console.log("결과데이터 : "+JSON.stringify(data));
					//location.reload();
				},
						
				error:function(jqXHR, textStatus, errorThrown){
					alert("중복된 급여대장이 있습니다. \n" + textStatus + " : " + errorThrown);         
				}
						
		}).submit(); */
		
	function insert_sal_emp() {
				
		var frm = document.f1;
		
		for(var i=0; i<checklength; i++) {
			
			if($("input[id=chk"+i+"]").prop("checked") == false){
				checkcount++;
			}
			
			if($("input[name=sali"+i+"]").val() == "") {
					
				 alert("급여에 공백이 있습니다. 입력해주세요.");
				 checkcount = 0;
				 break;
			}
			if(checkcount == checklength ) {
				
				alert("아무것도 체크하지 않았습니다.!");
				checkcount = 0;
				return;
			}
			if(checklength-1==i) {
			
				$("input[type=checkbox]").prop("checked", true);

				for (var i = 0; i < checklength; i++){
					$("input[name=sbciCk"+ i + "]").remove();
					$("input[name=snciCk"+ i + "]").remove();
					$("input[name=tamiCk"+ i + "]").remove();
					$("input[name=fdeiCk"+ i + "]").remove();
					$("input[name=cmciCk"+ i + "]").remove();
					$("input[name=slciCk"+ i + "]").remove();
				}

				frm.action ="/spring/insert_sal_empcode";
				frm.submit();

			}
		}
		
		
			/* frm.action ="/spring/insert_sal_empcode.do";
			frm.submit(); */ 
		 
	}
		
	
	
 		
 
	 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="main">
	<div class="main-content">

		<div class="container-fluid">
			<h3 class="page-title">직원급여정보</h3>

			<div class="col-xs-12">
				<div class="panel">
					<div class="panel-heading">

						<form id="frm" name="f1" method="POST">
							<div class="panel-body">
								<table class="table table-bordered" table-hover">
									<tr onclick="allcheck()">
										<th class="text-center" onclick="allcheck()"><input type="checkbox" id="checkall" /></th>
										<th>사번</th>
										<th>사원이름</th>
										<th>급여</th>
									<!-- 	<th>주간근무수당</th>
										<th>야간근무수당</th>
										<th>연장근무수당</th>
										<th>지각</th>
										<th>휴가</th>
										<th>교통비</th>
										<th>식대</th>
										<th>차량유지비</th>
										<th>상여금</th>
										<th>출장비</th> -->

									</tr>
									<c:forEach var="tb" items="${list}" varStatus="status">

										<tr id="checkPoint${status.index}">
											<td width="5" align="center" onclick="check(${status.index})"><input type="checkbox" id="chk${status.index}" onclick="check('${status.index}')"></td>
											<td width="50" name="empcode${status.index}" id="${tb.EMP_EMNO}" onclick="check(${status.index})">${tb.EMP_EMNO}</td>
											<td width="100" onclick="check(${status.index})">${tb.EMP_NAME}</td>
											<td width="100" id="saltext${status.index}" name="saltext${status.index}"  align="center" ondblclick="checkboxChange(this)" ></td>
								<%-- 			<td width="100" id="sbctext${status.index}" name="sbctext${status.index}" align="center" ondblclick="checkboxChange(this)"></td>
											<td width="100" id="snctext${status.index}" name="snctext${status.index}" align="center" ondblclick="checkboxChange(this)" ></td>
											<td width="100"></td>
											<td width="100" id="slctext${status.index}" name="slctext${status.index}" align="center" ondblclick="checkboxChange(this)" ></td>
											<td width="100"></td>
											<td width="100" id="tamtext${status.index}" name="tamtext${status.index}" align="center" ondblclick="checkboxChange(this)" ></td>
											<td width="100" id="fdetext${status.index}" name="fdetext${status.index}" align="center" ondblclick="checkboxChange(this)" ></td>
											<td width="100" id="cmctext${status.index}" name="cmctext${status.index}" align="center" ondblclick="checkboxChange(this)" ></td>
											<td width="100"></td>
											<td width="100"></td> --%>
										</tr>
									</c:forEach>
									
							
							
								</table>
								<input type="button" class="btn btn-info" value="저장" onclick="insert_sal_emp();">
							</div>
						</form>
						
						<%-- 	<input type="hidden" name="sbc" value="${aList.get(0).scomHhCst }">
							<input type="hidden" name="snc" value="${aList.get(0).scomNhCst }">
							<input type="hidden" name="tam" value="교통비">
							<input type="hidden" name="fde" value="${aList.get(0).scomElhCst }">
							<input type="hidden" name="cmc" value="${aList.get(0).sempCmc }">
							<input type="hidden" name="slc" value="${aList.get(0).scomLhCst }"> --%>
									
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>