package com.example.spring.attendance.controller;

import java.util.HashMap;  
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.attendance.service.AttendService;

@Controller
public class AttendController {

	private static final Logger logger = LoggerFactory.getLogger(AttendController.class);
	
	@Autowired
	AttendService attendService;
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [일일근태등록]
	 * 개요    : 
	 * @Author : 이용선
	 * @Date   : 2018.02.06
	 ***************************************************************************************/
	
	//출결관리 - 일일근태등록
		@RequestMapping(value = "/dailAttdReg")
		public String dailAttdReg(
				@RequestParam HashMap<String, String> params, Model model) throws Exception{

			return "dailAttdReg";
		}
	
	//출결관리 - 일일근태등록
	//출근버튼====================================================================
		@RequestMapping(value = "/insertDailAttReg")
		public ModelAndView insertDailAttReg(
				@RequestParam HashMap<String, String> params) throws Exception{
		
			// 1) 촐근값입력
			attendService.insertDailAttReg(params);
			
			// 2) 출근입력값 출력 조회 
			ModelAndView mv = new ModelAndView();
			
			List<HashMap<String, Object>> resultList = attendService.selectInDailAttReg(params); 
			
			mv.addObject("resultList", resultList);
			mv.setViewName("dailAttdReg");
			/*	
			//결과값에 대한 ajax alert 띄울시에 사용 
			if(resultList == null) {
				mv.addObject("success", "N");
			} else {
				mv.addObject("resultList", resultList);
				mv.addObject("success", "Y");
			}
			*/
			return mv;
		}//insert/select
	
	
	//퇴근버튼====================================================================
		@RequestMapping(value = "/updateDailAttReg")
		public ModelAndView updateDailAttReg(
				@RequestParam HashMap<String, String> params)throws Exception{
			
			// 1) 퇴근값입력 update
			attendService.updateDailAttReg(params);
			
			
			// 2) 퇴근입력값 출력 조회 
			ModelAndView mv = new ModelAndView();
			
			mv.addObject("resultList", attendService.selectInDailAttReg(params));
			mv.setViewName("dailAttdReg");
			return mv;
		}//update
	
	
	//검색버튼====================================================================
		@RequestMapping(value="/readDailAttdReg")
		public ModelAndView readDailAttdReg(
				@RequestParam HashMap<String, String> params)throws Exception {
			
			
			logger.debug("attendedDate :" + params.get("attendedDate"));
			logger.debug("empEmno : " + params.get("empEmno"));
			
			ModelAndView mv = new ModelAndView();
			mv.addObject("resultList", attendService.selectInDailAttReg(params));
			mv.setViewName("dailAttdReg");
			return mv;
		}
	
	/*
	//ajax 방식 사용
	@RequestMapping(value = "/insertDailAttReg")
	public @ResponseBody HashMap<String, Object>dailAttRegInsert(
			@RequestParam HashMap<String, String> map){
		
		attendService.insertDailAttReg(map);
		List<HashMap<String, Object>> resultList = attendService.selectDailAttReg(map);
		
		
		//A
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		if(resultList == null) {
			resultMap.put("success", "N");
		} else {
			resultMap.put("success", "Y");
			resultMap.put("resultList", resultList);
		}
		
		return resultMap;
	}
	*/
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [월간 근태 생성/마감]
	 * 개요    : 
	 * @Author : 제영호
	 * @Date   : 2018.01.26
	 ***************************************************************************************/
	
	@RequestMapping(value = "/mnthngAttdCrtCls")
	public String mnthngAttdCrtCls() {
		return "mnthngAttdCrtCls";
	}
	
	@RequestMapping(value="/readMnthngAttdCrtCls")
	public @ResponseBody HashMap<String, Object> readMnthngAttdCrtCls(
			@RequestParam HashMap<String, Object> paramMap
			) {
		
		logger.debug("workYyMm : " + paramMap.get("workYyMm"));
		logger.debug("choicePage : " + paramMap.get("choicePage"));
		logger.debug("viewNoticeMaxNum : " + paramMap.get("viewNoticeMaxNum"));
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("workYyMm", paramMap.get("workYyMm"));
		resultMap.put("resultListCnt", attendService.readMnthngAttdCrtClsCnt(paramMap));
		resultMap.put("resultList", attendService.readMnthngAttdCrtCls(paramMap));
		resultMap.put("resultSttsMap", attendService.readMnthngAttdCrtClsStts(paramMap));
		
		return resultMap;
	}
	
	@RequestMapping(value="/readMnthngAttdCrtClsStts")
	public @ResponseBody HashMap<String, Object> readMnthngAttdCrtClsStts(
			@RequestParam HashMap<String, Object> paramMap
			) {
		
		logger.debug("workYyMm : " + paramMap.get("workYyMm"));
		logger.debug("empEmno : " + paramMap.get("empEmno"));

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultSttsMap", attendService.readMnthngAttdCrtClsStts(paramMap));

		return resultMap;
	}
	
	@RequestMapping(value="/insertMnthngAttdCrtCls")
	public @ResponseBody HashMap<String, Object> insertMnthngAttdCrtCls(
			@RequestParam HashMap<String, Object> paramMap
			){
		
		logger.debug("saveMode : " + paramMap.get("saveMode"));
		logger.debug("empEmno : " + paramMap.get("empEmno"));
		
		int result = attendService.insertMnthngAttdCrtCls(paramMap);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(result > 0) {
			resultMap.put("success", "Y");
		} else {
			resultMap.put("success", "N");
		}
		
		return resultMap;
	}
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [월근태현황]
	 * 개요    : 
	 * @Author : 이용선
	 * @Date   : 2018.02.08
	 ***************************************************************************************/
	
	//사원번호 - 사원정보조회
	@RequestMapping(value = "/mnthAttdStat")
	public String mnthAttdStat() {
		return "mnthAttdStat";
	}
	
	//사원번호 검색 모달(돋보기아이콘)버튼====================================================================
	@RequestMapping(value = "/mAttdSelectEmpList.ajax")
	public @ResponseBody HashMap<String, Object> mAttdSelectEmpList(
			@RequestParam HashMap<String, Object> map){
		
		System.out.println("mAttdSelectEmpList 진입 성공");
		
		List<HashMap<String, Object>> list = attendService.mAttdSelectEmpList(map);
		
		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("success", "Y");
			map.put("empList", list);
		}
		
		return map;
	}
	
	//검색버튼====================================================================
	@RequestMapping(value= "/searchMnthAttdStat")
	public @ResponseBody HashMap<String, Object> searchMnthAttdStat(
			@RequestParam HashMap<String, String> paramMap){
		
		
		logger.debug("workYyMm : " + paramMap.get("workYyMm"));
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultList", attendService.searchMnthAttdStat(paramMap));
		
		return resultMap; //
	}
	
	
	
	
	
	
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [휴일 /연장 /야간근무 조회]
	 * 개요    : 
	 * @Author : 제영호
	 * @Date   : 2018.01.24
	 ***************************************************************************************/
	
	@RequestMapping(value="/hdayExtnNightWorkInqr")
	public String hdayExtnNightWorkInqr() {
		return "hdayExtnNightWorkInqr";
	}
	
	//CRUD-R
/*	@RequestMapping(value="/readHdayExtnNightWorkInqr")
	public ModelAndView readHdayExtnNightWorkInqr(
			@RequestParam HashMap<String, String> paramMap) {
		
		logger.debug("workYyMm : " + paramMap.get("workYyMm"));
		logger.debug("empEmno : " + paramMap.get("empEmno"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("resultList", attendService.readHdayExtnNightWorkInqr(paramMap));
		mv.setViewName("hdayExtnNightWorkInqr");
		return mv;
	}*/
	
	@RequestMapping(value="/readHdayExtnNightWorkInqr")
	public @ResponseBody HashMap<String, Object> readHdayExtnNightWorkInqr(
			@RequestParam HashMap<String, Object> paramMap) {
		
		
		logger.debug("workYyMm : " + paramMap.get("workYyMm"));
		logger.debug("empEmno : " + paramMap.get("empEmno"));
		logger.debug("choicePage : " + paramMap.get("choicePage"));
		logger.debug("viewNoticeMaxNum : " + paramMap.get("viewNoticeMaxNum"));
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("workYyMm", paramMap.get("workYyMm"));
		resultMap.put("empEmno", paramMap.get("empEmno"));
		resultMap.put("resultListCnt", attendService.readHdayExtnNightWorkInqrCnt(paramMap));
		resultMap.put("resultList", attendService.readHdayExtnNightWorkInqr(paramMap));
		
		return resultMap;
	}
	
}
