<!-- 
출장 정산 : 제영호  / 이용선
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>출장정산</title>
<script>

	$(function () {
		//$('#btstBtStartDate').val(moment().format('YYYY-MM-DD')); //출장신청일
		$('#btstBtEndDate').val(moment().format('YYYY-MM-DD')); //출장종료일
		$('#requestYearMonthStart').datetimepicker({ //신청년월 시작 달력
			viewMode: 'days',
			format: 'YYYY-MM-DD'
		});
		
		$('#requestYearMonthEnd').datetimepicker({ //신청년월 끝 달력
			viewMode: 'days',
			format: 'YYYY-MM-DD'
		});
	
		$('#settlementDate').datetimepicker({ //정산일자 달력
			viewMode: 'days',
			format: 'YYYY-MM-DD'
		});
	});//function
	
	/* 사원선택 모달 start */
 	function empListModal(url, formId){ //사원정보조회 리스트 출력
 		$('#empModalTbody').empty(); //이전 리스트 삭제
 		
 		//퇴직자 포함 체크여부
 		if(($('#retrChk').prop("checked")) == true ){
 			$('#retrDelYn').val('on');
 		}else{
 			$('#retrDelYn').val('off');
 		}
 		
		paging.ajaxFormSubmit(url, formId, function(rslt){
 			console.log("ajaxFormSubmit -> callback");
 			console.log("결과데이터:"+JSON.stringify(rslt));

 			$('#empModalTable').children('thead').css('width','calc(100% - 1em)'); //테이블 스크롤 css
 			
 			if(rslt == null){
 				$('#empModalTbody').append( //리스트가 없을 경우 : 조회된 데이터가 없습니다
 	 				"<div class='text-center'><br><br><br><br>조회할 데이터가 없습니다.</div>"
 	 			);
 			}else if(rslt.success == "Y"){
 	 			$.each(rslt.empList, function(k, v) {
					$('#empModalTbody').append(
	 	 				"<tr style='display:table;width:100%;table-layout:fixed;'>"+
							"<td>"+
								"<label class='fancy-checkbox-inline'>"+
									"<input type='checkbox' name='emnoChk'>"+ //checkbox
									"<span></span>"+
								"</label>"+
							"</td>"+
							"<td>"+ v.empEmno +"</td>"+ //사원번호
							"<td>"+ v.empName +"</td>"+ //사원명
							"<td>"+ v.deptName +"</td>"+ //부서명
							"<td>"+ v.rankName +"</td>"+ //직급명
						"</tr>"
					);
 	 			});
 			}

 	
		 	//사원선택 체크박스 선택 1개로 제한(라디오버튼처럼)
			$(function(){
				$("input[type='checkbox'][name='emnoChk']").click(function(){
					if($(this).prop("checked")){ //check 이벤트가 발생했는지
						//체크박스 전체를 checked 해제후 click한 요소만 true로 지정
						$("input[type='checkbox'][name='emnoChk']").prop("checked", false);
						$(this).prop("checked",true);
					}
				});
			});

			//테이블 정렬
			$(function(){
				$("#empModalTable").tablesorter();
			});
			
			$(function(){ 
				$("#empModalTable").tablesorter({sortList: [[0,0], [1,0]]}); 
			});
		 	
		});
 	}


 	//선택한 사원정보를 출장신청 폼에 자동 입력하기
 	function emnoClick(){
 		var chkTr = $("input[name='emnoChk']:checked").closest("tr"); //체크된 체크박스와 가장 가까운 tr
 		var empEmnoVal = chkTr.children().eq(1).text(); //tr 하부 2번째 td의 텍스트(사번)
 		var empNameVal = chkTr.children().eq(2).text(); //tr 하부 3번째 td의 텍스트(이름)
 		var deptNameVal = chkTr.children().eq(3).text(); //tr 하부 4번째 td의 텍스트(부서)
 		var rankNameVal = chkTr.children().eq(4).text(); //tr 하부 5번째 td의 텍스트(직급)

 		$('#empEmno').val(empEmnoVal);
 		$('#empName').val(empNameVal);
 		$('#deptName').val(deptNameVal);
 		$('#rankName').val(rankNameVal);
 	}
 	
 	/* 사원선택 모달 end */
 	
 	//검색ajax
 	function searchForm(obj){
 		$(obj).ajaxForm({
 			async:true, 
			cash:false, 
			type:"post", 
			url	:'searchBusinessList',
			dataType:"JSON", 
            success : function(data) {
            	var jsonStr = JSON.stringify(data);
                var jsonObj = JSON.parse(jsonStr);
                console.log(jsonStr);
                $("#dataTable").children().remove();//리스트tbody부분삭제
				$.each($(jsonObj), function(i , objVal){
					var str ="<tr align='center' onclick=''>";
					str+="<td>"+this.bsNumber+"</td>";
					str+="<td>"+this.bcDate+"</td>";
					str+="<td>"+this.empName+"</td>";
					str+="<td>"+this.bbP+"</td>";
					str+="<td>"+this.bbPf+"</td>";
					str+="</tr>";
		            $("#dataTable").append(str);
				});
                
            }, // success 
    
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }).submit();
    }//end 검색ajax
    
  	
</script>
</head>
<body>
	<div class="main" style="min-height: 867px;">
		<div class="main-content">
			<div class="container-fluid">
			<h3 class="page-title">출장정산</h3>
				<div class="panel">
					<div class="panel-body">
						<form class="form-inline" id="busiFrm" method="POST">
							<table class="table table-bordered">
								<tr align="center">
									<td>신청년월</td>
									<td>
										<!-- 달력 : 신청년월 시작 -->										
										<div class="input-group date" id="requestYearMonthStart">
											<input type="text" class="form-control" id="btstBtStartDate" name="btstBtStartDate"/>
												<span class="input-group-addon">
													<span class="fa fa-calendar" />
												</span>
										</div>  
										~  
										<!-- 달력 : 신청년월 끝 -->										
										<div class="input-group date" id="requestYearMonthEnd">
											<input type="text" class="form-control" id="btstBtEndDate" name="btstBtEndDate"/>
												<span class="input-group-addon">
													<span class="fa fa-calendar" />
												</span>
										</div>
									</td>
									
									<td>사원번호</td>
									<td>
										<input type="text" class="form-control" id="empEmno" name="empEmno" readOnly>
										<span class="glyphicon glyphicon-search" aria-hidden="true" data-toggle="modal" data-target="#emnoModal" onclick="empListModal('${pageContext.request.contextPath}/businessRequestEmpList.ajax','busiFrm')"></span> <!-- 검색 아이콘 -->
										<input type="button" class="btn btn-danger" style="float:right;"name="search" value="검색" onclick="searchForm(busiFrm)">
										
									</td>  
								</tr>
							</table>
						</form>		
					</div>
				</div>
				<p>
				<div class="row">
					<div class="col-md-6">
						<div class="panel">
							<div class="panel-body">
								<h4>◈ 출장신청내역</h4>
								<form class="form-inline" name="">
									<table class="table table-bordered">
										<thead>
											<tr align="center">
												<td>신청번호</td>
												<td>신청일자</td>
												<td>신청자</td>
												<td>출장목적</td>
												<td>예상출장비</td>
											</tr>
										</thead>
										<tbody id="dataTable">
											<c:forEach var="list" items="${list}" varStatus="status">
											<tr align="center" onclick="" style="cursor:Default">
												<td>${list.bsNumber}</td>
												<td>${list.bcDate}</td>
												<td>${list.empName}</td>
												<td>${list.bbP}</td>
												<td>${list.bbPf}</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</form>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel">
						<div class="panel-body">
							<form action="">
								<input type="button" class="btn btn-danger btn-xs" style="float:right;"name="delete" value="삭제">
								<input type="button" class="btn btn-danger btn-xs" style="float:right;"name="update" value="저장">
							</form>							
							<h4>◈ 출장정산</h4>
							<table class="table table-bordered">
								<tr align="center">
									<td>정산번호</td>
									<td>자동입력</td>
									<td>정산일자</td>
									<td>
										<!-- 달력 : 정산일자	 -->									
										<div class="input-group date" id="settlementDate">
											<input class="form-control input-sm" placeholder="좀 되라!!!" type="text">
												<span class="input-group-addon">
													<span class="fa fa-calendar" />
												</span>
										</div>
									</td>
								</tr>
								<tr align="center">
									<td>전자결재상태</td>
									<td></td>
									<td>전표번호</td>
									<td></td>
								</tr>
								<tr align="center"> 
									<td>전표상태</td>
									<td></td>
									<td>전표반려일자</td>
									<td></td>
								</tr>
								<tr align="center"> 
									<td>전표반려자</td>
									<td></td>
									<td>전표반려사유</td>
									<td></td>
								</tr>
								<tr align="center"> 
									<td>프로젝트</td>
									<td align="left" colspan="3">
									<select>
									<option value="">해당없음</option>
									</select>
									</td>
								</tr>
								<tr align="center" > 
									<td>정산내용</td>
									<td colspan="3"></td>
								</tr>
							</table>
						</div>	
					</div>	
				</div>
			</div>
				<p>
				<div class="panel">
					<div class="panel-body">		
						<form action="">
							<input type="button" class="btn btn-danger btn-xs" style="float:right;"name="delete" onClick="addRow('');" value="행삭제">
							<input type="button" class="btn btn-danger btn-xs" style="float:right;"name="delete" onClick="delRow('');" value="행추가">
						</form>
						<h4>◈ 출장정산내역</h4>
						<table id="businessAdj" class="table table-bordered" >
							<tr align="center"> 
								<td>No</td>
								<td>계정과목</td>
								<td>계정과목명</td>
								<td>금액</td>
								<td>비고</td>
							</tr>
							<tr align="center">
								<td colspan="5"  height="100px">데이터가 없습니다.</td>
							</tr>
							<tr align="center">
								<td></td>
								<td></td>
								<td>합계</td>
								<td>0</td>
								<td></td>
							</tr>
						</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 사원번호 Modal -->
	<div id="emnoModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	  
	  <!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<p class="modal-title">사번 정보 조회</p>
			</div>
			<div class="modal-body">
				<div class="search_wrap" style="padding: 0px 10px 20px 15px; ">
					<form class="form-inline" id="empFrm">
						검색어&nbsp;<input type="text" class="form-control" name="keyword">&nbsp;&nbsp;&nbsp;
						<label class="fancy-checkbox-inline">
							<input type="checkbox" id="retrChk">
							<span>퇴직자 포함</span>
						</label>
						<input type="hidden" name="retrDelYn" id="retrDelYn" >
						<input type="button" class="btn btn-primary" style="float:right;" name="search" onclick="empListModal('${pageContext.request.contextPath}/businessRequestEmpList.ajax','empFrm')" value="검색">
					</form>
				</div>

				<div class="list_wrap">
					<table class="table tablesorter table-bordered" id="empModalTable">
						<thead style="display:table;width:100%;table-layout:fixed;">
							<tr>
								<th></th>
								<th>사원번호</th>
								<th>이름</th>
								<th>부서</th>
								<th>직급</th>
							</tr>
						</thead>
						<tbody id="empModalTbody" style="display:block;height:200px;overflow:auto;">






						</tbody>
					</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="emnoClick()">선택</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END MODAL -->
</body>
</html>