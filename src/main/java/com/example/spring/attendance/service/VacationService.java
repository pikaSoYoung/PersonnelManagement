package com.example.spring.attendance.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.example.spring.attendance.dao.VacationDao;

/* 휴가 관련  SERVICE 
 * 유성실, 신지연 */

@Service
public class VacationService {

	private static final Logger logger = LoggerFactory.getLogger(VacationService.class);
	
	@Resource(name="vacationDao")
	private VacationDao vacationDao;
	private String PRE_VIEW_PATH = "/vacation/";
	
	
	/* 휴가일수설정  사원 리스트 출력 */
	public List<HashMap<String,Object>> vacationCountEmpList(HashMap<String,Object> map) {
		
		List<HashMap<String,Object>> list = vacationDao.vacationCountEmpList(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	/* 휴가일수설정  자동 계산 */
	public List<HashMap<String,Object>> vacationCountAutoCalculation(HashMap<String,Object> map) {
		
		List<HashMap<String,Object>> list = vacationDao.vacationCountAutoCalculation(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	//휴가일수설정  휴가일수 저장하기
	public int vacationCountUpdate(HashMap<String,Object> map) {
		
		int list = vacationDao.vacationCountUpdate(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	/* 휴가일수설정 - 사원등록 필요 개수 */
	public int vacationCountEmpSignUpCntNum() {
		
		int empSignUpCntNum = vacationDao.vacationCountEmpSignUpCntNum();
			logger.info("vacationProg 휴가승인대기 개수 service >>>> " + empSignUpCntNum);
		
		return empSignUpCntNum;
	}
	
	
	/* 휴가일수설정  사원등록 리스트 출력 (사원정보 테이블 != 사원별 잔여휴가 테이블)*/
	public List<HashMap<String,Object>> vacationCountEmpSignUpList(HashMap<String,Object> map) {
		
		List<HashMap<String,Object>> list = vacationDao.vacationCountEmpSignUpList(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	//휴가일수설정 - 사원등록 저장하기
	public int vacCntEmpSignUpInsert(HashMap<String,Object> map) {
		
		int empVacChk = vacationDao.vacCntEmpSignUpInsert(map);
		
		logger.debug("service>>> " + empVacChk);
		
		return empVacChk;
	}
	
	
	/* 관리자 or 사원 어떤 버전으로 로그인 했는지 체크(권한부여 때문) */
	public int adminChk(HashMap<String,Object> map) {
		int list = vacationDao.adminChk(map);
		return list;
	}
	
	
	/* 휴가일수설정에 등록된 사원인지 체크 */
	public int empVacChk(HashMap<String,Object> map) {
		int list = vacationDao.empVacChk(map);

		logger.debug("service>>> " + list);
		
		return list;
	}
	
	/* 휴가신청: 사원일 경우 사원 정보 나타내기 */
	public List<HashMap<String,Object>> empVacInfomation(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.empVacInfomation(map);
		return list;
	}
	
	
	/* 휴가 신청하기 - 휴가명 셀렉 */
	public List<HashMap<String,Object>> vacationTypeList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.vacationTypeList(map);
		return list;
	}
	
	/* 휴가 신청하기 */
	public int vacationRequest(HashMap<String,String> map) {
		
		logger.info("vacationREQ SERVICE 진입>>>>" + map);
		
		int list = vacationDao.vacationRequest(map); 
			logger.info("vacationREQ SERVICE LIST>>>>" + list);
		
		return list;
	}
	
	/* 휴가조회(사원)-사원별 휴가 개수 */
	public List<HashMap<String,Object>> vacationListEmpRemindingVac(HashMap<String,Object> map) {
		
		List<HashMap<String,Object>> list = vacationDao.vacationListEmpRemindingVac(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
		
	/* 휴가조회(사원)-휴가내역 상세보기 모달 */
	public List<HashMap<String,Object>> empVacListDetail(HashMap<String,Object> map) {
		
		List<HashMap<String,Object>> list = vacationDao.empVacListDetail(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	/* 휴가조회(사원)-휴가내역 수정 */
	public int vacationListUpdate(HashMap<String,Object> map) {
		
		int list = vacationDao.vacationListUpdate(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	/* 휴가조회(사원)-휴가내역 삭제 */
	public int vacationListDelete(HashMap<String,Object> map) {
		
		int list = vacationDao.vacationListDelete(map);
		
		logger.debug("service>>> " + list);
		
		return list;
	}
	
	
	/* 휴가 조회 -관리자 휴가현황 리스트 총 개수  */
//	public int vacListMaxNum(HashMap<String,Object> map) {
//		int list = vacationDao.vacListMaxNum(map);
//		logger.info("총개수SERVICE;;;;;;;;;"+list);
//		return list; 
//	}
	
	/* 휴가 조회하기 - 관리자 */
	public List<HashMap<String,Object>> vacationListAdmin(HashMap<String,Object> map) {
		logger.info("vacation리스트 관리자 SERVICE 진입>>>>" + map);
		 
//		int totalNoticeNum = (Integer)map.get("totalNoticeNum");
//		int choicePage = Integer.parseInt((String)map.get("choicePage"));
//		int choicePage = 1;
//		int viewNoticeMaxNum = 10;
//		int noticeCount= 0; //게시물 시작 순번
		
//		noticeCount = (choicePage-1)*viewNoticeMaxNum;
		
//		map.put("noticeCount", noticeCount);
//		map.put("viewNoticeMaxNum", viewNoticeMaxNum);
		
		List<HashMap<String,Object>> list = vacationDao.vacationListAdmin(map);	
		return list;
	}
	
	/* 휴가 조회 - 퇴직 여부 셀렉박스 */
	public List<HashMap<String,Object>> retTypeList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.retTypeList(map);
		return list;
	}
	
	/* 휴가 조회 - 부서 리스트 셀렉박스 */
	public List<HashMap<String,Object>> deptNameList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.deptNameList(map);
		return list;
	}
	/* 휴가 조회 - 직급 리스트 셀렉박스 */
	public List<HashMap<String,Object>> rankNameList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.rankNameList(map);
		return list;
	}
	
	
	/* 휴가조회-관리자 : 모달 - 상단 사원 정보 */
	public List<HashMap<String,Object>> empInfo(HashMap<String,Object> map){
		logger.info("휴가조회관리자 모달 사원정보 SERvice-------" + map);
		
		List<HashMap<String,Object>> list = vacationDao.empInfo(map);
		return list;
	}
	
	/* 휴가조회-관리자 : 모달 - 휴가 사용 정보 */
	public List<HashMap<String,Object>> empVacList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.empVacList(map);
		return list;
	}
	
	/* 휴가조회-관리자 : 모달 - 하단 휴가 개수 */
	public List<HashMap<String,Object>> empVacNum(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.empVacNum(map);
		return list;
	}


	/* 휴가 신청현황 - 승인대기 개수 */
	public int vacationProgCntNum() {
		logger.info("vacation 휴가승인 개수 SERVICE///////");
		
		int countNum = vacationDao.vacationProgCntNum();
			logger.info("vacationProg 휴가승인대기 개수 service >>>> " + countNum);
		
		return countNum;
	}
	
	/* 휴가 신청현황 - 승인대기 셀렉박스 */
	public List<HashMap<String,Object>> situationList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = vacationDao.situationList(map);
		return list;
	}
	
	/* 휴가 신청현황 리스트 */
	public List<HashMap<String,Object>> vacationProgressList(HashMap<String,Object> map){
		logger.info("vacation 휴가승인 리스트 SERVICE///////");
		
		List<HashMap<String,Object>> list= vacationDao.vacationProgressList(map);
		logger.info("vacationREQ service LIST>> " + list);
		return list;
	}
	
	
	/* 휴가 승인완료 저장 */
	public int vacationProgressSave(HashMap<String,Object> map){
		logger.info("휴간신청 승인완료 저장 SERVICE 진입 --->>>>");
		
		int list = vacationDao.vacationProgressSave(map);
			logger.info("승인대기 SERVICE 맵::" + map);
		return list;
	}
	
	/* 휴가 승인대기 삭제 */
	public int vacationDelete(HashMap<String,Object> map) {
		
		int list = vacationDao.vacationDelete(map);
			logger.info("승인대기 삭제 SERVICE 맵:::"+map);
		return list;
	}
	
	/* 휴가 개수 계산하기 */
	public String vacationCount() {
		return "";
	}
	
	
	/* 휴가 월마감 */
	public String vacationMonthlyReport() {
		return "";
	}
	
	
}
