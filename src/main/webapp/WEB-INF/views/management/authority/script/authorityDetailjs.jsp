<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<script src="/spring/resources/common/management/js/menuTree.js"></script>
<script>
	//event 등록
	var events  = function(){
		$("button[name='classBtn']").on("click",classUpdate); //관리자 등급 업데이트 적용 호출
	};//events
	
	//관리자 등급 업데이트 
	var classUpdate = function(){
		var selOp = $("#classSelect>option:selected"); //등급 select box 에 선택된 옵션
		var selOpIdx = selOp.index($("#classSelect>option")); // selOp의 index
		
		//유효성 검사 if
		if(selOpIdx!=0){
			var data = {"empEmno": $("input[name='empEmno']").val()};
			//관리자 일반사원 구분 if
			if(selOp.val()=="admin"){
				data.empClass = 'Y';
				paging.ajaxSubmit("empClassUpdate.ajax",data,"classUpdateEnd",true);
			}else{
				data.empClass = 'N';
				paging.ajaxSubmit("empClassUpdate.ajax",data,"classUpdateEnd",true);
			}//if else
		}else{
			alert("등급을 선택해주세요.");
		}//if else
	};//classUpdate
	
	//등급 업데이트 결과 
	var classUpdateEnd = function(result){
		
		if(result==1){
			alert("성공하였습니다.");
			window.location.href = "authorityMain.do";
		}else{
			alert("실패하였습니다.");
		}//if else
	};//classUpdateEnd
	
	//메뉴 리스트 출력 ajax
	paging.ajaxSubmit("menuList.ajax","",function(result){
	
		 $("#tree").ssTree(result.data); // 메뉴리스트 정렬
		 
		 $("#tree li").on('click',function(e){
			 var thisObj = $(this);
			//현재 대상외 class 삭제
	         $("#tree li.current").removeClass("current");
	         //대상 class 추가
	         thisObj.addClass("current");
	         //메뉴 오픈
	         thisObj.openMenu(e);
	         //메뉴 권한 상세 테이블 호출
	         
	        authorityData(thisObj.attr("id"));
	         
		 });//메뉴 li onclick event
	},true);//paging ajaxSubmit
	
	//권한 상세정보 출력
	var authorityData = function(mnNo){
		//보낼 데이터 객체 (사원코드,메뉴코드)
		var dataObj = {"empEmno": $("input[name='empEmno']").val(),"mnNo":mnNo}; 
		paging.ajaxSubmit("authorityData.do",dataObj,function(html){
			authoMenuTable(html);
	     	$("button[name='insertBtn']").on("click",function(){
		  		authorityForm("authorityInsertForm.do"); 
		  	});  
         
        	$("button[name='updateBtn']").on("click",function(){
         	 	authorityForm("authorityUpdateForm.do");
        	});
		},true,"html");	
	}//authorityData
	
	//메뉴 권한 테이블 출력
	var authoMenuTable = function(html){
		$("div[name='detail']").html(html); //메뉴 권한 테이블 html 출력
		
		//datepicker 적용 
		$(".datepicker.fini").datetimepicker({ 
	         format : 'YYYY-MM-DD',
	         useCurrent: false
	    }); 

		$(".datepicker.strt").datetimepicker({ 
	         format : 'YYYY-MM-DD'
	    }); 

		$("#atrAplyStrt").on("dp.change", function (e) {
	        $('#atrAplyFini').data("DateTimePicker").minDate(e.date);
	    });
		
	    $("#atrAplyFini").on("dp.change", function (e) {
	        $("#atrAplyStrt").data("DateTimePicker").maxDate(e.date);
	    });
	    
	    $("#atrUpdtStrt").on("dp.change", function (e) {
	        $('#atrUpdtFini').data("DateTimePicker").minDate(e.date);
	    });
		
	    $("#atrUpdtFini").on("dp.change", function (e) {
	        $("#atrUpdtStrt").data("DateTimePicker").maxDate(e.date);
	    });
		
		//등록 버튼 이벤트 등록
		$("[name='authoInsertSubmit']").on("click",function(){
			authorityInsert();
		});
		
		//업데이트 이벤트 등록
		$("[name='authoUpdateSubmit']").on("click",function(){
			authorityUpdate();
		});
		
		//취소버튼 이벤트 등록
		$("[name='authoEsc']").on("click",function(){
			location.href="authorityMain.do";
		});
		 
	};//authoMenuTable
	
	events(); //이벤트 등록 함수 호출
	
	//메뉴 권한 입력 폼 출력 
	var authorityForm = function(url){
		//보낼 데이터 객체 (사원코드,메뉴코드)
		var dataObj = {"empEmno":$("input[name='empEmno']").val(),"mnNo":$("#mnNo").attr("name")};
		
		paging.ajaxSubmit(url,dataObj,"authoMenuTable",true,"html");//paging.ajaxSubmi
	};//authorityForm
	
	//메뉴권한 등록 
	var authorityInsert = function(){
		paging.ajaxFormSubmit("authorityInsert.do","insertForm",function(result){
			if(result=="1"){
				alert("등록완료되었습니다.");
				$("#hiddenForm").submit();
			}else{
				alert("등록에 실패하였습니다.")
			}//if else
		});//paging.ajaxFormSubmit
	};//authorityInsert

	//메뉴권한 업데이트 
	var authorityUpdate = function(){
		paging.ajaxFormSubmit("authorityUpdate.exc","updateForm",function(result){
			if(result=="1"){
				alert("업데이트에 성공하였습니다.");
				$("#hiddenForm").submit();
			}else{
				alert("업데이트에 실패하였습니다.");
			}//if else
		});//paging.ajaxFormSubmit
	};//authorityUpdate
	
</script>