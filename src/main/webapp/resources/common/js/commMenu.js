/**
 * 
 */
//side menu 함수
	(function commMenu(){
		
		var pageHref = $(location).attr('href'); //현재 페이지 주소값 저장
		var pageUrl = pageHref.substring(pageHref.lastIndexOf("/")+1); // 설정된 url 값 저장 
		var obj = {};
		obj.mnUrl = pageUrl;
		
		//menu list data ajax로 불러오기
		paging.ajaxSubmit("/spring/navList.ajax",obj,function(data){
			
			var mnPrntNo //부모코드 저장 변수
	    	var mnIdx //menu index 저장 변수 
	    	var thisId // mnPrntNo의 url 저장변수
	    	
			//nav 추가 
			$("#sidebar-nav .sidebar-scroll").append("<nav><ul class='nav'></ul></nav>");
			
			//menu list data each
			$.each(data.navList,function(index,dataThis){
				mnPrntNo = dataThis.mnPrntNo; //부모코드 저장 변수
            	mnIdx = dataThis.mnIdx; //menu index 저장 변수 
          
            	//최상위 메뉴 일때 
            	if(mnPrntNo==0){
					//index 적용 if else
            		if($("#sidebar-nav nav:eq(0)").children("li").length>mnIdx){
            			$("#sidebar-nav .nav:eq(0)>li:eq("+mnIdx+")").before("<li id='nav"+dataThis.mnNo+"'><a href='"+dataThis.mnUrl+"'><span>"+dataThis.mnName+"</span></a></li>")
            		}else{
            			$("#sidebar-nav .nav:eq(0)").append("<li id='nav"+dataThis.mnNo+"'><a href='"+dataThis.mnUrl+"'><span>"+dataThis.mnName+"</span></a></li>");
            		}//if else	
            	
            	}else{
            		//ul 추가 if
            	 	if($("#sidebar-nav #nav"+mnPrntNo).find("ul").length==0){
            			thisId = $("#sidebar-nav #nav"+mnPrntNo).children("a").attr("href"); //부모의 href 저장변수
            			if(thisId!=undefined){
            		 		$("#sidebar-nav #nav"+mnPrntNo).append("<div id='"+thisId.substring(1)+"' class='collapse'><ul class='nav'></ul></div>");
            	 		}//if
                 	}//if
         
                 	$("#sidebar-nav #nav"+mnPrntNo).find("ul:eq(0)").append("<li id='nav"+dataThis.mnNo+"'><a href='"+dataThis.mnUrl+"'><span>"+dataThis.mnName+"</span></a></li>");
                 	
            	}//if else            
			});//each

			//drop menu 적용을 위한 속성 지정
			$("#sidebar-nav a[href^='#']").attr({'data-toggle':'collapse'}).addClass("collapsed").append("<i class='icon-submenu lnr lnr-chevron-left'></i>");

			if(pageUrl.indexOf("#")!=-1){
				pageUrl = pageUrl.substring(0,pageUrl.indexOf("#")-1);
			}//if
			
			var navPrntDiv;
			var navChildDiv;
			
			//현재 페이지의 메뉴에 active 적용 
			if(data.mnPrntMap){
				navPrntDiv = $("#nav"+data.mnPrntMap.mnPrntNo).parents("div.collapse"); 
				navChildDiv = $("#nav"+data.mnPrntMap.mnPrntNo).children("div.collapse");
				
				if(navPrntDiv.length>0){
					navPrntDiv.addClass("in");
					navPrntDiv.prev("a").removeClass("collapsed").addClass("collapse active");
					$("#nav"+data.mnPrntMap.mnPrntNo).children("a").removeClass("collapsed").addClass("collapse active");
				}//if
					
				navChildDiv.addClass("in");	
				navChildDiv.prev("a").removeClass("collapsed").addClass("collapse active");
				$("a[href='"+pageUrl+"']").removeClass("collapsed").addClass("collapse active");
			}//if

		});//paging.ajaxSubmit
		
		//로그아웃처리
		$("#logoutBtn").on("click",function(){
			location.href="logout";
		});//onclick
		
	})();//commonMenu