<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="/spring/resources/common/js/pagingNav.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script>
	
	/* ================================ 메인 공통코드 관련  ========================================== */		
			
			/* 메인 공통코드 등록 */
			$("#insertBtn").on("click",function(){	//공통코드 최종 등록 버튼 눌렀을 때 함수 실행
				
				var thisModal = $("#insertModal form[id='insertForm']");	//해당 함수에서 반복적으로 사용할 formId(등록창에서의 formId)

				 if(thisModal.find("input[name='commName']").val() == ""){	//공통코드명을 입력하지 않았을 떄
					alert("코드명을 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commCodeInfo']").val() == ""){	//공통코드 정보를 입력하지 않았을 떄
					alert("코드정보를 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commRegMn']").val() == ""){	//공통코드 등록자를 입력하지 않았을 떄
					alert("등록자명을 입력해주세요.");
					return false;
				}
					
				
				var url = "/spring/commonInsert.do";
				var frm = $("#insertModal").find("form").attr("id");//공통코드 등록창의 formId
				
				if(confirm("등록 하시겠습니까?") == true){	//공통코드 최종등록(insert submit)하기 전에
					commInsertAjaxFormSubmit(url,frm);	//공통코드 등록 ajax함수 호출
				}else{								//공통코드 최종등록 취소 시
					return false;
				}//if
				
			});
			
			function commInsertAjaxFormSubmit(url,frm){	//공통코드 등록 ajax함수
			
				paging.ajaxFormSubmit(url,frm,function(result){
					
					if(result == 1){	//제대로 등록되었을 때
						alert("정상적으로 등록되었습니다.");
						location.href = "/spring/commonList.do";
					}else{				//제대로 등록이 안됐을 때 
						alert("등록에 실패하였습니다. 다시 시도해주세요.");
						location.href = "/spring/commonList.do";
					}//if
				});
			}
			/* 메인 공통코드 등록 */
			
			
			
			//검색 버튼 눌렀을 떄
			$("#searchPanel .panel-body").find("#searchBtn").on("click", function(){
				commSearchList();
			});
			
			//검색 Enter 키 눌렀을 때
			$("#searchPanel .panel-body").find("input[name='commonSearch']").on("keydown",function(e){
				if(e.keyCode == 13){
					commSearchList();
				}//if
			});
				
			/* 메인 공통코드 검색 목록 */
			function commSearchList(){
				
				var commonSelect = $("#searchPanel").find("select[name='commonSelect'] option:selected").val();//검색조건
				var commonSearch = $("#searchPanel").find("input[name='commonSearch']").val();	//검색내용
				
				var url = "/spring/commonSearchList.do";
				var data = {"commonSelect":commonSelect,"commonSearch":commonSearch};

				if(commonSelect == ('default')){	//검색조건을 선택하지 않았을 때
					alert("검색조건을 선택해주세요.");
					return false;
				}else if(commonSearch == ("")){		//검색내용을 입력하지 않았을 때
					alert("검색내용을 입력해주세요.");
					return false;
				}else{
				
					paging.ajaxSubmit(url,data,function(result){
						
						$("#commList").find("tbody > tr").remove();	//기존 공통코드 목록 삭제
						
						$.each(result,function(index,value){	//검색조건에 맞는 목록 동적 생성
						
							$("#commList").find("tbody").append(
									"<tr name='commCodeInfo' onClick='commInfoListFunc($(this))' data-toggle='modal' style='cursor:pointer'>" + 
										"<td name='commCode'>" + result[index].commCode + "</td>" +			//공통코드
										"<td name='commName'>" + result[index].commName + "</td>" +			//공통코드 명
										"<td name='commCodeInfo'>" + result[index].commCodeInfo + "</td>" +	//공통코드 정보
										"<td name='commRegMn'>" + result[index].commRegMn + "</td>" +		//공통코드 등록자
										"<td name='commCodeCrt'>" + result[index].commCodeCrt + "</td>" +	//공통코드 생성일
										"<td name='commCodeUpdt'>" + result[index].commCodeUpdt + "</td>" +	//공통코드 수정일
										"<td name='commDelYn'>Y</td>" +										//공통코드 사용여부
										"<td name='commUpdt' onclick='event.cancelBubble = true'>" + 		
											"<button type='button' class='btn btn-default' name='updateBtn'>수정</button>" +	//수정버튼
											"<button type='button' class='btn btn-default' name='deleteBtn'>삭제</button>" +	//삭제버튼
										"</td>" +
									"</tr>"	
	
							);
							
						});//each
						
						// 동적 생성한 태그에도 이벤트를 걸어주기 위해 해당 이벤트함수 호출
						$("div[id='commList'] table button[name='updateBtn']").on("click",function(){//공통코드 수정버튼 눌렀을 때 함수 실행
							commUpdateFunc($(this));	//공통코드 수정 함수에 수정하려는 해당 tr의 정보 넘기기
						});
						
						$("#commList table button[name='deleteBtn']").on("click",function(){	//공통코드 삭제버튼 눌렀을 때 함수 실행
							commDeleteFunc($(this));	//공통코드 삭제 함수에 삭제하려는 해당 tr의 정보 넘기기
						});
						
					});//paging.ajaxSubmit
					
					// 검색조건 목록에 맞는 pagingAjax 호출
					var url = "/spring/commonPaging.do";
					var commonSelect = $("#searchPanel select > option:selected").val();	//검색조건
					var commonSearch = $("#searchPanel input[name='commonSearch']").val();	//검색내용
					var data = {"commonSelect":commonSelect,"commonSearch":commonSearch};
					
					paging.ajaxSubmit(url,data,function(result){	//페이징에 관한 기본조건 가져오기 위한 ajax
						
						var allPostNum = result.allPostNum;			//전체게시물 개수
						var postNum = result.postNum;				//화면에 보여질 게시물 개수
						var pageNum = result.pageNum;				//화면에 보여질 페이지 개수
						var selectPageNum = result.selectPageNum;	//선택 페이지
						
						var data = {"allPostNum":allPostNum,"postNum":postNum,
								"pageNum":pageNum,"selectPageNum":selectPageNum};
						
						pagingFunc(data);	//pagingNav Ajax 호출
						
					});
				
				}//if
				
			}//commSearchList
			/* 메인 공통코드 검색 목록 */

			
			/* 메인 공통코드 수정 */
			$("div[id='commList'] table button[name='updateBtn']").on("click",function(){	//메인화면에서 공통코드 수정버튼 눌렀을 떄 함수 실행
				commUpdateFunc($(this));	//공통코드 수정 함수에 수정하려는 해당 tr의 정보 넘기기
			});
			
			function commUpdateFunc(obj){	//공통코드 수정 함수
				
				var thisForm = $("#updateModal form[id='updateForm']");	//해당 함수에서 반복적으로 사용할 form

				var commCode = obj.closest("tr").children("td[name='commCode']").text();		//공통코드
				var commName = obj.closest("tr").children("td[name='commName']").text();		//공통코드명
				var commCodeInfo = obj.closest("tr").children("td[name='commCodeInfo']").text();//공통코드 정보
				var commRegMn = obj.closest("tr").children("td[name='commRegMn']").text();		//공통코드 등록자
				
				thisForm.find("tr").find("td").find("input[name='commCode']").val(commCode);		//기존 공통코드 값을 value값으로 설정
				thisForm.find("tr").find("td").find("input[name='commName']").val(commName);		//기존 공통코드명을 value값으로 설정
				thisForm.find("tr").find("td").find("input[name='commCodeInfo']").val(commCodeInfo);//기존 공통코드 정보를 value값으로 설정
				thisForm.find("tr").find("td").find("input[name='commRegMn']").val(commRegMn);		//기존 공통코드 등록자를 value값으로 설정
				
				$("#updateModal").modal({backdrop:'static'},'show');	//수정창 동적으로 띄우기
				
			}//commUpdateFunc
			
			$("#updateModal .modal-footer button[name='submitBtn']").on("click",function(){	//공통코드 최종수정 버튼 눌렀을 떄 함수 실행
				
				var thisModal = $("#updateModal #updateForm").children("table");	//해당 함수에서 반복적으로 사용할 table
				
				if(thisModal.find("input[name='commName']").val() == ""){			//공통코드명을 입력하지 않았을 떄
					alert("코드명을 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commCodeInfo']").val() == ""){	//공통코드 정보를 입력하지 않았을 떄
					alert("코드정보를 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commRegMn']").val() == ""){	//공통코드 등록자를 입력하지 않았을 떄
					alert("등록자명을 입력해주세요.");
					return false;
				}//if
				
				var url = "/spring/commonUpdate.do";
				var frm = $("#updateModal").find("form").attr("id");	//공통코드 수정창의 formId
				
				if(confirm("정말로 수정하시겠습니까?") == true){	//공통코드 최종수정(update submit)전에
					commUpdateAjaxFormSubmit(url,frm);	//공통코드 수정 ajax함수 호출
				}else{
					return false;
				}//if
				
			});
			
			function commUpdateAjaxFormSubmit(url,frm){//공통코드 수정 ajax함수
				
				paging.ajaxFormSubmit(url,frm,function(result){
					
					if(result == 1){	//정상적으로 수정되었을 떄
						alert("정상적으로 수정되었습니다.");
						location.href = "/spring/commonList.do";
					}else{				//정상적으로 수정이 안되었을 때
						alert("수정에 실패하였습니다. 다시 시도해주세요.");
						location.href = "/spring/commonList.do";
					}//if
				});
				
			}//commUpdateAjaxSubmit
			/* 메인 공통코드 수정 */

			
			
			/* 메인 공통코드 삭제 */
			$("div[id='commList'] table button[name='deleteBtn']").on("click",function(){	//메인화면에서 공통코드 삭제 버튼을 눌렀을 떄
				commDeleteFunc($(this));	//공통코드 삭제 함수에 삭제하려는 해당 tr의 정보넘기기
			});
			
			function commDeleteFunc(deleteBtn){	//공통코드 삭제 함수
			
				var commCode = deleteBtn.closest("tr").children("td[name='commCode']").text();//삭제하려는 해당 공통코드 값
				
				if(confirm("정말로 삭제 하시겠습니까?") == true){	//공통코드 최종삭제(delete submit)하기 전에
					
					var url = "/spring/commonDeleteCheck.do";
					var data = {"commCode":commCode};
					
					commDeleteAjaxSubmit(url,data);	//공통코드 삭제 ajax함수 호출
					
				}else{	//공통코드 최종삭제 취소 시
					return false;
				}//if
			
			}//commDeleteFunc
			
			function commDeleteAjaxSubmit(url, data){	//공통코드 삭제 ajax함수
				
				paging.ajaxSubmit(url,data,function(result){

					if(result.listSize == 0 || result.listSize == "0"){	//삭제하려는 해당 공통코드의 하위코드가 없을 때만 삭제 가능
						location.href = "/spring/commonDelete.do?commCode="+data.commCode;
					}else{	//삭제하려는 해당 공통코드의 하위코드가 있으면 삭제 불가능
						alert("해당 코드는 삭제할 수 없습니다.");
						return false;
					}//if
					
				});
			}//commDeleteAjaxSubmit
			/* 메인 공통코드 삭제 */
			
			
			
	/* ================================ 하위 공통코드 관련(공통코드 상세보기) ========================================== */

			
			/* 하위 공통코드 등록 */
			$("#infoInsertBtn").on("click", function(){	//하위 공통코드 최종 등록 버튼 눌렀을 때
				
				var thisModal = $("#infoInsertModal").find("#infoInsertForm");	//해당 함수에서 반복적으로 사용할 formId
				
				if(thisModal.find("input[name='commName']").val() == ""){		//하위 공통코드명을 입력 안했을 떄
					alert("코드명을 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commCodeInfo']").val() == ""){ //하위 공통코드 정보를 입력 안했을 떄
					alert("코드정보를 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commRegMn']").val() == ""){	//하위 공통코드 등록자를 입력 안했을 떄
					alert("등록자명을 입력해주세요.");
					return false;
				}//if
				
				var url = "/spring/commonInfoInsert.do";
				var frm = $("#infoInsertModal").find("form").attr("id");	//하위 공통코드 등록창에서의 formId
				
				if(confirm("등록 하시겠습니까?") == true){	//하위 공통코드 최종등록(infoInsert submit) 전에
					
					if($("#infoInsertModal #infoInsertForm").find("span[name='checkValue']") == ""){//하위 공통코드 중복체크를 하지 않았을 떄
						alert("코드를 확인해주세요.");
						return false;
					}//if
					
					commInfoInsertAjaxFormSubmit(url,frm);	//하위 공통코드 등록 ajax함수 호출
				
				}else{	//하위 공통코드 최종등록 취소 시
					return false;
				}
				
			});
			
			function commInfoInsertAjaxFormSubmit(url,frm){	//하위 공통코드 등록 ajax함수
				
				paging.ajaxFormSubmit(url,frm,function(result){
					
					if(result == 1){	//정상적으로 등록 되었을 때
						alert("정상적으로 등록되었습니다.");
						location.href = "/spring/commonList.do";
					}else{				//정상적으로 등록 되지 않았을 때
						alert("등록에 실패하였습니다. 다시 시도해주세요.");
						location.href = "/spring/commonList.do";
					}//if
					
				});
			}
			// 하위 공통코드 등록 //
			
			
			
			// 하위 공통코드(공통코드 상세보기) 목록 //
			function commInfoListFunc(thisTr){	//하위 공통코드 목록 뿌리는 함수
				
				var url = "/spring/commonInfoList.do";
				var commCode = $(thisTr).find("td[name='commCode']").text();	//하위 공통코드를 상속하고 있는 공통코드(이하 부모코드)
				var data = {"commPrntCode":commCode};
				
				
				// 해당 하위코드들을 가져올 때 필요한 작업 //
				var commPrntCode = $(thisTr).find("td[name='commCode']").text();	//해당 코드를 부모코드로 지정
				var commPrntName = $(thisTr).find("td[name='commName']").text();	//해당 코드명을 부모코드명으로 지정
				
				if($("#infoInsertModal form[id='infoInsertForm']").find($("input[type='hidden']"))){//하위코드 등록창에 기존 hidden값이 있으면
					
					$("#infoInsertModal form[id='infoInsertForm']").find($("input[type='hidden']")).each(function(){//기존의 hidden값 지우기
						$(this).remove();
					});
					
				}//if
				
				//해당 코드를 부모코드,부모코드명으로써 hidden값에 넣은 후 그에 해당하는 하위코드들을 select 해오기 위한 작업
				$("#infoInsertModal form[id='infoInsertForm']").prepend("<input type='hidden' name='commPrntName' value='" + commPrntName + "'>");
				$("#infoInsertModal form[id='infoInsertForm']").prepend("<input type='hidden' name='commPrntCode' value='" + commPrntCode + "'>");
				// 해당 하위코드들을 가져올 때 필요한 작업  //
				
				commInfoListAjaxSubmit(url,data,commPrntCode,commPrntName);	//하위 공통코드 목록 뿌리는 ajax함수 호출
				
			}//commCodeInfoFunc
			
			function commInfoListAjaxSubmit(url,data,commPrntCode,commPrntName){//하위 공통코드 목록 뿌리는 ajax함수
				
				var commPrntCode = commPrntCode;	//인자값으로 받은 부모코드
				var commPrntName = commPrntName;	//인자값으로 받은 부모코드명
				
				//하위코드 목록(상세보기 창)에서 해당 하위코드의 부모코드와 부모코드명 출력
				$("#infoModal div[id='commPrntCodeLine']").html("<strong>"+commPrntCode+" - "+commPrntName+"</strong>"); 
				
				paging.ajaxSubmit(url, data, function(result){
					
					if(result.length == 0 || result == null){	//하위코드 목록(상세보기) 값이 없으면
						
						if($("div[id='infoModal'] tbody").find("tr")){	//기존에 생성 되어있던 목록 삭제
							
							$("div[id='infoModal'] tbody").find("tr").each(function(){
								$(this).remove();
							});
							
						}//if
						
						$("#infoModal").modal('show');	//하위코드 목록(상세보기) 모달띄움
					
					}else{	//하위코드 목록(상세보기) 값이 있으면
						
						if($("div[id='infoModal'] tbody").find("tr")){	//기존에 생성되있었던 목록 삭제
							
							$("div[id='infoModal'] tbody").find("tr").each(function(){
								$(this).remove();
							});
							
						}//if
						
						$.each(result, function(idx,value){	//해당 부모코드의 하위코드 목록 개수만큼 동적 생성
						
							if(result[idx].commCodeUpdt == null){
								result[idx].commCodeUpdt = "--------------";
							}//if
							
							$("div[id='infoModal'] tbody").append(
									"<tr onclick='commInfoListFunc($(this))' data-toggle='modal' style='cursor:pointer'>" +
										"<td name='commPrntCode'>" + result[idx].commPrntCode + "</td>" +	//부모코드
										"<td name='commCode'>" + result[idx].commCode + "</td>" +			//하위 공통코드
										"<td name='commName'>" + result[idx].commName + "</td>" +			//하위 공통코드명
										"<td name='commCodeInfo'>" + result[idx].commCodeInfo + "</td>" + 	//하위 공통코드 정보
										"<td name='commRegMn'>" + result[idx].commRegMn + "</td>" +			//하위 공통코드 등록자
										"<td name='commCodeCrt'>" + result[idx].commCodeCrt + "</td>" +		//하위 공통코드 생성일
										"<td name='commCodeUpdt'>" + result[idx].commCodeUpdt + "</td>" +	//하위 공통코드 수정일
										"<td name='commInfoBtn' onClick='event.cancelBubble=true'>" + 
											"<button type='button' name='infoUpdateBtn' class='btn btn-default' onClick='commInfoUpdateFunc($(this))'>수정</button>" +
											"<button type='button' name='infoDeleteBtn' class='btn btn-default' onClick='commInfoDeleteFunc($(this))'>삭제</button></td>" + 
										"</td>" + 
									"</tr>"
									
								);
							
						});//each

						$("#infoModal").modal('show');	//하위코드 목록(상세보기 창) 동적으로 띄우기
						
					}//if
					
				});
				
			}//commCodeInfoAjaxSubmit
			//공통코드 상세보기 목록//
			
			
			
			// 공통코드 상세보기에서 코드 수정 //
			function commInfoUpdateFunc(infoUpdateBtn){	//하위 공통코드(상세보기)수정 함수
				
				var thisForm = $("#infoUpdateModal form[id='infoUpdateForm']");	//해당 함수에서 반복적으로 사용할 formId
				
				var commCode = infoUpdateBtn.closest("tr").find("td[name='commCode']").text();	//수정하려는 해당 하위코드
				var commName = infoUpdateBtn.closest("tr").find("td[name='commName']").text();	//해당 하위코드명
				var commCodeInfo = infoUpdateBtn.closest("tr").find("td[name='commCodeInfo']").text();	//해당 하위코드 정보
				var commRegMn = infoUpdateBtn.closest("tr").find("td[name='commRegMn']").text();		//해당 하위코드 등록자
				
				thisForm.find("input[name='commCode']").val(commCode);	//기존의 하위코드를 value값으로 설정
				thisForm.find("input[name='commName']").val(commName);	//기존의 하위코드명을 value값으로 설정
				thisForm.find("input[name='commCodeInfo']").val(commCodeInfo);	//기존의 하위코드 정보를 value값으로 설정
				thisForm.find("input[name='commRegMn']").val(commRegMn);		//기존의 하위코드 등록자를 value값으로 설정
				
				$("#infoUpdateModal").modal({backdrop:'static'},'show');	//하위코드(상세보기) 수정창 동적으로 띄우기
				
			}//commInfoUpdateFunc
			
			$("#infoUpdateModal div[class='modal-footer'] button[name='submitBtn']").on("click",function(){//하위코드(상세보기) 최종수정 버튼을 눌렀을 떄
				
				var thisModal = $("#infoUpdateModal").find("#infoUpdateForm");	//해당 함수에서 반복적으로 사용할 formId
				
				if(thisModal.find("input[name='commName']").val() == ""){	//하위코드명을 입력하지 않았을 때
					alert("코드명을 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commCodeInfo']").val() == ""){	//하위코드 정보를 입력하지 않았을 떄
					alert("코드정보를 입력해주세요.");
					return false;
				}else if(thisModal.find("input[name='commRegMn']").val() == ""){	//하위코드 등록자를 입력하지 않았을 때
					alert("등록자명 입력해주세요.");
					return false;
				}//if
				
				var url = "/spring/commonUpdate.do";
				var frm = $("#infoUpdateModal").find("form").attr("id");	//하위코드 수정창에서의 formId
				
				if(confirm("정말로 수정하시겠습니까?") == true){	//하위코드 최종수정(infoUpdate submit)하기 전에
					commInfoUpdateAjaxFormSubmit(url,frm);	//하위코드 수정 ajax함수 호출
				}else{	//하위코드 최종수정 취소 시
					return false;
				}//if
				
			});
			
			function commInfoUpdateAjaxFormSubmit(url,frm){	//하위코드 수정 ajax함수
				
				paging.ajaxFormSubmit(url,frm,function(result){
					
					if(result == 1){	//정상적으로 수정 되었을 때
						alert("정상적으로 수정되었습니다.");
						location.href = "/spring/commonList.do";
					}else{				//정상적으로 수정 되지 않았을 떄
						alert("수정에 실패하였습니다. 다시 시도해주세요.");
						location.href = "/spring/commonList.do";
					}//if
					
				});
				
			}
			// 공통코드 상세보기에서 코드 수정 //
			
			
			
			// 하위코드(상세보기)에서 코드 삭제 //
			function commInfoDeleteFunc(obj){	//하위코드(상세보기) 삭제 함수
				
				var url = "/spring/commonDelete.do";
				var commCode = obj.parents("tr").find("td[name='commCode']").html();//삭제하려는 해당 하위코드
				var data = {"commCode":commCode};
				
				if(confirm("정말로 삭제하시겠습니까?") == true){	//하위코드 최종삭제(infoDelete submit) 하기 전에
					commInfoDeleteAjaxSubmit(url,data);	//하위코드 삭제 ajax함수 호출
				}else{	//하위코드 최종삭제 취소 시
					return false;
				}//if
			}//commInfoDeleteFunc
			
			function commInfoDeleteAjaxSubmit(url,data){	//하위코드 삭제 ajax함수
				
				paging.ajaxSubmit(url,data,function(result){
					
					if(result == 1){	//정상적으로 삭제 되었을 떄
						alert("정상적으로 삭제되었습니다.");
						location.href = "/spring/commonList.do";
					}else{				//정상적으로 삭제 되지 않았을 떄
						alert("삭제에 실패하였습니다.");
						location.href = "/spring/commonList.do";
					}//if
					
				});
			}
			// 공통코드 상세보기에서 코드 삭제 //
			
			
/* ==================================== 페이징 ============================================ */
 
 
 	pagingList();

	function pagingList(obj){
		
		if(obj==undefined){	//선택한 페이지 값이 안들어왔을 때
			obj = 1;
		}//if
				
		var url = "/spring/commonPaging.do";
		
		var commonSelect = $("#searchPanel select > option:selected").val();	//검색조건
		var commonSearch = $("#searchPanel input[name='commonSearch']").val();	//검색내용
		var data = {"commonSelect":commonSelect,"commonSearch":commonSearch,"selectPageNum":obj};
		
		paging.ajaxSubmit(url,data,function(result){
			
			var allPostNum = result.allPostNum;	//전체 게시물 수
			var postNum = result.postNum;		//화면에 보여줄 게시물 수
			var pageNum = result.pageNum;		//화면에 보여줄 페이지 수
			var selectPageNum = result.selectPageNum;	//선택 페이지
			
			var data = {"allPostNum":allPostNum,"postNum":postNum,
					"pageNum":pageNum,"selectPageNum":selectPageNum};
			
			pagingFunc(data);	//페이징 ajax함수 호출
			
		});
		 	
	}//pagingList
	
	function pagingFunc(data){	//페이징 ajax함수
		
		var data = {"totalNoticeNum":data.allPostNum,
					"choicePage":data.selectPageNum,
					"viewNoticeMaxNum":data.postNum,
					"viewPageMaxNum":data.PageNum};
		
		$("#commList nav[name='pagingNav']").pagingNav(data,function(target){
			
			var commonSelect = $("#searchPanel").find("select[name='commonSelect'] option:selected").val();//검색조건
			var commonSearch = $("#searchPanel").find("input[name='commonSearch']").val();	//검색내용
			var url = "/spring/commonSearchList.do";
			var data = {"commonSelect":commonSelect,"commonSearch":commonSearch,"selectPageNum":target.attr("name")};
			
			commSearchListAjaxSubmit(url,data);
			pagingList(target.attr("name"));
			
		});
		
	}//paging

	
		
	</script>
		
</head>
<body>

</body>
</html>