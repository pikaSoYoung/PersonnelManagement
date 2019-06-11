package com.example.spring.salmanager.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.salmanager.service.PaycMenuService;


@Controller
public class PaycMenuController {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(PaycMenuController.class);
	private String PRE_VIEW_PATH = "/SalManager/payc/";
	@Autowired
	private PaycMenuService paycMenuService;

	
	//-------------------------------- 급여대장 메인 --------------------------------
	
	@RequestMapping(value = "/payc_main")          
	public ModelAndView goEmpMenu(HttpServletRequest request) throws Exception {

		HashMap<String, String> map = new HashMap<String, String>();
		
		ModelAndView mv = new ModelAndView();
		
		paycMenuService.paycList(map);
		System.out.println("paycMenu "+paycMenuService.paycList(map));
		mv.addObject("list", paycMenuService.paycList(map));
		//HashMap<String, String> m1 = paycMenuService.acalPayc(map);
		mv.setViewName("payc_main");

		return mv;

	}
//--------------------------------------------------------------------------------

//--------------------------------newPayc -> makePayc 급여대장 생성폼 --------------------------------

	
	@RequestMapping(value = "makePayc.ajax")  
	public @ResponseBody HashMap<String, String> ajaxFormSubmit( //
			@RequestParam HashMap<String, String> map) {

		map.put("success", "true");

		map.put("pyymm", map.get("pyy") + map.get("pmm"));
		map.put("payyymm", map.get("payyy") + map.get("paymm"));
		map.put("payday", map.get("payyymm") + map.get("paytoday"));
		
		logger.info("(controller) : " + map);

		ModelAndView mv = new ModelAndView();
		paycMenuService.makePaycInsert(map);

		// map.put("deptName", deptName);

		return map;

	}
//-------------------------------------------------------------------------------------------

	
//-------------------------------- 급여대장 월별,이름,지급일 등록 --------------------------	
	
	@RequestMapping(value = "/newPayc.ajax")//
	public @ResponseBody HashMap<String, String> ajaxnewPaycSubmit( //
			@RequestParam HashMap<String, String> map) {
	
		// mv.addObject("year", paycMenuService.getYear());
		// mv.addObject("month", paycMenuService.getMonth());
		// mv.addObject("lastday", paycMenuService.getLastDay());
		// mv.addObject("today", paycMenuService.getToday());

			map.put("yy", String.valueOf(paycMenuService.getYear()));
			
			logger.info("month : "+String.valueOf(paycMenuService.getMonth()));
			map.put("mm" , String.valueOf(paycMenuService.getMonth()));
			

			map.put("ld", String.valueOf(paycMenuService.getLastDay()));
			map.put("today", String.valueOf(paycMenuService.getToday()));

		// mv.setViewName("/SalManager/payc/payc_main");

		return map;
	}
//-------------------------------------------------------------------------------------------------
	
	
//---------------------------------------  급여대장  조회  ----------------------------------------------
	@ResponseBody 
	@RequestMapping(value = "/payc_select.ajax")
	public HashMap<String, Object> payc_select(
			@RequestParam HashMap<String, Object> map) {
		HashMap<String, Object> m1 = new HashMap<String, Object>();
		
		System.out.println("select yymm : "+map);
		List<HashMap<String, Object>> list = paycMenuService.selectPayc(map);
		
		System.out.println("list : "+list);
		m1.put("list", list);
		return m1;
	}
//-------------------------------------------------------------------------------------------------

//---------------------------------------@@@ 전체계산 @@@---------------------------------------------
	@RequestMapping(value = "/payc_acal.ajax")
	public @ResponseBody HashMap<String, Object> payc_acal(
			@RequestParam HashMap<String, Object> map) {

		//logger.info("paycMenuCmap : " + map);
		
		HashMap<String, Object> m1=paycMenuService.acalPayc(map);
		
		logger.info("paycMenuCmap"+m1);
		return m1;
	}
//-------------------------------------------------------------------------------------------------

}
