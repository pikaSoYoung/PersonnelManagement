<!-- 
	휴가신청(사원) - 유성실,신지연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>휴가신청</title>
<link type="text/css" rel="stylesheet" href="/spring/resources/common/css/vacation.css" />
<script>

/* $(function(){
	vacTypeList();//휴가 셀렉박스 ajax
	calender(); //달력
	vacSelect();	//휴가 셀렉박스 
	//check_onclick();	//휴가 신청하기
}); */



$(function(){
	vacTypeList();//휴가 셀렉박스 ajax	
	
	//관리자인지 아닌지 체크
	paging.ajaxFormSubmit("adminChk.exc","vacReqFrm", function(obj){
		if(obj == 1){	//관리자일 경우
			console.log("ffffffffff");
			calender(); //달력
			vacSelect();	//휴가 셀렉박스 
		} else {//사원일 경우
			console.log("dddddd");
			//휴가일수 설정에 등록된 사원인지 체크하여 alert창 띄우기
			paging.ajaxFormSubmit("empVacChk.exc", "vacReqFrm", function(rslt){
				if(rslt != '1'){
					alert('휴가일수가 설정되지 않았습니다.\n관리자에게 문의하세요.');
				}else{
					$('#vastReqDate').attr('readonly',true);
					paging.ajaxFormSubmit("empVacInfomation.exc","vacReqFrm", function(str){
						console.log("결과데이타 empVacInfomation" + JSON.stringify(str));
// 						$.each(str.empVacInfomation,function(k,v){
// 							console.log("test : " + v.empName);
// 							$('#reqEmpEmno').val($('[type=hidden][name=empEmno]').val()).attr('readonly',true);
// 							$('#empName').html(v.empName);
// 							$('#deptName').val(v.deptName);
// 							$('#rankName').val(v.rankName).attr(readonly,true);
// 						});//each.empVacInfomation
						$('#reqEmpEmno').val(str[0].reqEmpEmno).attr('readonly',true);
						$('#empName').val(str[0].empName).attr('readonly',true);
						$('#deptName').val(str[0].deptName).attr('readonly',true);
						$('#rankName').val(str[0].rankName).attr('readonly',true);
						$('#calenderInp').remove();
						$('#search').remove();
					});//ajax-empVacInfomation.exc
					
					calender(); //달력
					vacSelect();	//휴가 셀렉박스 
					//check_onclick();	//휴가 신청하기
				}//if
			});//ajax.empVacChk
		}//if else
	});//ajax.adminChk.exc
});


/* ajax - 휴가타입 셀렉박스 */
function vacTypeList(){
	paging.ajaxFormSubmit("vacTypeList.exc", "vacReqFrm", function(rslt){
		console.log("ajaxFormSubmit -> callback");
		console.log("결과데이타" + JSON.stringify(rslt));
		
		//이전 리스트 삭제
		$('#vacationTypeList').empty();	//휴가타입 셀렉트
		//휴가 셀렉박스
		if(rslt.vacationTypeList != null){
			$('#vacationTypeList').append(
				"<option value=''>"+ '선택' +"</option>");
			$.each(rslt.vacationTypeList, function(k,v){
				$('#vacationTypeList').append(
					"'<option value='"+ v.vastC +"'>"+ v.vastType +"</option>"
				);//append	
			});	//each.vacationTypeList
			$('#vacationTypeList').val($('#vacationTypeHidden').val()).prop("selected", true);//hidden 값 value를 선택하고 유지	
		} else{
			$('#vacationTypeList').append('<option>'+ '선택' +'</option>');
		}//if
	});//paging	
}//vacationTypeList AJAX


/* ajax-INSERT */
function check_onclick(url, formId){
	paging.ajaxFormSubmit(url, formId, function(rslt){
		console.log("ajaxFormSubmit -> callback");
		console.log("결과데이타" + JSON.stringify(rslt));
			
//		insert 성공여부에 따른 alert창 띄우기
// 			if($('#vacationTypeList').val() ==null || $('#vastCont').val() == null){
// 				console.log("ssssss");
// 				alert("빈 칸을 채워주세요.");
// 				return false;				
// 			} else {
// 				console.log("aaaaa");
// 				if(rslt.success == "Y"){
// 					alert("휴가가 신청되었습니다.");	
// 					location.reload();
// 				}else{
// 					alert("휴가 신청실패");
// 				}
// 			}

		if(rslt.success == "Y"){
// 			if($('#vacationTypeList').val() ==null || $('#vastCont').val() == null){
// 				console.log("ssssss");
// 				alert("빈 칸을 채워주세요.");
// 				return false;				
// 			} else {
// 				console.log("aaaaa");
				alert("휴가가 신청되었습니다.");	
				location.reload();
// 			}
			
		}else{
			alert("휴가 신청실패");
		}

		


				
								
		
	});//paging
}//check_onclick
	

	
/* 달력  */
function calender() {
	
	//오늘 날짜로 보여주기
	$('#vastReqDate').val(moment().format('YYYY.MM.DD'));	//휴가 신청일
	$('#vastStartDate').val(moment().format('YYYY.MM.DD'));		//휴가 시작일
	$('#vastEndDate').val(moment().format('YYYY.MM.DD'));		//휴가 종료일
	$('#vastVacUd').val(moment().format('1'));
	$('#vastCrtDate').val(moment().format('YYYY.MM.DD'));	//휴가 등록일자
	
	$('#crtDate').datetimepicker({ //휴가신청일 달력
		viewMode : 'days',
		format : 'YYYY.MM.DD'
	});
	
	$('#startDate').datetimepicker({ //휴가시작일 달력
		viewMode : 'days',
		format : 'YYYY.MM.DD'
	});

	$('#endDate').datetimepicker({ //휴가종료일 달력
		viewMode : 'days',
		format : 'YYYY.MM.DD'
	});

	//휴가종료날짜가 시작날짜 이전인 날짜는 선택 불가능하도록 제한
	$('#startDate').on("dp.change", function(e) {
		$('#endDate').data("DateTimePicker").minDate(e.date);
	});

	//일수 자동 계산 - startDate 변경시
	$('#startDate').on("dp.change", function() { //시작날짜를 변경할 때마다
		var startDate = moment($('#vastStartDate').val(), "YYYYMMDD");
		var endDate = moment($('#vastEndDate').val(), "YYYYMMDD");

		$('#vastVacUd').val(endDate.diff(startDate, "days")+1 //endDate-startDate를 일수로 출력
		);
	});
	
	//일수 자동 계산 - endDate 변경시
	$('#endDate').on("dp.change", function() {
		var startDate = moment($('#vastStartDate').val(), "YYYYMMDD");
		var endDate = moment($('#vastEndDate').val(), "YYYYMMDD");

		$('#vastVacUd').val(endDate.diff(startDate, "days")+1 //endDate-startDate를 일수로 출력
		);
	});
};//달력

function vacSelect(){
 	$("#vacationTypeList").click(function(){
	
 		var startDate = moment($('#vastStartDate').val(), "YYYYMMDD");
		var endDate = moment($('#vastEndDate').val(), "YYYYMMDD");
		console.log(endDate-startDate);
		
		//반차 선택했을 때, 일수가 0.5로 변경
		if($("#vacationTypeList option:selected").text() == "반차"){
// 			console.log("0.5");	
			$('#vastVacUd').val('0.5');//일수 입력창이 0.5로 바뀜
			$('#vastEndDate').val($('#vastStartDate').val());
			if(endDate-startDate != 0){
				submitGo();
				alert("반차는 시작날짜와 끝날짜가 같아야 합니다.");
				$('#vastVacUd').val('0.5'); //input hidden값 value를 선택
			}
		} else{

		}
 	});	
}//vacSelect
	
	
	
	
/* ****************************사원 선택 모달창************************** */
 
	
	//퇴직자 포함 체크 여부
	function retrCheck(){
		if(($('#retrChk').prop('checked')) == true){
			$('#retrDelYn').val('on');
		} else{
			$('#retrDelYn').val('off');
		}
	}
		
	//모달창 : 사원 리스트 ajax(사원 휴가일수 리스트 참조)

	function vacationReqEmpList(){
		retrCheck();	//퇴직자 포함 체크 여부
		$("input[type=hidden][name=baseYear]").val(moment().format('YYYY'));	//휴가개수 설정년도
		$('#vacCntEmpListTbody').empty();	//이전 리스트 삭제
		
		paging.ajaxFormSubmit("vacationReqEmpList.exc","vacEmpListModal", function(rslt){
			console.log("결과데이터: "+ JSON.stringify(rslt));
			
			$('#vacCntEmpListTable').children('thead').css('width','calc(100% - 1.1em)');	//테이블 스크롤 CSS
			
			if(rslt.vacationReqEmpList == null || rslt.success == "N"){
				$('#vacCntEmpListTbody').append(	//리스트가 없을 경우
					"<div class='text-center'><br><br><br><br>조회할 데이터가 없습니다.</div>"	
				);
			} else if(rslt.success == "Y"){
				$.each(rslt.vacationReqEmpList, function(k, v){
					$('#vacCntEmpListTbody').append(
							"<tr style='display:table;width:100%;table-layout:fixed;'>" +
								"<td>"+
									"<label class='fancy-checkbox-inline'>" +
										"<input type='checkbox' name='empEmnoChk'>" +
										"<span></span>" +
									"</label>" +
								"</td>" +
								"<td>" +v.retrDelYn+"</td>"+	//퇴직자 구분
								"<td>" +v.empEmno+"</td>"+	//사원번호
								"<td>" +v.empName+"</td>"+	//사원이름
								"<td>" +v.deptName+"</td>"+	//부서명
								"<td>" +v.rankName+"</td>"+	//직급명
							"</tr>"									
					);//Tbody
				}); //each.list
				
				$("input[type='checkbox'][name=empEmnoChk]").click(function(){	// 체크박스 선택 1개로 제한(라디오버튼처럼)
					if($(this).prop('checked')){ //check 이벤트가 발생했는지
						//체크박스 전체를 checked 해제후 click한 요소만 true로 지정
						$("input[type='checkbox'][name=empEmnoChk]").prop("checked", false);
						$(this).prop('checked',true);
					}
				});
				
				//테이블 내용 가운데 정렬
				$('#vacCntEmpListTable tr').children().addClass('text-center');
				
				$(function(){ //테이블 정렬
					$("#vacCntEmpListTable").tablesorter();
				});
				$(function(){
					$("#vacCntEmpListTable").tablesorter({sortList: [[0,0], [1,0]]});
				});
				
			}// else if
		});//paging.ajax
	}//vacEmpList
	
	//선택한 사원정보를 휴가신청 폼에 자동 입력하기
 	function empEmnoClick(){
 		var chkTr = $('input[name=empEmnoChk]:checked').closest('tr'); //체크된 체크박스와 가장 가까운 tr
 		var empEmnoVal = chkTr.children().eq(2).text(); //tr 하부 2번째 td의 텍스트(사번)
 		var empNameVal = chkTr.children().eq(3).text(); //tr 하부 3번째 td의 텍스트(이름)
 		var deptNameVal = chkTr.children().eq(4).text(); //tr 하부 4번째 td의 텍스트(부서)
 		var rankNameVal = chkTr.children().eq(5).text(); //tr 하부 5번째 td의 텍스트(직급)
//  		console.log(empEmnoVal, nameVal, departmentVal, positionVal);	
 		
 		$('#reqEmpEmno').val(empEmnoVal);
 		$('#empName').val(empNameVal);
 		$('#deptName').val(deptNameVal);
 		$('#rankName').val(rankNameVal);
 		$(".modal-body input[name=keyword]").val(""); //키워드 내용 지우기
 	}
	/* 사원선택 모달 END */
 	

</script>
</head>
<body>
	<div class="main" style="min-height: 867px;">
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">휴가신청</h3>
				<div class="panel">
					<div class="panel-body">
						<form class="form-inline" id="vacReqFrm" name="vacReqFrm" method="post">
							<input type="hidden" name=""><!-- 권한 -->
							<input type="hidden" name="empEmno" value="<%=(String)session.getAttribute("userEmno")%>"><!-- 등록자 -->
							<input type="hidden" name="crtEmpEmno" value="<%=(String)session.getAttribute("userEmno")%>"><!-- 등록자 -->
							
							<table class="table table-bordered">
								<tr>
									<td>휴가신청일</td>
									<td>
										<!-- 사원 권한: 오늘 날짜 고정 -->
<!-- 									  <input type="text" class="form-control" name="vastCrtDate" id="tDate" readonly> -->
										
										<!-- 관리자 권한: 달력 -->
										<div class="input-group date" id="crtDate">
									  	<input type="text" class="form-control" id="vastReqDate" name="vastReqDate"/>
									  	<input type="hidden" class="form-control" id="vastCrtDate" name="vastCrtDate"/>
									    <span class="input-group-addon" id="calenderInp">
										    <span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
									    </span>
									  </div>

									</td>
									<td>휴가구분</td>
									<td>
<!-- 										<select class="form-control" name="vacationTypeList" id="vacationTypeList" onchange="vacSelect(this.vacReqFrm)"> -->
										<select class="form-control" name="vacationTypeList" id="vacationTypeList">
										</select>
										<input type="hidden" id="vacationTypeHidden"><!-- 휴가타입 히든 -->
									</td>
									<td>전자결재상태</td>
									<td style="padding-left:0.5em"><input type="text" class="form-control" name="vastProgressSituation" id="vastProgressSituation" value="승인대기" readonly></td>
<!-- 									<td><i class="fa fa-asterisk-red" aria-hidden="true" ></i>전일/반일</td> -->
<!-- 									<td> -->
<!-- 										<label class="fancy-radio-inline"> -->
<!-- 											<input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> -->
<!-- 											<span><i></i>전일</span> -->
<!-- 										</label> -->
<!-- 	 									<label class="fancy-radio-inline"> -->
<!-- 	 										<input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> -->
<!-- 	 										<span><i></i>반일</span> -->
<!-- 										</label> -->
<!-- 									</td> -->
								</tr>
								
								<tr><!-- 신청자도 관리자와 사원 기능 따로 만들기 -->
									<td><!-- <i class="fa fa-asterisk-red" aria-hidden="true" ></i> -->신청자</td>
									<td colspan="5" style="padding-left:0.5em">
										<div class="input-group">	
											<input type="text" class="form-control" id="reqEmpEmno" name="reqEmpEmno" placeholder="사번" value="">
											<span class="input-group-addon" data-toggle="modal" data-target="#empEmnoModal" style="cursor:pointer" id="search" onclick="vacationReqEmpList()">
												<span class="glyphicon glyphicon-search" aria-hidden="true"></span> <!-- 검색 아이콘 -->
											</span>
										</div>
											<input type="text" class="form-control" id="empName" placeholder="이름" value="">
											<input type="text" class="form-control" id="deptName" placeholder="부서" value="">
											<input type="text" class="form-control" id="rankName" placeholder="직급" value="">
									</td>									
								</tr>
								
								
								<tr>
									<td>휴가기간</td>
									<td colspan="5" style="padding-left:0.5em">
										<!-- 달력 start-->
										<div class="input-group date" id="startDate">
									  		<input type="text" class="form-control" id="vastStartDate" name="vastStartDate"/>
										    <span class="input-group-addon">
											    <span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
										    </span>
										</div>
										~
										<!-- 달력 end-->
										<div class="input-group date" id="endDate">
									  		<input type="text" class="form-control" id="vastEndDate" name="vastEndDate"/>
										    <span class="input-group-addon">
											    <span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
										    </span>
									  </div>
										(일수: <input type="text" class="form-control" id="vastVacUd" name="vastVacUd" readonly>)
									</td>

								</tr>
								<tr>
									<td>휴가사유</td>
									<td colspan="7" style="padding-left:0.5em"><input type="text" class="form-control" name="vastCont" id="vastCont"></td>
								</tr>
							</table>
							<div class="text-right">
								<button type="button" class="btn btn-primary" id="submitGo" onclick="check_onclick('${pageContext.request.contextPath}/vacationRequest.exc', 'vacReqFrm')">신청하기</button>
<!-- 									<button type="button" class="btn btn-primary" onclick="check_onclick()">신청하기</button> -->
							</div>
						</form>
					</div>
				</div>
				
				<div class="panel">
					<div class="panel-body">
						<p> ※ 경조사 발생 시 관련 증빙 제출(사망진단서, 청첩장, 출생증명서) </p>
						<p> ※ 반차일 경우 휴가 시작날짜와 종료날짜가 같아야 합니다. </p>
					</div>
				</div>
				
				
				<!--*********** 사원번호 Modal***************** -->
				<div id="empEmnoModal" class="modal fade" role="dialog">
				  <div class="modal-dialog">
					  
					  
					  <!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<p class="modal-title">사번 정보 조회</p>
							</div>
							<div class="modal-body"><!-- 검색부분 -->
								<div class="search_wrap" style="padding: 0px 10px 20px 15px; ">
									<form class="form-inline" id="vacEmpListModal">
										검색어
										<select name="seacrchOption" class="form-control">
											<option value="empEmno">사번</option>
											<option value="empName">성명</option>
											<option value="deptName">부서</option>
										</select>
										<input type="text" class="form-control" name="keyword">&nbsp;&nbsp;&nbsp;
										<label class="fancy-checkbox-in	line">
											<input type="checkbox" id="retrChk">
											<span>퇴직자 포함</span>
										</label>
										<input type="hidden" name="retrDelYn" id="retrDelYn">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="hidden" name="baseYear">
										<input type="button" class="btn btn-primary" style="float:right;" id="searchBtn" onclick="vacationReqEmpList()" value="검색">
									</form>
								</div>
					
								<div class="list_wrap">
									<table class="table tablesorter" id="vacCntEmpListTable">
											<thead style="display:table;width:100%;table-layout:fixed;">
												<tr>
													<th class="sorter-false"></th>
													<th>구분</th>
													<th>사원번호</th>
													<th>성명</th>
													<th>부서</th>
													<th>직급</th>
												</tr>
											</thead>
											<tbody id="vacCntEmpListTbody" style="display:block;height:200px;overflow:auto;">
											</tbody>
										</table><!-- vacEmpList END -->
								</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="empEmnoClick()">선택</button>
							</div>
							</div>
						</div>

				</div>
			</div>
			<!-- END MODAL -->
			</div>
		<!-- END MAIN CONTENT -->
		</div>
	</div>
	<!-- END MAIN -->
</body>
</html>