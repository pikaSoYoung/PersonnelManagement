<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
 <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
 <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="resources/common/js/jquery-3.2.1.js"></script> -->
<!-- <script src="http://malsup.github.com/jquery.form.js"></script> -->
<!-- <script src="resources/common/js/paging.js"></script> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<%-- <link rel="stylesheet"
	href="<c:url value="/resources/common/assets/vendor/bootstrap/css/bootstrap.min.css"/>">
<link rel="stylesheet"
	href="<c:url value="/resources/common/assets/vendor/font-awesome/css/font-awesome.min.css"/>">
<link rel="stylesheet"
	href="<c:url value="/resources/common/assets/vendor/linearicons/style.css"/>">
<link rel="stylesheet"
	href="<c:url value="/resources/common/assets/vendor/chartist/css/chartist-custom.css"/>"> --%>
<!-- MAIN CSS -->

<%-- <link href="<c:url value="/resources/common/assets/css/main.css" />"
	rel="stylesheet">
<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
<link rel="stylesheet"
	href="<c:url value="/resources/common/assets/css/demo.css"/>">
<!-- GOOGLE FONTS -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700"
	rel="stylesheet">

<!-- ICONS -->
<link rel="apple-touch-icon" sizes="76x76"
	href="assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="assets/img/favicon.png"> --%>
<style type="text/css">
.panel-body .tbl01 td {
	vertical-align: middle;

}
.modal-content.modal-fullsize {
  height: auto;
  min-height: 100%;
  border-radius: 0; 
  
}
.table-bordered .tbmiddle td {
	vertical-align: middle;
	text-align:center;
}
.modal-dialog.modal-fullsize { 
  width: 100%; height: 100%; margin: 0; padding: 0; 
  
}
.btn-group-xxs > .btn, .btn-xxs {
    padding: 1px 1px;
}


</style>

<script type="text/javascript">
	
	function paycExcelExport(){
	    $("[id=lookpayc]").excelexportjs({
	       containerid: 'lookpayc',
	       datatype: 'table'
	    });
	 }
		
	
	function newPayc() { //----------------------급여대장폼
		var arr = new Array();
		var json;
		var yac = 12;
		var count = 0;
		var selectrcount = 0;
		$.ajax({

			url : "/spring/newPayc.ajax",
			type : 'GET',
			data : json,

			success : function(data) {

				console.log("결과데이터 : " + JSON.stringify(data));
				var pyy = data.yy;
				var pmm = data.mm;

				console.log(pyy);

				for (var i = pyy; i > pyy - yac; i--) {

					if ($("option[name=" + i + "]").val() != null) {

						$("option[name=" + i + "]").remove();
					}
					$("select[name=pyy]").append(
							'<option id='+i+'>' + i + '</option>');
					$("select[name=syy]").append(
							'<option id='+i+'>' + i + '</option>');
					$("select[name=eyy]").append(
							'<option id='+i+'>' + i + '</option>');
					$("select[name=payyy]").append(
							'<option id='+i+'>' + i + '</option>');

				}

				while (count < 12) {

					if ($("option[id=" + pmm + "]").val() != null) {
						$("option[id=" + pmm + "]").remove();
					}

					if (pmm > 12) {

						pmm = 1;
					}

					$("select[name=pmm]").append(
							'<option id='+pmm+'>' + pmm + '</option>');
					$("select[name=smm]").append(
							'<option id='+pmm+'>' + pmm + '</option>');
					$("select[name=emm]").append(
							'<option id='+pmm+'>' + pmm + '</option>');
					$("select[name=paymm]").append(
							'<option id='+pmm+'>' + pmm + '</option>');
					pmm++;
					count++;
				}

				$("input[name=ed]").val(data.ld);
				$("input[name=paytoday]").val(data.today);

			},

			error : function(jqXHR, textStatus, errorThrown) {
				alert("날짜 정보를 받아올 수 없습니다.");

			}

		});
	 }
	function makePayc(formId) {//--------------------- 급여대장 생성
			
		var json;
		//var json = {"pyymm":pyymm, "paycname":paycname, "payday":payyy+paymm+paytoday, "payyymm":payyy+paymm}; 
		$("#" + formId).ajaxForm({
						
			url:"/spring/makePayc.ajax",
			type:'GET',
			data:json,
						
			success:function(data) {
										
				if(data.success == "true") {
								
					alert("저장성공!");
				}else {
								
					alert("중복된 급여대장이 있습니다.");
				}
					console.log("결과데이터 : "+JSON.stringify(data));
					location.reload();
				},
						
				error:function(jqXHR, textStatus, errorThrown){
					alert("중복된 급여대장이 있습니다. \n");         
				}
						
		}).submit();
	} 
//---------------------------------  급여대장 조회   ------------------------------------------
	function selectPayc(i) {		
		var yymm = $("input[name=yymm"+i+"]").val();	
		var json={"yymm" :yymm};
		$("[id=paycyymm]").text(yymm+" 급여대장 ");
		//alert(yymm);
		$.ajax({

			url : "/spring/payc_select.ajax",
			type : 'GET',
			data : json,

			success : function(data) {
				console.log("결과데이터 : "+JSON.stringify(data));
				selectrcount = data.list.length;
				
				var color;
				
				for(var i=0; i<data.list.length; i++) {
					
					if(i%2==0){
						
						color = "<tr class='active'>";
					}else{
						color = "<tr>";
					}
					 $("[id=select_list]").append(color
					 								  +"<td id=sempname"+i+">"+ data.list[i].EMP_NAME +"</td>"
					 								  +"<td class=align-right id=ssal"+i+">"+ data.list[i].SCAL_SAL +"</td>"
					 								  +"<td class=align-right id=sfdex"+i+">"+ data.list[i].SCAL_FDEX +"</td>"
					 								  +"<td>"+data.list[i].SCAL_CMC+"</td>"
					 								  +"<td></td>"
					 								  +"<td class=align-right></td>"
					 								  +"<td>"+data.list[i].SCAL_ITAX+"</td>"
					 								  +"<td>"+data.list[i].SCAL_LTAX+"</td>"
					 								  +"<td>"+ data.list[i].SCAL_NPEN +"</td>"
					 								  +"<td>"+ data.list[i].SCAL_HFEE +"</td>"
					 								  +"<td></td>"
					 								
					 							+"</tr>");
			
					 $("[id=select_list]").append(color
							 						+"<td id=sempcode"+i+">"+data.list[i].EMP_EMNO+"</td>"
													+"<td></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td>"+data.list[i].SCAL_TAMT+"</td>"
													+"<td></td>"
													+"<td>"+ data.list[i].SCAL_EFEE +"</td>"
													+"<td></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td></td>"

												+"</tr>");
					 
					 $("[id=select_list]").append(color
							 						+"<td id=sempcode"+i+"></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td> <strong>"+data.list[i].SCAL_AAMT+"</strong></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td></td>"
													+"<td> <strong>"+data.list[i].SCAL_DAMT+"</strong></td>"
													+"<td> <strong>"+data.list[i].SCAL_FAMT+"</strong></td>"

												+"</tr>");
					//console.log(data.list[i].SCAL_EMYM);
					
					
				}
				/*  $("[id=total]").append("<tr>"
						 					+"<td rowspan='3'>합계</td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
				 						+"</tr>"
				 						
				 						+"<tr>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					
			 							+"</tr>"
			 						
			 							+"<tr>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					+"<td></td>"
						 					
		 						  +"</tr>"
				 ); */
				
			},
				
			error:function(jqXHR, textStatus, errorThrown){
					//alert("중복된 급여대장이 있습니다. \n" + textStatus + " : " + errorThrown);
				            
			}
		});
	}
//-------------------------------------  전체계산	----------------------------------------
	function acalPayc(i) {	
		var yymm = $("input[name=yymm"+i+"]").val();
		var json ={"yymm":yymm}
		
		if(confirm("직원급여 정보를 바탕으로 계산됩니다.")){
			
			//alert(yymm);
			
			$.ajax({

				url : "/spring/payc_acal.ajax",
				type : 'GET',
				data : json,

				success : function(data) {
					console.log("결과데이터 : "+JSON.stringify(data));
					
					$("[id=totalaamt"+data.yymm+"]").text(numberWithCommas(data.totalaamt));
				},
					
				error:function(jqXHR, textStatus, errorThrown){
						alert("에러 \n" + textStatus + " : " + errorThrown);
					            
				}
			});
		}else{
			
		}
		//alert("직원급여 정보를 바탕으로 계산됩니다.");
		
	}
//--------------------------------------------------------------------------------	
//------------------------ 		급여 조회 리스트 삭제 	 ---------------------------------	
	function removeSelect(){
		
		/* alert(selectrcount);
		for(var i=0; i<selectrcount; i++) {
			
			alert($("td [name=sempname"+i+"]").val());
			$("#ssal"+i).remove;
			$("#sfdex"+i).remove;
		} */
		$("[id=select_list]").children().remove();
		$("[id=total]").children().remove();
	/* 	$("td[id*=sempname]").remove();
		$("td[id*=ssal]").remove();
		$("td[id*=sfdex]").remove();
	    $("td[id*=sempcode]").remove(); */
		
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

//----------------------------------------------------------------------------------	
</script>

</head>
<body>

<div class="main">
	<div class="main-content">

		<div class="container-fluid">
			<h3 class="page-title">급여대장</h3>

			<div class="col-md-10">
				<div class="panel">
					<div class="panel-heading">
					
					</div>
						<div class="panel-body">
							
							<table class="table table-bordered tbl01">
								
									<thead>
										<tr>
											<th>신고 귀속</th>
											<th>대장명칭</th>
											<th>지급일</th>
											<th>지급연월</th>
											<th colspan="2">사전작업</th>
											<th colspan="2">급여계산</th>
											<th>급여대장</th>
											<th>지급총액</th>
										</tr>
									</thead>
									<c:forEach var="regi" items="${list}" varStatus="status">
										<tr>
											<td rowspan="2">${regi.SREG_YYMM}</td> 
											<form id="cal" name="yymm">
												<input type="hidden" name="yymm${status.index}" value="${regi.SREG_YYMM}">
											</form> 
											<td rowspan="2">${regi.SREG_NAME}</td>
											<td align="center" rowspan="2">${regi.SREG_PDAY }</td>
											<td align="center" rowspan="2">${regi.SREG_PYYMM }</td>


											<td align="center"></td>
											<td align="center">근무기록확정</td>
											<td align="center" rowspan="2"></td>
											<td align="center" rowspan="2"><a href="#" onclick="acalPayc('${status.index}'); return false" >전체계산</a>
												<p>수정
											</td>

											<td align="center" rowspan="2"> 
											
											<!-- data-backdrop="static" -->
												<button type="button" class = "btn btn-success btn-xxs"data-backdrop="static" data-keyboard="false" 
												data-toggle="modal" data-target="#myModal1" 
												data-title="Test Title" onclick="selectPayc('${status.index}')">조회</button>
												
											<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
												aria-labelledby="myModalLabel" aria-hidden="true">
												<div class="modal-dialog modal-fullsize" role="document">
													  <div class="modal-content modal-fullsize">
														<div class="modal-content">

															<div class="modal-body" data-spy="scroll" style="position: relative;">
																<h1 id="paycyymm"></h1>
																<table id="lookpayc" class="table table-bordered tbmiddle" >
																	 		
															 			<tr class="info">
																			<td>성명</td>
																			<td>급여</td>
																			<td>식대</td>
																			<td>차량유지비</td>
																			<td>직책수당</td>
																			<td>휴가</td>
																			<td>소득세</td>
																			<td>주민세</td>
																			<td>국민연금</td>
																			<td>건강보험</td>
																			<td>장기요양</td>
																		</tr>
																	
																		<tr class="info">
																			<td>사번</td>
																			<td>휴일근무수당</td>
																			<td>야간근로수당</td>
																			<td>지각,조퇴</td>
																			<td>교통비</td>
																		    <td>상여금</td>
																			<td>고용보험</td>
																			<td>기타공제</td>
																			<td>정산환급금</td>
																			<td></td>
																			<td></td>
																			
																		</tr>
																	
																		<tr class="info">
																			<td>직급</td>
																			<td></td>
																			<td></td>
																			<td></td>
																			<td></td>
																			<td><strong>지급총액</strong></td>
																			<td></td>
																			<td></td>
																			<td></td>
																			<td><strong>공제총액</strong></td>
																			<td><strong>실지급액</strong></td>
																		</tr>
																		
																		<tbody id="select_list">
																		
																		</tbody>
																		
																		<tbody id="total">
																		
																		</tbody>
																</table>
																
															</div>
				
															<div class="modal-footer">
																
																<button type="button" class="btn btn-default pull-left"
																	data-dismiss="modal" onclick="removeSelect();">닫기</button>
																
																<button type="button" id ="exceldown" class="btn btn-info pull-left"
														  			 onclick="paycExcelExport();">엑셀 다운</button>
																
															</div>	
														</div>
													</div>
												</div>
											</div>
											<br>명세서<br>확정<br>삭제
											</td>

											<td id="totalaamt${regi.SREG_YYMM}" rowspan="2" align="right">${regi.SREG_AAMT}</td>

										</tr>

										<tr>
											<td></td>
											<td align="center">금액직접입력</td>


										</tr>
									</c:forEach>
							</table>

							<form id="frm" name="fn">
							<div>
								<button type="button"  class="btn btn-primary" data-backdrop="static" data-keyboard="false"
									data-toggle="modal" data-target="#myModal"
									data-title="Test Title" onclick="newPayc()">신규</button>

								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">

									<div class="modal-dialog">
										<div class="modal-content">
										
										
											<div class="modal-header">
												<!-- 모달버튼 헤더 -->
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">×</span>
												</button>
												<h4 class="modal-title" id="myModalLabel">신규 급여대장</h4>
											</div>

											
												<div class="modal-body">
													<!-- 모달버튼 바디 -->

													<table class="table table-bordered tbl01">
														

														<thead>
															<th>귀속연월</th>

															<td>
																<select name="pyy"></select>

															 	<select name="pmm"></select>
															</td>

														</thead>	
							
														<thead>
															<th>대상기간</th>

															<td>
																<select name="syy"></select> 
																<select name="smm"></select>

																<input type="text" name="sd" value="1" style="width: 20px; height: 22px">
																<p>

																<select name="eyy"></select> 
																<select name="emm"></select>

																<input type="text" name="ed" style="width: 20px; height: 22px">
															</td>
														</thead>
														
														<thead>
															<th>지급일</th>

															<td>
																<select name="payyy"></select> 
																<select name="paymm"></select> 
																<input type="text" name="paytoday" style="width: 20px; height: 22px">
																<p>
															</td>
														</thead>
														
														<thead>
															<th>대장명칭</th>
															
															<td>
																<input type="text" name="paycname">
															
															</td>
														</thead>
													</table>
													
												</div>
											

											<div class="modal-footer">
												
												<button type="button" class="btn btn-default pull-left"
													data-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-primary"
													data-dismiss="modal" onclick="makePayc('frm');">저장</button>
												
											</div>
											
										</div>
									</div>
									
								</div>
								

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