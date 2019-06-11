package com.example.spring.attendance.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.attendance.service.VacationService;


/* 휴가관련 CONTROLLER
 * 유성실, 신지연 */

//@ReponseBody는 파라미터 값을 뷰에 보내주는 역할

@Controller
public class VacationController {
	
	private static final Logger logger = LoggerFactory.getLogger(VacationController.class);

	@Autowired
	private VacationService vacationService;
	
	/* 휴가관리 메인 대시보드 */
	@RequestMapping(value="/vacationDashboard")
	public String vacationDashboard() {
		return "vacationDashboard";
	}

	/* 휴가일수설정 */
	@RequestMapping(value="/vacationCount")
	public String vacationCount() {
		return "vacationCount";
	}
	
	
	/* 휴가일수설정 사원 리스트 출력 */
	@RequestMapping(value="/vacationCountEmpList.exc")
	public @ResponseBody HashMap<String, Object> vacationCountEmpList(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가개수설정 파라미터: " + map);
		
		List<HashMap<String,Object>> list = vacationService.vacationCountEmpList(map);
		

		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("vacationCountEmpList", list);
			
			if(!(map.get("vacationCountEmpList").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 휴가일수설정 자동 계산 */
	@RequestMapping(value="/vacationCountAutoCalculation.exc")
	public @ResponseBody HashMap<String, Object> vacationCountAutoCalculation(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가일수설정 자동계산 파라미터: " + map);
		
		List<HashMap<String,Object>> list = vacationService.vacationCountAutoCalculation(map);
		

		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("vacationCountAutoCalculation", list);
			
			if(!(map.get("vacationCountAutoCalculation").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	//휴가일수설정 휴가일수 저장하기
	@RequestMapping(value = "/vacationCountUpdate.exc")
	public @ResponseBody HashMap<String,Object> vacationCountUpdate(
			@RequestParam HashMap<String,Object> map) {

		logger.debug("parameter >>>  " + map);

		int list = vacationService.vacationCountUpdate(map);

		if(list == 0) {
			map.put("success", "N");
		}else {
			map.put("success", "Y");
		}

		return map;
	}

	
	/* 휴가일수설정 -사원등록 */
	@RequestMapping(value="/vacationCountEmpSignUp")
	public String vacationCountEmployeeSignUp() {
		return "vacationCountEmpSignUp";
	}
	
	/* 휴가일수설정 - 사원등록 필요 개수 */
	@RequestMapping(value="/vacationCountEmpSignUpCntNum.exc")
	public @ResponseBody int vacationCountEmpSignUpCntNum() {
		
		int empSignUpCntNum = vacationService.vacationCountEmpSignUpCntNum();
			logger.info("휴가일수설정 사원등록 대기 개수: "+empSignUpCntNum);
		
		return empSignUpCntNum;
	} 
	
	/* 휴가일수설정 - 사원등록 리스트 출력 (사원정보 테이블 != 사원별 잔여휴가 테이블)*/
	@RequestMapping(value="/vacationCountEmpSignUpList.exc")
	public @ResponseBody HashMap<String, Object> vacationCountEmpSignUpList(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가일수설정 사원등록 파라미터: " + map);
		
		List<HashMap<String,Object>> list = vacationService.vacationCountEmpSignUpList(map);
		

		if(list == null ) {
			map.put("success", "N");
		}else {
			map.put("vacationCountEmpSignUpList", list);
			
			if(!(map.get("vacationCountEmpSignUpList").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	//휴가일수설정 - 사원등록 저장하기
	@RequestMapping(value = "/vacCntEmpSignUpInsert.exc")
	public @ResponseBody HashMap<String,Object> vacCntEmpSignUpInsert(
			@RequestParam HashMap<String,Object> map) {

		logger.debug("parameter >>>  " + map);

		int list = vacationService.vacCntEmpSignUpInsert(map);

		if(list == 0) {
			map.put("success", "N");
		}else {
			map.put("success", "Y");
		}

		return map;
	}
	

	/* 관리자 or 사원 어떤 버전으로 로그인 했는지 체크(권한부여 때문) */
	@RequestMapping(value="adminChk.exc") 
	public @ResponseBody int adminChk(@RequestParam HashMap<String,Object> map) {
		int adminChk = vacationService.adminChk(map);
		logger.info("adminCHk 컨트롤로----"+adminChk);
		return adminChk;
	}
	

	/* 휴가일수설정에 등록된 사원인지 체크 */
	@RequestMapping(value="empVacChk.exc")
	public @ResponseBody int empVacChk(@RequestParam HashMap<String,Object> map){
				
		int empVacChk = vacationService.empVacChk(map);
		logger.info("empVacCHk컨트롤ㄹ로--------"+empVacChk);
		return empVacChk;
	}
	
	/* 휴가신청: 사원일 경우 사원 정보 나타내기 */
	@RequestMapping(value="empVacInfomation.exc")
	public @ResponseBody List<HashMap<String,Object>> empVacInfomation(
			@RequestParam HashMap<String,Object> map){
		
		List<HashMap<String,Object>> list = vacationService.empVacInfomation(map);
		logger.info("휴가신청하기 사원정보 controller::"+list);
		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("success", "Y");
//			map.put("empVacInfomation",list);
		}

		return list;		
	}
	
	
	/* 휴가 신청하기 */
	@RequestMapping(value="vacationRequest")
	public String vacationRequest() {
		return "vacationRequest";
	}
	
	/* 휴가 신청하기 - 휴가 셀렉박스 리스트 */
	@RequestMapping(value="vacTypeList.exc")
	public @ResponseBody HashMap<String,Object> vacTypeList(
			@RequestParam HashMap<String,Object> map){
		
		List<HashMap<String,Object>> list = vacationService.vacationTypeList(map);
		
		if(list != null) {
			map.put("vacationTypeList", list);
			if(!(map.get("vacationTypeList").toString()).equals("[]")) {
				map.put("success", "Y");
			} else {
				map.put("success", "N");
			}
		} else {
			map.put("success", "N");
		}
		
		return map;
	}
	
	
	/* 휴가 신청 insert */
	@RequestMapping(value = "/vacationRequest.exc")
	public @ResponseBody HashMap<String,String> vatacionRequestInsert(
			@RequestParam HashMap<String,String> map){ 
		
		logger.info("vacationRequest CONTROLL>>>" + map);
		
		int list = vacationService.vacationRequest(map);
			if(list == 0) {
				map.put("success", "N");
			} else{
				map.put("success", "Y");
			}//if

			logger.info("vacationREQ CONTROLLER LIST>>>>" + list);
		return map;
	}
	
	
	/* 신청하기 속 : 사원검색 모달창 : 사원리스트 */
	@RequestMapping(value="/vacationReqEmpList.exc")
	public @ResponseBody HashMap<String,Object> vacationReqEmpList(
			@RequestParam HashMap<String,Object> map){
		
		logger.info("휴가신청사원 모달 CONTROLLER::::" + map);
		
		List<HashMap<String,Object>> list = vacationService.vacationCountEmpList(map);	//휴가명 리스트

		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("vacationReqEmpList", list);
			
			if(!(map.get("vacationReqEmpList").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}//if	
		return map;
	}
	
	
	/* 휴가 조회하기 - 사원 */
	@RequestMapping(value="vacationList")
	public String vacationList() {
		return "vacationList";
	}
	
	/* 휴가조회(사원)-사원별 휴가 개수, 휴가신청내역  */
	@RequestMapping(value="/vacationListSelect.exc")
	public @ResponseBody HashMap<String, Object> vacationListSelect(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가조회(사원): " + map);
		
		List<HashMap<String,Object>> empRemindingVacList = vacationService.vacationListEmpRemindingVac(map); //사원별 휴가개수
		List<HashMap<String,Object>> vacationProgressList = vacationService.vacationProgressList(map); //사원별 휴가개수

		if(empRemindingVacList == null  && vacationProgressList == null) {
			map.put("success", "N");
		}else {
			map.put("empRemindingVacList", empRemindingVacList);
			map.put("vacationProgressList", vacationProgressList);
			
			if(!(map.get("empRemindingVacList").toString()).equals("[]") && 
			   !(map.get("vacationProgressList").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 휴가조회(사원)- 휴가내역 상세보기 모달  */
	@RequestMapping(value="/empVacListDetail.exc")
	public @ResponseBody HashMap<String, Object> empVacListDetail(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가조회(사원): " + map);
		
		List<HashMap<String,Object>> empVacListDetail = vacationService.empVacListDetail(map); //사원별 휴가개수

		if(empVacListDetail == null) {
			map.put("success", "N");
		}else {
			map.put("empVacListDetail", empVacListDetail);
			
			if(!(map.get("empVacListDetail").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 휴가조회(사원)- 휴가내역 수정  */
	@RequestMapping(value="/vacationListUpdate.exc")
	public @ResponseBody HashMap<String, Object> vacationListUpdate(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가조회(사원): " + map);
		
		int vacationListUpdate = vacationService.vacationListUpdate(map); //사원별 휴가개수

		if(vacationListUpdate == 0) {
			map.put("success", "N");
		}else {
			map.put("vacationListUpdate", vacationListUpdate);
			
			if(!(map.get("vacationListUpdate").toString()).equals("0")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 휴가조회(사원)- 휴가내역 삭제  */
	@RequestMapping(value="/vacationListDelete.exc")
	public @ResponseBody HashMap<String, Object> vacationListDelete(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("휴가조회(사원): " + map);
		
		int vacationListDelete = vacationService.vacationListDelete(map); //사원별 휴가개수

		if(vacationListDelete == 0) {
			map.put("success", "N");
		}else {
			map.put("vacationListDelete", vacationListDelete);
			
			if(!(map.get("vacationListDelete").toString()).equals("0")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 휴가 조회하기 - 관리자 페이지 */
	@RequestMapping(value="/vacationListAdmin")
	public String vacationListAdminPage() {
		return "vacationListAdmin";
	}
	
	/* 휴가 조회 리스트 -관리자  */
	@RequestMapping(value="/vacationListAdmin.exc")
	public @ResponseBody HashMap<String,Object> vacationListAdmin(
			@RequestParam HashMap<String,Object> map){
		logger.info("휴가조회관리자 Controller 진입 매개변수>>>>" + map);

//		map.put("totalNoticeNum", vacationService.vacListMaxNum(map)); //리스트 총 개수
		map.put("vacationListAdmin", vacationService.vacationListAdmin(map));	//총 휴가현황 리스트
		
		
		List<HashMap<String,Object>> retType = vacationService.retTypeList(map);	//재직 여부 
		List<HashMap<String,Object>> deptList = vacationService.deptNameList(map);	//부서 셀렉박스
		List<HashMap<String,Object>> rankList = vacationService.rankNameList(map);	//직급 셀렉박스
		List<HashMap<String,Object>> empList = vacationService.vacationListAdmin(map);	//휴가 종류
		
		if(deptList == null || rankList == null || empList == null) {
			map.put("success", "N");
		} else {
			map.put("retTypeList", retType);	//재직여부
			map.put("deptNameList", deptList);	//부서
			map.put("rankNameList", rankList);	//직급
			map.put("vacationList", empList);	//휴가종류

			if(!(map.get("retTypeList").toString()).equals("[]") &&
		 	 !(map.get("deptNameList").toString()).equals("[]") &&
			 !(map.get("rankNameList").toString()).equals("[]")) {
				map.put("success", "Y");
			} else {
				map.put("success", "N");
			}//if	
		}
		return map;
		
	}
	
	/* 휴가조회 관리자 : 사원 휴가 현황 정보 모달창 */
	@RequestMapping(value="empVacationList.exc")
	public @ResponseBody HashMap<String,Object> empVacationList(
			@RequestParam HashMap<String,Object> map){
		logger.info("휴가조회관리자 모달 controller;;;;;" + map);
		
		List<HashMap<String,Object>> empInfo = vacationService.empInfo(map);
		List<HashMap<String,Object>> empVacList = vacationService.empVacList(map);
		List<HashMap<String,Object>> empVacNum = vacationService.empVacNum(map);
		
		if(empInfo == null || empVacList == null || empVacNum == null) {
			map.put("success","N");
		} else {
			map.put("empInfo", empInfo);
			map.put("empVacList", empVacList);
			map.put("empVacNum", empVacNum);
			
			if(!(map.get("empInfo").toString()).equals("[]") &&
		 	 !(map.get("empVacList").toString()).equals("[]") &&
			 !(map.get("empVacNum").toString()).equals("[]")) {
				map.put("success", "Y");
			} else {
				map.put("success", "N");
			}//if	
		}//if	
		return map;
	}


	/* 휴가 조회 - 승인대기 개수 */
	@RequestMapping(value="/vacationProgCntNum.exc")
	public @ResponseBody int vacationProgCntNum() {
		logger.info("vacation 휴가승인 개수 CONTROLLER///////");
		
		int countNum = vacationService.vacationProgCntNum();
			logger.info("vacation 휴가승인 개수 controller::::"+countNum);
		
		return countNum;
	} 
	
	/* 휴가 신청현황 리스트 */
	@RequestMapping(value="/vacationProgressList")
	public String vacationProgressList() {
		return "vacationProgressList";
	}
	
	
	/* 휴가 신청현황 리스트 결과 페이지 */
	@RequestMapping(value="/vacationProgressList.exc")
	public @ResponseBody HashMap<String,Object> vacationProgressListPage(
			@RequestParam HashMap<String,Object> map) {
		logger.info("vacation 휴가 신청현황 리스 CONTROLLER 진입////");
		
		List<HashMap<String,Object>> deptList = vacationService.deptNameList(map);
        List<HashMap<String,Object>> rankList = vacationService.rankNameList(map);
        List<HashMap<String,Object>> situList = vacationService.situationList(map);
		List<HashMap<String,Object>> list = vacationService.vacationProgressList(map);
		
		if(deptList == null || rankList == null || list == null ) {
			map.put("success", "N");			
		} else {
			map.put("deptNameList", deptList);
            map.put("rankNameList", rankList);
            map.put("situationList", situList);
			map.put("vacationProgressList", list);
			
			if(!(map.get("deptNameList").toString()).equals("[]") &&
				!(map.get("rankNameList").toString()).equals("[]") &&
				!(map.get("situationList").toString()).equals("[]")) {
					map.put("success", "Y");				
			} else {
				map.put("success", "N");	
			}//if
		}//if
		return map;
	}
	
	
	/* 휴가 승인완료 저장 */
	@RequestMapping(value="/vacationProgSave.exc")
	public @ResponseBody HashMap<String,Object> vacationProgressSave(
			@RequestParam HashMap<String,Object> map) {
		logger.info("휴가 승인 완료 저장하기 parameter>>>>" + map);
		
		int list = vacationService.vacationProgressSave(map);
		
		if(list != 0) {
			map.put("success", "Y");
		} else {
			map.put("success", "N");
		}
	
		return map;
	}//승인완료 저장
	
	
	/* 휴가 승인대기 삭제 */
	@RequestMapping(value="vacationDel.exc")
	public @ResponseBody HashMap<String,Object> vacationDelete(
			@RequestParam HashMap<String,Object> map){
		logger.info("휴가 승인대기 삭제 parameter>>>>" + map);

		int list = vacationService.vacationDelete(map);
		
		if(list != 0) {
			map.put("success", "Y");
		} else {
			map.put("success", "N");
		}
		return map;
	}
	
	
	/* 근태마감 */
	@RequestMapping(value="/salMonthlyReport")
	public String salMonthlyReport() {
		return "salMonthlyReport";
	}
	
	/* 휴가 월마감 (보류)*/
	@RequestMapping(value="/vacationMonthlyReport")
	public String vacationMonthlyReport() {
		return "vacationMonthlyReport";
	}
	
}
