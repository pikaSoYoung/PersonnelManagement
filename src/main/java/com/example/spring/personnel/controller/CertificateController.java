package com.example.spring.personnel.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.personnel.service.CertificateService;
import com.mysql.cj.core.log.LogFactory;

@Controller
public class CertificateController {
	
	private static final Logger logger = LoggerFactory.getLogger(CertificateController.class); 
	
	@Autowired
	private CertificateService certificateService;
	
	
	//증명서발급메인화면 
	@RequestMapping(value="certificateIssue.do")
	public ModelAndView certificateIssue(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
				
		System.out.println("session : " + session.getAttribute("userEmno"));
		
		String emno = String.valueOf(session.getAttribute("userEmno"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("empInfo",certificateService.empInfo(emno));
		mv.setViewName("certificateIssue");
		
		return mv;
	}
	
	//증명서 정보 가져오기(관리자)
	@RequestMapping(value="certificateList.do")
	public @ResponseBody HashMap<String, Object> certificateList(@RequestParam HashMap<String, Object> map){
		
		map.put("certificateMaxNum", certificateService.certificateMaxNum(map));
		map.put("crtfList", certificateService.certificateList(map));
		
		return map;
	}
	
	//증명서 정보 가져오기(사원)
	@RequestMapping(value="certificateListEmp.do")
	public @ResponseBody HashMap<String, Object> certificateListEmp(@RequestParam HashMap<String, Object> map){
		
		map.put("certificateMaxNum", certificateService.certificateMaxNum(map));
		map.put("crtfList", certificateService.certificateList(map));
	
		return map;
	}
	
	//사원정보가져오기
	@RequestMapping(value="empInfo.do")
	public @ResponseBody HashMap<String, Object> empInfo(@RequestParam String emno){
		System.out.println("empInfo controller emno : " + emno);
		HashMap<String, Object> map = certificateService.empInfo(emno);
		
		return map;
	}
	
	//증명서 상세보기
	@RequestMapping(value="certificateSearchInfo.exc")
	public @ResponseBody HashMap<String, Object> certificateSearchInfo(@RequestParam int crtfSeq){
		
		HashMap<String, Object> map = certificateService.certificateSearchInfo(crtfSeq);
		
		return map;
	}
	
	//재직증명서
	@RequestMapping(value="workCertificate.exc")
	public ModelAndView workCertificate(@RequestParam HashMap<String, Object> map) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("workMap",certificateService.workCertificate(map));
		mv.setViewName("personnel/certificate/workCertificate");
		
		return mv;
	}
	
	//경력증명서
	@RequestMapping(value="carriereCertificate.exc")
	public String carriereCertificate() {
			
		return "personnel/certificate/carriereCertificate";
	}
		
	//퇴직증명서
	@RequestMapping(value="rtirementCertificate.exc")
	public String rtirementCertificate() {
			
		return "personnel/certificate/rtirementCertificate";
	}
	
	//증명서 신청
	@RequestMapping(value="certificateInsert.do")
	public @ResponseBody int certificateInsert(@RequestParam HashMap<String, Object> map) {
		
		int result = certificateService.certificateInsert(map);
			
		return result;
	}
	
	//증명서신청 메인
	@RequestMapping(value="certificateRequest.do")
	public ModelAndView certificateRequest(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		logger.debug("sessionTest--------------------------- " + session.getAttribute("userEmno"));
		
		ModelAndView mv = new ModelAndView();

		mv.addObject("userEmno", session.getAttribute("userEmno"));
		mv.setViewName("certificateRequest");
		
		return mv;
		
	}//certificateRequest
	
	//증명서신청 시 사원정보
	@RequestMapping(value="certificateRequestEmpInfo.do")
	public @ResponseBody HashMap<String,String> certificateRequestEmpInfo(@RequestParam(value="empEmno") String empEmno){
		
		HashMap<String,String> map = certificateService.certificateRequestEmpInfo(empEmno);
		
		return map;
		
	}//certificateRequestEmpInfo
	
	//증명서 신청내역 목록
	@RequestMapping(value="certificateRequestList.do")
	public @ResponseBody List<HashMap<String,Object>> certificateRequestList(@RequestParam HashMap<String,Object> paramMap){
		
		List<HashMap<String,Object>> list = certificateService.certificateRequestList(paramMap);
		
		return list;
		
	}//certificateRequestList
	
	//증명서 삭제
	@RequestMapping(value="certificateDelete.exc")
	public @ResponseBody int certificateDelete(@RequestParam HashMap<String, Object> map) {
		
		int result = certificateService.certificateDelete(map);
		
		return result;
	}
	
	
}
